#!/usr/bin/env bash
# Loopimir installer for x86-64 Linux (Debian/Ubuntu/Mint). Idempotent: safe to re-run for updates.
#   curl -fsSL https://raw.githubusercontent.com/DaniAeschbach/loopimir/main/scripts/install.sh | bash
set -euo pipefail

REPO="DaniAeschbach/loopimir"
PREFIX="/opt/loopimir"
BAMBU_URL="${BAMBU_URL:-}"               # optional: direct URL to a Bambu Studio .AppImage; else we try the pinned one below
BAMBU_TAG="${BAMBU_TAG:-v02.08.02.61}"   # tested Bambu Studio version; falls back to the newest release if it is gone
DOCS="https://github.com/$REPO/blob/main/docs"

say(){ printf '\033[1;32m==>\033[0m %s\n' "$*"; }
warn(){ printf '\033[1;33m==>\033[0m %s\n' "$*" >&2; }
die(){ printf '\033[1;31m==>\033[0m %s\n' "$*" >&2; exit 1; }
[ "$(id -u)" = 0 ] && SUDO="" || SUDO="sudo"

[ "$(uname -m)" = "x86_64" ] \
  || die "Loopimir needs an x86-64 machine (Intel/AMD). This one is $(uname -m) (e.g. Raspberry Pi), which is not supported."
command -v apt-get >/dev/null \
  || die "This installer targets Debian/Ubuntu/Mint (apt). On other distros install the dependencies manually and run the binary."

# The service runs as the user who started the installer (also when started with sudo).
USER_NAME="${SUDO_USER:-$(id -un)}"
USER_HOME="$(getent passwd "$USER_NAME" | cut -d: -f6)"
[ -n "$USER_HOME" ] || die "Could not find the home folder of user $USER_NAME."
[ "$USER_NAME" != root ] || warn "Installing for the root user. Better: run this as your normal user (it uses sudo where needed)."
DATA="$USER_HOME/.local/share/loopimir"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

say "Installing system packages"
$SUDO apt-get update -qq
# second line: needed for the Bambu Studio send mode (window control, screenshots, text recognition)
$SUDO apt-get install -y -qq python3 python3-pip ffmpeg avahi-daemon libfuse2 xvfb curl ca-certificates fonts-dejavu-core \
  xdotool wmctrl imagemagick tesseract-ocr tesseract-ocr-deu tesseract-ocr-eng >/dev/null

# data folder, created as the service user and readable only by it (it holds the printer access codes)
if [ "$(id -un)" = "$USER_NAME" ]; then mkdir -p "$DATA"; else runuser -u "$USER_NAME" -- mkdir -p "$DATA"; fi
$SUDO chown -R "$USER_NAME" "$DATA"
$SUDO chmod 700 "$DATA"

say "Installing Bambu Studio (used only as a headless slicer)"
$SUDO mkdir -p "$PREFIX/bambu"
if [ ! -x "$PREFIX/bambu/squashfs-root/AppRun" ]; then
  url="$BAMBU_URL"
  if [ -z "$url" ]; then
    # shellcheck disable=SC1091
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
for r in [x for x in rels if x["tag_name"] == os.environ["TAG"]] + rels:   # pinned version first, then newest
    u = pick(r)
    if u:
        print(u); break
' || true)"
    [ -n "$url" ] || die "Could not find a Bambu Studio download. Set BAMBU_URL=<direct .AppImage link> and run again."
  fi
  curl -fL "$url" -o "$TMP/bs.AppImage"
  chmod +x "$TMP/bs.AppImage"
  $SUDO rm -rf "$PREFIX/bambu/squashfs-root"   # leftovers of an interrupted extraction
  ( cd "$PREFIX/bambu" && $SUDO "$TMP/bs.AppImage" --appimage-extract >/dev/null )
fi

say "Installing the Loopimir server"
# Newest release that has the binary; its notes carry the SHA-256 checksum.
info="$(curl -fsSL "https://api.github.com/repos/$REPO/releases" | python3 -c '
import json, re, sys
rels = sorted(json.load(sys.stdin), key=lambda r: r.get("published_at") or "", reverse=True)   # newest first
for r in rels:
    for a in r.get("assets", []):
        if a["name"] == "loopimir-linux-x86_64":
            m = re.search(r"SHA-256:\s*`?([0-9a-fA-F]{64})", r.get("body") or "")
            print(a["browser_download_url"]); print(m.group(1).lower() if m else ""); sys.exit()
' || true)"
bin_url="$(sed -n 1p <<<"$info")"
bin_sha="$(sed -n 2p <<<"$info")"
if [ -n "$bin_url" ]; then
  # download next to the old file and swap it in: works while Loopimir is running (no "Text file busy")
  $SUDO curl -fL "$bin_url" -o "$PREFIX/loopimir.new"
  if [ -n "$bin_sha" ]; then
    if [ "$($SUDO sha256sum "$PREFIX/loopimir.new" | cut -d' ' -f1)" != "$bin_sha" ]; then
      $SUDO rm -f "$PREFIX/loopimir.new"
      die "Checksum of the download does not match - aborting. Nothing was changed."
    fi
  else
    warn "The release notes have no SHA-256 checksum; the download could not be verified."
  fi
  $SUDO chmod 755 "$PREFIX/loopimir.new"
  $SUDO mv -f "$PREFIX/loopimir.new" "$PREFIX/loopimir"
elif [ -x "$PREFIX/loopimir" ]; then
  warn "Could not reach the GitHub releases; keeping the installed version."
else
  die "No released binary found and none installed. Download loopimir-linux-x86_64 from https://github.com/$REPO/releases to $PREFIX/loopimir."
fi

# lets Loopimir replace itself when it self-updates
$SUDO chown "$USER_NAME" "$PREFIX" "$PREFIX/loopimir"

say "Installing the service (starts on boot)"
$SUDO tee /etc/systemd/system/loopimir.service >/dev/null <<UNIT_EOF
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
$SUDO systemctl enable --quiet loopimir.service
$SUDO systemctl restart loopimir.service      # also picks up a freshly installed binary

ip="$(hostname -I 2>/dev/null | awk '{print $1}')"
say "Done. Open  http://${ip:-localhost}:8090  and add your printers (Printers dialog)."
echo "   Logs:    journalctl -u loopimir -f"
echo "   Data:    $DATA"
echo "   Guide:   $DOCS/GUIDE.md   (optional eject board: $DOCS/BOARD.md)"
echo "   Bambu Studio mode (optional, advanced): $DOCS/STUDIO-MODE.md"
