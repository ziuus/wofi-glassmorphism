#!/usr/bin/env bash
# install.sh — wofi glass morphic launcher setup
# Usage: ./install.sh

set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/wofi"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔮 Installing wofi glass morphic launcher..."

# Check for wofi
if ! command -v wofi >/dev/null 2>&1; then
    echo "❌ wofi not found. Install it first:"
    echo "   Arch:    sudo pacman -S wofi"
    echo "   Fedora:  sudo dnf install wofi"
    echo "   Nix:     nix-env -iA nixpkgs.wofi"
    exit 1
fi

# Check for compositor with blur support
echo "🔍 Checking compositor..."
if pgrep -x "hyprland" >/dev/null; then
    echo "✅ Hyprland detected — blur will work natively"
elif pgrep -x "sway" >/dev/null; then
    echo "⚠️  Sway detected — needs swayfx or patched sway for blur"
elif pgrep -x "picom" >/dev/null; then
    echo "⚠️  Picom detected — ensure blur backend is configured"
else
    echo "⚠️  No known compositor with blur detected. Glass effect needs backdrop-filter support."
fi

# Create config directory
mkdir -p "$CONFIG_DIR"

# Backup existing config
if [[ -f "$CONFIG_DIR/config" ]]; then
    cp "$CONFIG_DIR/config" "$CONFIG_DIR/config.backup.$(date +%s)"
    echo "📦 Backed up existing config"
fi

if [[ -f "$CONFIG_DIR/style.css" ]]; then
    cp "$CONFIG_DIR/style.css" "$CONFIG_DIR/style.css.backup.$(date +%s)"
fi

# Install configs
cp "$SCRIPT_DIR/config" "$CONFIG_DIR/config"
cp "$SCRIPT_DIR/styles/style.css" "$CONFIG_DIR/style.css"

echo "✅ Config installed to $CONFIG_DIR"

# Update wofi config to use CSS file
if ! grep -q "css-file" "$CONFIG_DIR/config"; then
    echo "css-file=$CONFIG_DIR/style.css" >> "$CONFIG_DIR/config"
    echo "🔗 Linked style.css in config"
fi

# Suggest keybind for hyprland
if pgrep -x "hyprland" >/dev/null; then
    echo ""
    echo "💡 Add to your hyprland.conf:"
    echo "   bindd = , SUPER, exec, wofi --show drun"
    echo ""
fi

echo "🎉 Done! Launch with: wofi --show drun"
echo "   Or add to your keybinds."