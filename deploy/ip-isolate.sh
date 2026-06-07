#!/bin/bash
# ═══════════════════════════════════════════════════════════
#  WhatsApp IP Isolation — Per-Tenant WARP Proxy
#  Gives each OpenClaw tenant a unique Cloudflare exit IP
#  so WhatsApp sees independent devices.
#
#  Usage: ./ip-isolate.sh <tenant-name> [socks-port]
#  Example: ./ip-isolate.sh acme-corp 40010
# ═══════════════════════════════════════════════════════════

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/config.sh"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
log()  { echo -e "${GREEN}[✓]${NC} $*"; }
warn() { echo -e "${YELLOW}[!]${NC} $*"; }
err()  { echo -e "${RED}[✗]${NC} $*" >&2; }
info() { echo -e "${CYAN}[→]${NC} $*"; }

# ─── Args ────────────────────────────────────────────────
TENANT_NAME="${1:-}"
SOCKS_PORT="${2:-}"

if [ -n "$TENANT_NAME" ] && [[ ! "$TENANT_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
  err "Invalid tenant name: $TENANT_NAME (only a-z, A-Z, 0-9, -, _ allowed)"
  exit 1
fi

if [ -z "$TENANT_NAME" ]; then
  echo "Usage: $0 <tenant-name> [socks-port]"
  echo ""
  echo "Examples:"
  echo "  $0 acme-corp           # auto-assign port"
  echo "  $0 acme-corp 40010    # specific port"
  echo ""
  echo "This script:"
  echo "  1. Registers a free Cloudflare WARP account for the tenant"
  echo "  2. Installs wireproxy (~4MB RAM) as a SOCKS5 proxy"
  echo "  3. Sets ALL_PROXY in the tenant's .env"
  echo "  4. Restarts the tenant container"
  echo ""
  echo "Each tenant gets a unique Cloudflare IP for WhatsApp."
  exit 1
fi

if [ ! -f "$CONFIG_FILE" ]; then
  err "Missing config: $CONFIG_FILE"
  exit 1
fi

source "$CONFIG_FILE"

SERVER_USER="${SERVER_USER:-root}"
SERVER_PORT="${SERVER_PORT:-22}"
if [ -z "${REMOTE_HOME:-}" ]; then
  if [ "$SERVER_USER" = "root" ]; then
    REMOTE_HOME="/root"
  else
    REMOTE_HOME="/home/$SERVER_USER"
  fi
fi
REMOTE_OPENCLAW_HOME="${REMOTE_OPENCLAW_HOME:-$REMOTE_HOME/.openclaw}"
REMOTE_CONFIG_HOME="${REMOTE_CONFIG_HOME:-$REMOTE_HOME/.config}"

validate_remote_path() {
  if ! [[ "$1" =~ ^/[a-zA-Z0-9._/-]+$ ]]; then
    err "Invalid remote path: $1"
    exit 1
  fi
}
validate_remote_path "$REMOTE_HOME"
validate_remote_path "$REMOTE_OPENCLAW_HOME"
validate_remote_path "$REMOTE_CONFIG_HOME"

# ─── SSH Setup ───────────────────────────────────────────
SSH_OPTS="-o StrictHostKeyChecking=accept-new -o ConnectTimeout=10"
[ -n "${SSH_KEY:-}" ] && SSH_OPTS="$SSH_OPTS -i $SSH_KEY"

SSHPASS_PREFIX=""
if [ -n "${SSH_PASS:-}" ]; then
  command -v sshpass &>/dev/null || { err "sshpass required: brew install sshpass"; exit 1; }
  PW_FILE=$(mktemp "${TMPDIR:-/tmp}/.sdr-ip-pw.XXXXXX")
  chmod 600 "$PW_FILE"
  python3 -c "
import sys, os
with open(sys.argv[2], 'w') as f: f.write(sys.argv[1])
os.chmod(sys.argv[2], 0o600)
" "$SSH_PASS" "$PW_FILE"
  SSHPASS_PREFIX="sshpass -f $PW_FILE"
  SSH_OPTS="$SSH_OPTS -o PubkeyAuthentication=no"
fi

SSH_CMD="$SSHPASS_PREFIX ssh $SSH_OPTS -p ${SERVER_PORT:-22} ${SERVER_USER}@${SERVER_HOST}"

cleanup_pw() { [ -n "${PW_FILE:-}" ] && shred -u "$PW_FILE" 2>/dev/null || rm -f "${PW_FILE:-}"; }
trap cleanup_pw EXIT

remote() { $SSH_CMD "$@"; }

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  WhatsApp IP Isolation — $TENANT_NAME"
echo "═══════════════════════════════════════════════════════════"
echo ""
info "Server: ${SERVER_USER}@${SERVER_HOST}:${SERVER_PORT:-22}"
info "OpenClaw Home: ${REMOTE_OPENCLAW_HOME}"
if [ "$SERVER_USER" != "root" ]; then
  warn "IP isolation installs system services; non-root users need passwordless privileges for /usr/local/bin, /etc/suiwarp, and systemd."
fi

# ─── Step 1: Test connection & detect architecture ───────
info "Step 1/5: Checking server..."
ARCH=$(remote "uname -m")
case "$ARCH" in
  x86_64)  ARCH_SUFFIX="amd64" ;;
  aarch64) ARCH_SUFFIX="arm64" ;;
  *) err "Unsupported architecture: $ARCH"; exit 1 ;;
