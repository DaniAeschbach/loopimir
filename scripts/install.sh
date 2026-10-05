#!/usr/bin/env bash
# Loopimir installer for x86-64 Linux (Debian/Ubuntu/Mint). Idempotent: safe to re-run for updates.
set -euo pipefail

REPO="DaniAeschbach/loopimir"
PREFIX="/opt/loopimir"
BAMBU_URL="${BAMBU_URL:-}"   # optional: direct URL to a Bambu Studio .AppImage; else we try the pinned one below
BAMBU_PINNED="https://github.com/bambulab/BambuStudio/releases/download/v02.00.03.54/Bambu_Studio_linux_ubuntu-v02.00.03.54.AppImage"

say(){ printf '\033[1;32m==>\033[0m %s\n' "$*"; }
need_root(){ [ "$(id -u)" = 0 ] && SUDO="" || SUDO="sudo"; }
need_root

if ! command -v apt-get >/dev/null; then
  echo "This installer targets Debian/Ubuntu/Mint (apt). On other distros install the deps manually and run the binary."; exit 1
fi

say "Installing system packages"
$SUDO apt-get update -qq
# second line: needed for the Bambu Studio send mode (window control, screenshots, text recognition)
$SUDO apt-get install -y -qq python3 python3-pip ffmpeg avahi-daemon libfuse2 xvfb curl ca-certificates fonts-dejavu-core \
  xdotool wmctrl imagemagick tesseract-ocr tesseract-ocr-deu tesseract-ocr-eng >/dev/null

USER_NAME="${SUDO_USER:-$USER}"
DATA="/home/$USER_NAME/.local/share/loopimir"
mkdir -p "$DATA"; chown -R "$USER_NAME" "$DATA" 2>/dev/null || true

say "Installing Bambu Studio (used only as a headless slicer)"
$SUDO mkdir -p "$PREFIX/bambu"
if [ ! -x "$PREFIX/bambu/squashfs-root/AppRun" ]; then
  url="${BAMBU_URL:-$BAMBU_PINNED}"
  tmp="$(mktemp -d)"; curl -fL "$url" -o "$tmp/bs.AppImage"
  chmod +x "$tmp/bs.AppImage"
  ( cd "$PREFIX/bambu" && $SUDO "$tmp/bs.AppImage" --appimage-extract >/dev/null )
  rm -rf "$tmp"
fi

say "Installing the Loopimir server"
# Prefer a released binary; fall back to an already-present one.
bin_url="$(curl -fsSL "https://api.github.com/repos/$REPO/releases" | python3 -c '
import json, sys
rels = sorted(json.load(sys.stdin), key=lambda r: r.get("published_at") or "", reverse=True)   # newest first
for r in rels:
    for a in r.get("assets", []):
        if a["name"] == "loopimir-linux-x86_64":
            print(a["browser_download_url"]); sys.exit()
' || true)"
if [ -n "${bin_url:-}" ]; then
  $SUDO curl -fL "$bin_url" -o "$PREFIX/loopimir"
  $SUDO chmod +x "$PREFIX/loopimir"
elif [ ! -x "$PREFIX/loopimir" ]; then
  echo "No released binary found and none installed. Download loopimir-linux-x86_64 from the Releases page to $PREFIX/loopimir."; exit 1
fi

[ -e "$PREFIX/loopimir" ] && $SUDO chown "$USER_NAME" "$PREFIX" "$PREFIX/loopimir"   # lets Loopimir replace itself when it self-updates

say "Installing the service (starts on boot)"
UNIT="/etc/systemd/system/loopimir.service"
$SUDO tee "$UNIT" >/dev/null <<UNIT_EOF
[Unit]
Description=Loopimir print-farm server
After=network-online.target avahi-daemon.service
Wants=network-online.target

[Service]
User=$USER_NAME
Environment=LOOPIMIR_DATA=$DATA
ExecStart=$PREFIX/loopimir
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
UNIT_EOF
$SUDO systemctl daemon-reload
$SUDO systemctl enable --now loopimir.service

ip="$(hostname -I 2>/dev/null | awk '{print $1}')"
say "Done. Open  http://${ip:-localhost}:8090  and add your printers (Printers dialog)."
echo "   Logs:    journalctl -u loopimir -f"
echo "   Data:    $DATA"
echo "   Guide:   docs/GUIDE.md  (optional eject board: docs/BOARD.md)"
