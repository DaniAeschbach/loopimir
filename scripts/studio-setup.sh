#!/usr/bin/env bash
# Loopimir: set up the services for "Bambu Studio" send mode (virtual screen, window manager, Bambu Studio, VNC).
# Run as your normal user (not root), after install.sh:
#   curl -fsSL https://raw.githubusercontent.com/DaniAeschbach/loopimir/main/scripts/studio-setup.sh | bash
# Safe to run again. uninstall.sh removes these services too.
set -euo pipefail

NAME="${NAME:-loopimir}"                                     # service name prefix (the Loopimir default expects "loopimir-bambu")
DISP="${DISP:-:99}"                                          # virtual screen
APPRUN="${APPRUN:-/opt/loopimir/bambu/squashfs-root/AppRun}"
VNC_PORT="${VNC_PORT:-5900}"

say(){ printf '\033[1;32m==>\033[0m %s\n' "$*"; }
die(){ printf '\033[1;31m==>\033[0m %s\n' "$*" >&2; exit 1; }
[ "$(id -u)" != 0 ] || die "Please run this as your normal user, not as root (it uses sudo only where needed)."
[ -x "$APPRUN" ] || die "Bambu Studio not found at $APPRUN. Run install.sh first."
ME="$(id -un)"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

say "Installing openbox and x11vnc"
sudo apt-get install -y -qq openbox x11vnc xvfb >/dev/null

say "Creating the user services"
UD="$HOME/.config/systemd/user"; mkdir -p "$UD"
cat > "$UD/$NAME-display.service" <<EOF
[Unit]
Description=Loopimir virtual screen $DISP
[Service]
ExecStart=/usr/bin/Xvfb $DISP -screen 0 1600x1000x24 -nolisten tcp
Restart=always
[Install]
WantedBy=default.target
EOF
cat > "$UD/$NAME-wm.service" <<EOF
[Unit]
Description=Loopimir window manager (openbox) on $DISP
After=$NAME-display.service
Requires=$NAME-display.service
[Service]
Environment=DISPLAY=$DISP
ExecStartPre=/bin/sleep 2
ExecStart=/usr/bin/openbox
Restart=always
[Install]
WantedBy=default.target
EOF
cat > "$UD/$NAME-bambu.service" <<EOF
[Unit]
Description=Bambu Studio on the virtual screen (signed in, sends prints through the cloud)
After=$NAME-display.service $NAME-wm.service
Requires=$NAME-display.service
[Service]
Environment=DISPLAY=$DISP
Environment=LIBGL_ALWAYS_SOFTWARE=1
Environment=WEBKIT_DISABLE_COMPOSITING_MODE=1
Environment=WEBKIT_DISABLE_DMABUF_RENDERER=1
Environment=GDK_BACKEND=x11
ExecStartPre=/bin/sleep 5
ExecStart=$APPRUN
Restart=on-failure
RestartSec=20
[Install]
WantedBy=default.target
EOF
cat > "$UD/$NAME-vnc.service" <<EOF
[Unit]
Description=Loopimir VNC for $DISP (local only, use an SSH tunnel)
After=$NAME-display.service
Requires=$NAME-display.service
[Service]
ExecStartPre=/bin/sleep 2
ExecStart=/usr/bin/x11vnc -display $DISP -nopw -forever -shared -localhost -rfbport $VNC_PORT -noxdamage -quiet
Restart=always
[Install]
WantedBy=default.target
EOF

say "Starting them (and keeping them running after logout)"
sudo loginctl enable-linger "$ME"
systemctl --user daemon-reload
systemctl --user enable --now "$NAME-display.service" "$NAME-wm.service" "$NAME-vnc.service" "$NAME-bambu.service"

host="$(hostname -I 2>/dev/null | awk '{print $1}')"
cat <<EOF

Done. One thing is left that only you can do: sign in to Bambu Studio on the virtual screen.

 1. On your PC open a tunnel:   ssh -L $VNC_PORT:localhost:$VNC_PORT $ME@${host:-<server-ip>}
 2. Open a VNC viewer (e.g. TigerVNC, RealVNC) and connect to  localhost:$VNC_PORT
 3. In Bambu Studio: sign in, bind your printer and set the language to German.
 4. Save a user preset (copy of your own printer preset), e.g. "Bambu Lab P1S 0.4 nozzle Loopimir", and let it sync to the cloud.
 5. In Loopimir: edit the printer > Send mode: Bambu Studio > check the preset name matches.
 More: https://github.com/DaniAeschbach/loopimir/blob/main/docs/STUDIO-MODE.md
EOF
