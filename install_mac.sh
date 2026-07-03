#!/bin/bash
# Sinister's Park Mumble — macOS Setup
set -e

echo "========================================="
echo "  SINISTER'S PARK MUMBLE — macOS Setup"
echo "========================================="

MUMBLE_APP="/Applications/Mumble.app"

# Check if Mumble is already installed
if [ -d "$MUMBLE_APP" ]; then
    echo "[✓] Mumble already installed at $MUMBLE_APP"
else
    echo "[*] Downloading Mumble..."
    curl -L -o /tmp/mumble.dmg "https://dl.mumble.info/latest/stable/client-macos-x64"

    echo "[*] Mounting disk image..."
    hdiutil attach /tmp/mumble.dmg -nobrowse -quiet

    echo "[*] Installing Mumble..."
    cp -R /Volumes/Mumble/Mumble.app /Applications/

    echo "[*] Unmounting..."
    hdiutil detach /Volumes/Mumble -quiet

    rm -f /tmp/mumble.dmg
    echo "[✓] Mumble installed"
fi

# Configure server settings
echo "[*] Configuring Sinister's Park server..."
MUMBLE_DB="$HOME/Library/Application Support/Mumble/Mumble/mumble.sqlite"
if [ -f "$MUMBLE_DB" ]; then
    sqlite3 "$MUMBLE_DB" "INSERT OR IGNORE INTO servers (name, host, port, username) VALUES ('Sinister''s Park', 'sinisterspark.duckdns.org', 64738, '');" 2>/dev/null || true
fi

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
echo "  Opening Mumble..."
open "$MUMBLE_APP"
