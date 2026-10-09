#!/bin/bash
# Install ECC (https://github.com/affaan-m/ECC) into ~/.claude/
# Usage: ./scripts/install-ecc.sh [--profile minimal|core|full] [--target claude]
set -euo pipefail

ECC_REPO="https://github.com/affaan-m/ECC.git"
ECC_DIR="${ECC_DIR:-$HOME/.cache/ecc}"
PROFILE="core"
TARGET="claude"
EXTRA_ARGS=()

while [ $# -gt 0 ]; do
  case "$1" in
    --profile)
      PROFILE="$2"; shift 2 ;;
    --profile=*)
      PROFILE="${1#--profile=}"; shift ;;
    --target)
      TARGET="$2"; shift 2 ;;
    --target=*)
      TARGET="${1#--target=}"; shift ;;
    --dir)
      ECC_DIR="$2"; shift 2 ;;
    -h|--help)
      sed -n '2,4p' "$0"; exit 0 ;;
    *)
      EXTRA_ARGS+=("$1"); shift ;;
  esac
done

case "$PROFILE" in
  minimal|core|full) ;;
  *) echo "Invalid profile: $PROFILE (expected: minimal|core|full)" >&2; exit 2 ;;
esac

command -v git >/dev/null || { echo "git is required" >&2; exit 1; }
command -v node >/dev/null || { echo "node is required (Claude Code v2.1.0+)" >&2; exit 1; }

if [ -d "$ECC_DIR/.git" ]; then
  echo "==> Updating ECC checkout in $ECC_DIR"
  git -C "$ECC_DIR" fetch --depth 1 origin
  git -C "$ECC_DIR" reset --hard origin/HEAD
else
  echo "==> Cloning ECC into $ECC_DIR"
  mkdir -p "$(dirname "$ECC_DIR")"
  git clone --depth 1 "$ECC_REPO" "$ECC_DIR"
fi

cd "$ECC_DIR"

if [ -f package.json ]; then
  echo "==> Installing npm dependencies"
  npm install --no-audit --no-fund
fi

if [ ! -x ./install.sh ]; then
  echo "install.sh not found or not executable in $ECC_DIR" >&2
  exit 1
fi

echo "==> Running ECC installer: --profile $PROFILE --target $TARGET ${EXTRA_ARGS[*]-}"
./install.sh --profile "$PROFILE" --target "$TARGET" "${EXTRA_ARGS[@]+"${EXTRA_ARGS[@]}"}"

echo
echo "ECC installed (profile=$PROFILE)."
echo "Plugins cannot ship rules; if you want language rules, copy them manually:"
echo "  mkdir -p ~/.claude/rules/ecc"
echo "  cp -R $ECC_DIR/rules/common      ~/.claude/rules/ecc/"
echo "  cp -R $ECC_DIR/rules/typescript  ~/.claude/rules/ecc/   # pick your stack"
