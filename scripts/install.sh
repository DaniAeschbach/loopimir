#!/usr/bin/env bash
# Loopimir installer for x86-64 Linux (Debian/Ubuntu/Mint). Idempotent: safe to re-run for updates.
set -euo pipefail

REPO="DaniAeschbach/loopimir"
PREFIX="/opt/loopimir"
BAMBU_URL="${BAMBU_URL:-}"   # optional: direct URL to a Bambu Studio .AppImage; else we try the pinned one below
BAMBU_TAG="${BAMBU_TAG:-v02.08.02.61}"   # tested Bambu Studio version; falls back to the newest release if it is gone

say(){ printf '\033[1;32m==>\033[0m %s\n' "$*"; }
need_root(){ [ "$(id -u)" = 0 ] && SUDO="" || SUDO="sudo"; }
need_root

if [ "$(uname -m)" != "x86_64" ]; then
  echo "Loopimir needs an x86-64 machine (Intel/AMD). This one is $(uname -m) (e.g. Raspberry Pi), which is not supported."; exit 1
fi
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
  url="$BAMBU_URL"
  if [ -z "$url" ]; then
    . /etc/os-release
    case "${UBUNTU_CODENAME:-${VERSION_CODENAME:-}}" in focal|jammy) ubu=22;; *) ubu=24;; esac
    url="$(curl -fsSL "https://api.github.com/repos/bambulab/BambuStudio/releases?per_page=30" | UBU="$ubu" TAG="$BAMBU_TAG" python3 -c '
import json, os, re, sys
rels = json.load(sys.stdin)
def pick(r):
    for a in r.get("assets", []):
        n = a["name"]
        if n.endswith(".AppImage") and re.search(r"ubu(ntu)?%s" % os.environ["UBU"], n):
            return a["browser_download_url"]
for r in [x for x in rels if x["tag_name"] == os.environ["TAG"]] + rels:
    u = pick(r)
    if u:
        print(u); break
' || true)"
    [ -n "$url" ] || { echo "Could not find a Bambu Studio download. Set BAMBU_URL=<direct .AppImage link> and run again."; exit 1; }
  fi
  tmp="$(mktemp -d)"; curl -fL "$url" -o "$tmp/bs.AppImage"
  chmod +x "$tmp/bs.AppImage"
  ( cd "$PREFIX/bambu" && $SUDO "$tmp/bs.AppImage" --appimage-extract >/dev/null )
  rm -rf "$tmp"
fi

say "Installing the Loopimir server"
# Prefer a released binary; fall back to an already-present one.
info="$(curl -fsSL "https://api.github.com/repos/$REPO/releases" | python3 -c '
import json, re, sys
rels = sorted(json.load(sys.stdin), key=lambda r: r.get("published_at") or "", reverse=True)   # newest first
for r in rels:
    for a in r.get("assets", []):
        if a["name"] == "loopimir-linux-x86_64":
            m = re.search(r"SHA-256:\s*`?([0-9a-fA-F]{64})", r.get("body") or "")
            print(a["browser_download_url"]); print(m.group(1) if m else ""); sys.exit()
' || true)"
bin_url="$(printf '%s
' "$info" | sed -n 1p)"; bin_sha="$(printf '%s
' "$info" | sed -n 2p)"
if [ -n "${bin_url:-}" ]; then
  # download next to the old file and swap it in: works while Loopimir is running (no "Text file busy")
  $SUDO curl -fL "$bin_url" -o "$PREFIX/loopimir.new"
  if [ -n "${bin_sha:-}" ] && [ "$($SUDO sha256sum "$PREFIX/loopimir.new" | cut -d' ' -f1)" != "$(printf '%s' "$bin_sha" | tr 'A-F' 'a-f')" ]; then
    $SUDO rm -f "$PREFIX/loopimir.new"; echo "Checksum of the download does not match - aborting."; exit 1
  fi
  $SUDO chmod +x "$PREFIX/loopimir.new"
  $SUDO mv -f "$PREFIX/loopimir.new" "$PREFIX/loopimir"
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
NoNewPrivileges=true
RestrictSuidSgid=true
LockPersonality=true
ProtectKernelModules=true

[Install]
WantedBy=multi-user.target
UNIT_EOF
$SUDO systemctl daemon-reload
$SUDO systemctl enable loopimir.service
$SUDO systemctl restart loopimir.service      # also picks up a freshly installed binary

ip="$(hostname -I 2>/dev/null | awk '{print $1}')"
say "Done. Open  http://${ip:-localhost}:8090  and add your printers (Printers dialog)."
echo "   Logs:    journalctl -u loopimir -f"
echo "   Data:    $DATA"
echo "   Guide:   docs/GUIDE.md  (optional eject board: docs/BOARD.md)"
echo "   Bambu Studio mode (optional, advanced): curl -fsSL https://raw.githubusercontent.com/$REPO/main/scripts/studio-setup.sh | bash   (docs/STUDIO-MODE.md)"