esac
log "Connected ($ARCH)"

# ─── Step 2: Install wgcf + wireproxy if needed ─────────
info "Step 2/5: Checking tools..."

WGCF_VERSION="2.2.22"
WIREPROXY_VERSION="1.0.9"

remote "
  if ! command -v wgcf &>/dev/null; then
    curl -sL 'https://github.com/ViRb3/wgcf/releases/download/v${WGCF_VERSION}/wgcf_${WGCF_VERSION}_linux_${ARCH_SUFFIX}' \
      -o /usr/local/bin/wgcf && chmod +x /usr/local/bin/wgcf
    echo 'wgcf installed'
  else
    echo 'wgcf already installed'
  fi

  if ! command -v wireproxy &>/dev/null; then
    curl -sL 'https://github.com/pufferffish/wireproxy/releases/download/v${WIREPROXY_VERSION}/wireproxy_linux_${ARCH_SUFFIX}.tar.gz' \
      -o /tmp/wireproxy.tar.gz
    tar -xzf /tmp/wireproxy.tar.gz -C /tmp/ wireproxy 2>/dev/null || true
    mv /tmp/wireproxy /usr/local/bin/ 2>/dev/null || true
    chmod +x /usr/local/bin/wireproxy
    rm -f /tmp/wireproxy.tar.gz
    echo 'wireproxy installed'
  else
    echo 'wireproxy already installed'
  fi

  mkdir -p /etc/suiwarp
"
log "Tools ready"

# ─── Step 3: Register WARP + generate WireGuard profile ─
info "Step 3/5: Registering WARP account for $TENANT_NAME..."

