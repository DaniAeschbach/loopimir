#!/usr/bin/env bash
# Removes the Loopimir service, the Bambu Studio mode services and the program.
# Your data (~/.local/share/loopimir) is kept unless you pass --purge:
#   curl -fsSL https://raw.githubusercontent.com/DaniAeschbach/loopimir/main/scripts/uninstall.sh | bash -s -- --purge
set -euo pipefail
PURGE=0; [ "${1:-}" = "--purge" ] && PURGE=1
[ "$(id -u)" = 0 ] && SUDO="" || SUDO="sudo"
USER_NAME="${SUDO_USER:-$(id -un)}"
USER_HOME="$(getent passwd "$USER_NAME" | cut -d: -f6)"
[ -n "$USER_HOME" ] || { echo "Could not find the home folder of user $USER_NAME." >&2; exit 1; }
DATA="$USER_HOME/.local/share/loopimir"
UD="$USER_HOME/.config/systemd/user"
STUDIO_UNITS=(loopimir-bambu.service loopimir-vnc.service loopimir-wm.service loopimir-display.service)

echo "==> Stopping and removing the service"
$SUDO systemctl disable --now loopimir.service 2>/dev/null || true
$SUDO rm -f /etc/systemd/system/loopimir.service
$SUDO systemctl daemon-reload

if [ -e "$UD/loopimir-display.service" ]; then
  echo "==> Removing the Bambu Studio mode services (studio-setup.sh)"
  user_systemctl(){
    if [ "$(id -un)" = "$USER_NAME" ]; then systemctl --user "$@"
    else runuser -u "$USER_NAME" -- env XDG_RUNTIME_DIR="/run/user/$(id -u "$USER_NAME")" systemctl --user "$@"; fi
  }
  user_systemctl disable --now "${STUDIO_UNITS[@]}" 2>/dev/null || true
  for u in "${STUDIO_UNITS[@]}"; do rm -f "$UD/$u"; done
  user_systemctl daemon-reload 2>/dev/null || true
fi

echo "==> Removing /opt/loopimir (program and Bambu Studio)"
$SUDO rm -rf /opt/loopimir

if [ "$PURGE" = 1 ]; then
  echo "==> Deleting your data: $DATA"
  $SUDO rm -rf "$DATA"
else
  echo "Your data is kept in $DATA (run again with --purge to delete it)."
fi
echo "Done. System packages installed by the installer (xvfb, ffmpeg, …) were left in place."
