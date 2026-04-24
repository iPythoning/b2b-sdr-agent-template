#!/bin/bash
# B2B SDR Agent — One-Line Installer
# Usage: curl -fsSL https://raw.githubusercontent.com/iPythoning/b2b-sdr-agent-template/main/install.sh | bash
# Or:    curl -fsSL https://raw.githubusercontent.com/iPythoning/b2b-sdr-agent-template/main/install.sh | bash -s -- --managed
set -euo pipefail

VERSION_TAG="${SDR_VERSION:-latest}"
REPO="iPythoning/b2b-sdr-agent-template"
OPENCLAW_REPO="openclaw/openclaw"
INSTALL_DIR="${SDR_INSTALL_DIR:-$HOME/b2b-sdr-agent}"
PULSEAGENT_URL="https://pulseagent.io/app"
SIGNUP_URL="${PULSEAGENT_URL}/login?ref=installer&utm_source=cli&utm_medium=oneliner&utm_campaign=sdr-template"
PRICING_URL="${PULSEAGENT_URL}/pricing?ref=installer&utm_source=cli&utm_medium=oneliner&utm_campaign=sdr-template"

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'
CYAN='\033[0;36m'; BOLD='\033[1m'; DIM='\033[2m'; NC='\033[0m'

banner() {
  echo ""
  echo -e "${CYAN}${BOLD}"
  echo "  ____        _           _                    _   "
  echo " |  _ \ _   _| |___  ___|  \  __ _  ___  _ __ | |_ "
  echo " | |_) | | | | / __|/ _ \ / _\` |/ _ \| '_ \| __|"
  echo " |  __/| |_| | \__ \  __/ | (_| |  __/| | | | |_ "
  echo " |_|    \__,_|_|___/\___|\__,_|\___||_| |_|\__|"
  echo -e "${NC}"
  echo -e "${BOLD}  B2B SDR Agent Template — AI Sales Rep for Export Business${NC}"
  echo -e "${DIM}  Powered by OpenClaw | https://github.com/${REPO}${NC}"
  echo ""
}

track_event() {
  # Silent analytics ping — helps understand installer usage
  curl -s -o /dev/null -w "" \
    "${PULSEAGENT_URL}/api/track?event=$1&source=installer&v=${VERSION_TAG}" 2>/dev/null || true
}

show_comparison() {
  echo ""
  echo -e "${BOLD}┌─────────────────────────────────────────────────────────────────┐${NC}"
  echo -e "${BOLD}│            Choose Your Path                                     │${NC}"
  echo -e "${BOLD}├────────────────────────────┬────────────────────────────────────┤${NC}"
  echo -e "${BOLD}│  🔧 Self-Hosted ${DIM}(Free)${NC}${BOLD}      │  ☁️  Managed on PulseAgent ${DIM}(Pro)${NC}${BOLD}   │${NC}"
  echo -e "${BOLD}├────────────────────────────┼────────────────────────────────────┤${NC}"
  echo -e "│  You manage the server     │  ${GREEN}Zero server management${NC}           │"
  echo -e "│  Manual OpenClaw updates   │  ${GREEN}Auto-updates on every release${NC}    │"
  echo -e "│  CLI-only dashboard        │  ${GREEN}Full web dashboard + analytics${NC}   │"
  echo -e "│  Single-tenant             │  ${GREEN}Multi-tenant + team seats${NC}        │"
  echo -e "│  Community support         │  ${GREEN}Priority support + onboarding${NC}    │"
  echo -e "│  DIY WhatsApp setup        │  ${GREEN}Pre-configured WhatsApp API${NC}      │"
  echo -e "│  No CRM integration        │  ${GREEN}Built-in CRM + lead scoring${NC}     │"
  echo -e "│  ~30 min setup             │  ${GREEN}2-min setup, start selling now${NC}   │"
  echo -e "${BOLD}├────────────────────────────┼────────────────────────────────────┤${NC}"
  echo -e "│  ${DIM}Free forever${NC}               │  ${GREEN}${BOLD}Free trial → from \$49/mo${NC}         │"
  echo -e "${BOLD}└────────────────────────────┴────────────────────────────────────┘${NC}"
  echo ""
}

managed_path() {
  track_event "chose_managed"
  echo ""
  echo -e "${GREEN}${BOLD}Great choice! Setting up your managed PulseAgent account...${NC}"
  echo ""
  echo -e "  ${BOLD}1.${NC} Sign up at:  ${CYAN}${SIGNUP_URL}${NC}"
  echo -e "  ${BOLD}2.${NC} Create your first AI SDR agent (2 minutes)"
  echo -e "  ${BOLD}3.${NC} Connect WhatsApp — scan QR code and go live"
  echo ""
  echo -e "  ${GREEN}✓${NC} No server needed    ${GREEN}✓${NC} No technical setup"
  echo -e "  ${GREEN}✓${NC} Free trial included  ${GREEN}✓${NC} Cancel anytime"
  echo ""
  # Try to open browser
  if command -v xdg-open &>/dev/null; then
    xdg-open "$SIGNUP_URL" 2>/dev/null || true
  elif command -v open &>/dev/null; then
    open "$SIGNUP_URL" 2>/dev/null || true
  fi
  echo -e "${BOLD}Opening ${CYAN}${SIGNUP_URL}${NC} in your browser...${BOLD}${NC}"
  echo ""
  echo -e "${DIM}If the browser didn't open, copy-paste the URL above.${NC}"
  exit 0
}