remote "
  CONF='/etc/suiwarp/wgcf-${TENANT_NAME}.toml'
  PROF='/etc/suiwarp/wgcf-${TENANT_NAME}.conf'

  if [ -f \"\$CONF\" ]; then
    echo 'WARP account already exists'
  else
    cd /tmp
    echo 'y' | wgcf register --config \"\$CONF\" 2>&1 | tail -3
  fi

  if [ ! -f \"\$PROF\" ]; then
    wgcf generate --config \"\$CONF\" --profile \"\$PROF\" 2>&1 | tail -2
  fi

  echo '---PROFILE---'
  cat \"\$PROF\"
"

log "WARP account registered"

# ─── Step 4: Auto-assign port & create wireproxy service ─
info "Step 4/5: Setting up SOCKS5 proxy..."

# Auto-assign port if not specified
if [ -z "$SOCKS_PORT" ]; then
  SOCKS_PORT=$(remote "
    # Find next available port starting from 40001
    for p in \$(seq 40001 40099); do
      if ! ss -tlnp | grep -q \":\$p \"; then
        echo \$p
        break
      fi
    done
  ")
  if [ -z "$SOCKS_PORT" ]; then
    err "No available port in range 40001-40099"
    exit 1
  fi
fi

info "  SOCKS5 port: $SOCKS_PORT"

remote "
  # Extract WireGuard params
  PROF='/etc/suiwarp/wgcf-${TENANT_NAME}.conf'
  WG_PK=\$(grep PrivateKey \"\$PROF\" | awk '{print \$3}')
  WG_V4=\$(grep Address \"\$PROF\" | head -1 | awk '{print \$3}')
  WG_V6=\$(grep Address \"\$PROF\" | tail -1 | awk '{print \$3}')
  WG_PUB=\$(grep PublicKey \"\$PROF\" | awk '{print \$3}')
  WG_EP=\$(grep Endpoint \"\$PROF\" | awk '{print \$3}')

  # Create wireproxy config
  cat > /etc/suiwarp/wireproxy-${TENANT_NAME}.conf << WPEOF
[Interface]
PrivateKey = \$WG_PK
Address = \$WG_V4
Address = \$WG_V6
DNS = 1.1.1.1
MTU = 1280

[Peer]
PublicKey = \$WG_PUB
Endpoint = \$WG_EP
AllowedIPs = 0.0.0.0/0, ::/0

[Socks5]
BindAddress = 127.0.0.1:${SOCKS_PORT}
WPEOF

  # Create systemd service
  cat > /etc/systemd/system/wireproxy-${TENANT_NAME}.service << SVCEOF
[Unit]
Description=WireProxy WARP - ${TENANT_NAME}
After=network.target

[Service]
ExecStart=/usr/local/bin/wireproxy -c /etc/suiwarp/wireproxy-${TENANT_NAME}.conf
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
SVCEOF

  systemctl daemon-reload
  systemctl enable wireproxy-${TENANT_NAME}
  systemctl restart wireproxy-${TENANT_NAME}
  sleep 2

  # Verify
  if ss -tlnp | grep -q ':${SOCKS_PORT} '; then
    echo 'SOCKS5 proxy active'
  else
    echo 'SOCKS5 proxy FAILED'
    exit 1
  fi
"

# Test exit IP
WARP_IP=$(remote "curl -s --max-time 10 -x socks5h://127.0.0.1:${SOCKS_PORT} https://ipinfo.io/ip 2>/dev/null || echo 'pending'")
log "WARP proxy active → exit IP: $WARP_IP"

# ─── Step 5: Inject proxy into tenant container ─────────
info "Step 5/5: Configuring tenant container..."

remote "
  # Find tenant .env (Docker multi-tenant or standalone)
  ENV_FILE=''
	  for path in \
	    '/opt/openclaw/tenants/${TENANT_NAME}/.env' \
	    '$REMOTE_OPENCLAW_HOME/.env'; do
    if [ -f \"\$path\" ]; then
      ENV_FILE=\"\$path\"
      break
    fi
  done

  if [ -n \"\$ENV_FILE\" ]; then
    # Remove old ALL_PROXY if exists
    sed -i '/^ALL_PROXY=/d' \"\$ENV_FILE\"
    echo 'ALL_PROXY=socks5://host.docker.internal:${SOCKS_PORT}' >> \"\$ENV_FILE\"
    echo \"Updated \$ENV_FILE\"

    # Add extra_hosts to docker-compose.yml if needed
    COMPOSE_DIR=\$(dirname \"\$ENV_FILE\")
    COMPOSE_FILE=\"\$COMPOSE_DIR/docker-compose.yml\"
    if [ -f \"\$COMPOSE_FILE\" ] && ! grep -q 'extra_hosts' \"\$COMPOSE_FILE\"; then
      sed -i '/^    networks:/i\\    extra_hosts:\\n      - \"host.docker.internal:host-gateway\"' \"\$COMPOSE_FILE\"
      echo 'Added extra_hosts to docker-compose.yml'
    fi

    # Restart container
    cd \"\$COMPOSE_DIR\" && docker compose up -d 2>&1 | tail -3
    echo 'Container restarted with proxy'
  else
    # Standalone mode: set env for systemd service
    echo \"No Docker .env found, setting proxy in systemd\"
	    UNIT='$REMOTE_CONFIG_HOME/systemd/user/openclaw-gateway.service'
    if [ -f \"\$UNIT\" ] && ! grep -q 'ALL_PROXY' \"\$UNIT\"; then
      sed -i \"/\\[Service\\]/a Environment=ALL_PROXY=socks5://127.0.0.1:${SOCKS_PORT}\" \"\$UNIT\"
      systemctl --user daemon-reload
      systemctl --user restart openclaw-gateway
      echo 'Gateway restarted with proxy'
    fi
  fi
"

log "Tenant $TENANT_NAME configured"

# ─── Done ────────────────────────────────────────────────
DIRECT_IP=$(remote "curl -s --max-time 5 ifconfig.me 2>/dev/null || echo 'unknown'")

echo ""
echo "═══════════════════════════════════════════════════════════"
echo -e "  ${GREEN}✅ IP Isolation Active: $TENANT_NAME${NC}"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "  Server IP:       $DIRECT_IP"
echo "  WARP Exit IP:    $WARP_IP"
echo "  SOCKS5 Port:     $SOCKS_PORT"
echo "  wireproxy RAM:   ~4MB"
echo ""
echo "  WhatsApp will connect through Cloudflare ($WARP_IP)"
echo "  instead of the server's real IP ($DIRECT_IP)."
echo ""
echo "  Commands:"
echo "    Status:  ssh ${SERVER_USER}@${SERVER_HOST} systemctl status wireproxy-${TENANT_NAME}"
echo "    Logs:    ssh ${SERVER_USER}@${SERVER_HOST} journalctl -u wireproxy-${TENANT_NAME} -f"
echo "    Test IP: ssh ${SERVER_USER}@${SERVER_HOST} curl -x socks5h://127.0.0.1:${SOCKS_PORT} ifconfig.me"
echo ""
