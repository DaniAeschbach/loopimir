#!/usr/bin/env bash
# Removes the Loopimir service and program. Your data (~/.local/share/loopimir) is kept unless you pass --purge.
set -euo pipefail
PURGE=0; [ "${1:-}" = "--purge" ] && PURGE=1
[ "$(id -u)" = 0 ] && SUDO="" || SUDO="sudo"
USER_NAME="${SUDO_USER:-$USER}"
DATA="/home/$USER_NAME/.local/share/loopimir"

echo "==> Stopping and removing the service"
$SUDO systemctl disable --now loopimir.service 2>/dev/null || true
$SUDO rm -f /etc/systemd/system/loopimir.service
$SUDO systemctl daemon-reload

echo "==> Removing /opt/loopimir (program and Bambu Studio)"
$SUDO rm -rf /opt/loopimir

if [ "$PURGE" = 1 ]; then
  echo "==> Deleting your data: $DATA"
  rm -rf "$DATA"
else
  echo "Your data is kept in $DATA (run again with --purge to delete it)."
fi
echo "Done. System packages installed by the installer (xvfb, ffmpeg, …) were left in place."
