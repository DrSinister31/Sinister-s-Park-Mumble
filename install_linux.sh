#!/bin/bash
# Sinister's Park Mumble — Linux Setup
set -e

echo "========================================="
echo "  SINISTER'S PARK MUMBLE — Linux Setup"
echo "========================================="

# Detect package manager
if command -v apt-get &>/dev/null; then
    PKG_MGR="apt"
    INSTALL_CMD="sudo apt-get install -y mumble"
elif command -v dnf &>/dev/null; then
    PKG_MGR="dnf"
    INSTALL_CMD="sudo dnf install -y mumble"
elif command -v pacman &>/dev/null; then
    PKG_MGR="pacman"
    INSTALL_CMD="sudo pacman -S --noconfirm mumble"
elif command -v flatpak &>/dev/null; then
    PKG_MGR="flatpak"
    INSTALL_CMD="flatpak install -y flathub info.mumble.Mumble"
else
    echo "[✗] Could not detect package manager. Install Mumble manually from https://www.mumble.info"
    exit 1
fi

# Check if Mumble is already installed
if command -v mumble &>/dev/null; then
    echo "[✓] Mumble already installed ($(which mumble))"
elif command -v mumble-client &>/dev/null; then
    echo "[✓] mumble-client already installed ($(which mumble-client))"
else
    echo "[*] Installing Mumble via $PKG_MGR..."
    eval "$INSTALL_CMD"
    echo "[✓] Mumble installed"
fi

# Configure server settings
echo "[*] Configuring Sinister's Park server..."
MUMBLE_CONF="$HOME/.config/Mumble/Mumble.conf"
mkdir -p "$(dirname "$MUMBLE_CONF")"
cat >> "$MUMBLE_CONF" << 'EOF'
[Server]
sinisterspark.duckdns.org:64738
EOF

echo ""
echo "========================================="
echo "  SETUP COMPLETE"
echo "========================================="
echo ""
echo "  Server:  sinisterspark.duckdns.org"
echo "  Port:    64738"
echo ""
echo "  TO LINK YOUR VOICE:"
echo "  1. Join The Isle: Evrima — Sinister's Park"
echo "  2. Ask SPS on Discord: 'verify my voice'"
echo "  3. Check Discord DMs for a code"
echo "  4. In Mumble, type: !verify <code>"
echo "  5. Done — voice auto-sorts by location"
echo ""
echo "  Launching Mumble..."
mumble &>/dev/null &