selfhosted_path() {
  track_event "chose_selfhosted"
  echo -e "${YELLOW}→ Self-hosted installation starting...${NC}"
  echo ""

  # Prerequisites check
  echo -e "${BOLD}Checking prerequisites...${NC}"
  local missing=0

  if ! command -v node &>/dev/null; then
    echo -e "  ${RED}✗${NC} Node.js 18+ — ${RED}not found${NC}"
    missing=1
  else
    local node_ver=$(node -v | sed 's/v//' | cut -d. -f1)
    if [ "$node_ver" -lt 18 ]; then
      echo -e "  ${RED}✗${NC} Node.js 18+ — found v$(node -v), need 18+"
      missing=1
    else
      echo -e "  ${GREEN}✓${NC} Node.js $(node -v)"
    fi
  fi

  if ! command -v npm &>/dev/null; then
    echo -e "  ${RED}✗${NC} npm — ${RED}not found${NC}"
    missing=1
  else
    echo -e "  ${GREEN}✓${NC} npm $(npm -v)"
  fi

  if ! command -v git &>/dev/null; then
    echo -e "  ${RED}✗${NC} git — ${RED}not found${NC}"
    missing=1
  else
    echo -e "  ${GREEN}✓${NC} git $(git --version | awk '{print $3}')"
  fi

  command -v jq &>/dev/null && echo -e "  ${GREEN}✓${NC} jq" || echo -e "  ${YELLOW}!${NC} jq — optional, recommended"
  command -v curl &>/dev/null && echo -e "  ${GREEN}✓${NC} curl" || { echo -e "  ${RED}✗${NC} curl"; missing=1; }

  if [ "$missing" -eq 1 ]; then
    echo ""
    echo -e "${RED}Missing required dependencies.${NC} Install them first, or try the managed version:"
    echo -e "  ${CYAN}${SIGNUP_URL}${NC}"
    echo ""
    echo -e "${DIM}Managed PulseAgent requires zero local dependencies — just a browser.${NC}"
    exit 1
  fi

  echo ""

  # Fetch latest OpenClaw version
  echo -e "${BOLD}Fetching latest OpenClaw release...${NC}"
  if command -v gh &>/dev/null; then
    OPENCLAW_VERSION=$(gh api 'repos/openclaw/openclaw/releases?per_page=1' --jq '.[0].tag_name' 2>/dev/null || echo "latest")
  else
    OPENCLAW_VERSION=$(curl -s "https://api.github.com/repos/openclaw/openclaw/releases?per_page=1" | grep -o '"tag_name": *"[^"]*"' | head -1 | cut -d'"' -f4 || echo "latest")
  fi
  echo -e "  ${GREEN}✓${NC} OpenClaw ${OPENCLAW_VERSION}"

  # Install OpenClaw globally
  echo ""
  echo -e "${BOLD}Installing OpenClaw...${NC}"
  npm install -g openclaw 2>&1 | tail -1
  echo -e "  ${GREEN}✓${NC} OpenClaw installed"

  # Clone SDR template
  echo ""
  echo -e "${BOLD}Cloning B2B SDR Agent Template...${NC}"
  if [ -d "$INSTALL_DIR" ]; then
    echo -e "  ${YELLOW}!${NC} Directory exists, pulling latest..."
    cd "$INSTALL_DIR" && git pull --quiet origin main
  else
    git clone --quiet "https://github.com/${REPO}.git" "$INSTALL_DIR"
  fi
  cd "$INSTALL_DIR"
  echo -e "  ${GREEN}✓${NC} Template ready at ${INSTALL_DIR}"

  # Interactive config
  echo ""
  echo -e "${BOLD}━━━ Configuration ━━━${NC}"
  echo -e "${DIM}Press Enter to skip optional fields${NC}"
  echo ""

  # config.sh setup
  if [ -f deploy/config.sh.example ] && [ ! -f deploy/config.sh ]; then
    cp deploy/config.sh.example deploy/config.sh
  fi

  read -p "  Server IP/hostname: " SERVER_HOST
  if [ -z "$SERVER_HOST" ]; then
    echo ""
    echo -e "${YELLOW}No server? No problem.${NC} PulseAgent manages everything for you:"
    echo -e "  ${CYAN}${SIGNUP_URL}${NC}"
    echo ""
    track_event "no_server_redirect"
    exit 0
  fi

  read -p "  SSH user [root]: " SERVER_USER
  SERVER_USER="${SERVER_USER:-root}"

  read -p "  AI API Key (DeepSeek recommended — \$0.14/M input, 1M context): " API_KEY
  if [ -z "$API_KEY" ]; then
    echo ""
    echo -e "${YELLOW}No API key?${NC} PulseAgent includes AI credits — no key needed:"
    echo -e "  ${CYAN}${SIGNUP_URL}${NC}"
    echo ""
    track_event "no_apikey_redirect"
    exit 0
  fi

  read -p "  AI Provider [deepseek]: " PROVIDER
  PROVIDER="${PROVIDER:-deepseek}"

  read -p "  Model ID [deepseek-v4-flash]: " MODEL_ID
  MODEL_ID="${MODEL_ID:-deepseek-v4-flash}"

  read -p "  Enable WhatsApp? [Y/n]: " WA_ENABLED
  WA_ENABLED="${WA_ENABLED:-Y}"

  read -p "  Enable Telegram? [y/N]: " TG_ENABLED
  TG_ENABLED="${TG_ENABLED:-N}"

  read -p "  Company name: " COMPANY_NAME
  COMPANY_NAME="${COMPANY_NAME:-my-company}"

  # Write config
  if [ -f deploy/config.sh ]; then
    sed -i.bak "s|SERVER_HOST=.*|SERVER_HOST=\"${SERVER_HOST}\"|" deploy/config.sh
    sed -i.bak "s|SERVER_USER=.*|SERVER_USER=\"${SERVER_USER}\"|" deploy/config.sh
    sed -i.bak "s|PRIMARY_API_KEY=.*|PRIMARY_API_KEY=\"${API_KEY}\"|" deploy/config.sh
    sed -i.bak "s|PRIMARY_PROVIDER=.*|PRIMARY_PROVIDER=\"${PROVIDER}\"|" deploy/config.sh
    sed -i.bak "s|PRIMARY_MODEL_ID=.*|PRIMARY_MODEL_ID=\"${MODEL_ID}\"|" deploy/config.sh
    rm -f deploy/config.sh.bak
  fi

  echo ""
  echo -e "${BOLD}━━━ Deploying ━━━${NC}"
  echo ""

  # Deploy
  if [ -x deploy/deploy.sh ]; then
    chmod +x deploy/deploy.sh
    ./deploy/deploy.sh "$COMPANY_NAME"
  else
    echo -e "${RED}deploy.sh not found or not executable${NC}"
    exit 1
  fi

  # Success + CTA
  echo ""
  echo -e "${GREEN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${GREEN}${BOLD}  ✅ Your AI SDR is live!${NC}"
  echo -e "${GREEN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo ""
  echo -e "  Dashboard:  ${CYAN}http://${SERVER_HOST}:18789${NC}"
  echo -e "  Template:   ${CYAN}${INSTALL_DIR}${NC}"
  echo ""
  echo -e "${BOLD}━━━ Unlock More with PulseAgent Pro ━━━${NC}"
  echo ""
  echo -e "  You're running the ${DIM}Community${NC} edition. Upgrade to ${GREEN}${BOLD}Pro${NC} for:"
  echo ""
  echo -e "  ${GREEN}▸${NC} Web dashboard with real-time analytics & conversion tracking"
  echo -e "  ${GREEN}▸${NC} Built-in CRM — auto-capture leads, score, and assign"
  echo -e "  ${GREEN}▸${NC} Multi-agent coordination — run 10+ SDRs from one panel"
  echo -e "  ${GREEN}▸${NC} Team seats — sales manager oversight + approval workflows"
  echo -e "  ${GREEN}▸${NC} WhatsApp Business API — no phone needed, verified sender"
  echo -e "  ${GREEN}▸${NC} Auto-scaling — handle 10,000+ leads without server tuning"
  echo -e "  ${GREEN}▸${NC} Priority support + dedicated onboarding call"
  echo ""
  echo -e "  ${BOLD}Start free trial:${NC}  ${CYAN}${SIGNUP_URL}${NC}"
  echo -e "  ${BOLD}See pricing:${NC}       ${CYAN}${PRICING_URL}${NC}"
  echo ""
  echo -e "${DIM}  Tip: Run 'openclaw' to manage your agent. Edit workspace/ files to customize.${NC}"
  echo ""
  track_event "install_complete"
}

# ─── Main ───

banner

# --managed flag: skip straight to managed path
if [[ "${1:-}" == "--managed" || "${1:-}" == "--pro" || "${1:-}" == "--cloud" ]]; then
  managed_path
fi

show_comparison

echo -e "${BOLD}Which path? ${NC}"
echo -e "  ${BOLD}[1]${NC} ☁️  ${GREEN}Managed on PulseAgent${NC} — 2 min setup, free trial ${DIM}(recommended)${NC}"
echo -e "  ${BOLD}[2]${NC} 🔧 Self-hosted — requires server + API key + ~30 min"
echo ""
read -p "  Enter 1 or 2: " choice

case "${choice}" in
  1|"") managed_path ;;
  2) selfhosted_path ;;
  *)
    echo -e "${RED}Invalid choice.${NC} Defaulting to managed..."
    managed_path
    ;;
esac
