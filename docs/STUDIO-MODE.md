# Bambu Studio mode (advanced) / Bambu‑Studio‑Weg

> **Beta · one printer.** Use LAN mode ([Guide](GUIDE.md)) unless you want the printer to stay in the Bambu cloud. Tuned for a **German** Bambu Studio on a **1600×1000** virtual screen; needs manual setup.

## English

Bambu printers only accept start commands **signed by Bambu's apps**. In Studio mode Loopimir operates **your signed‑in Bambu Studio** on a virtual screen — Bambu Studio signs and sends the job. The printer stays in the cloud (Handy app and MakerWorld keep working). Loopimir still slices, checks the file strictly, and prepares the next job while one is printing.

**Setup**
1. Install as usual (the installer adds Bambu Studio and the tools).
2. Create three **user services** in `~/.config/systemd/user/`: a virtual screen (`Xvfb :99 -screen 0 1600x1000x24`), a window manager (`openbox`), and Bambu Studio (`/opt/loopimir/bambu/squashfs-root/AppRun`, with `DISPLAY=:99 LIBGL_ALWAYS_SOFTWARE=1 GDK_BACKEND=x11`). Name the last one `loopimir-bambu`. Enable them and run `loginctl enable-linger $USER`.
3. Once, look at the virtual screen (x11vnc through an SSH tunnel), **sign in**, bind the printer, set the **language to German**.
4. In Bambu Studio save a **user preset** (copy of your printer's preset) named `Bambu Lab P2S 0.4 nozzle Loopimir` and let it sync to the cloud. Another name → set `"studio": {"preset_name": "…"}` in `config.json`.
5. In Loopimir: edit the printer → **Send mode: Bambu Studio** (IP and access code are still needed). Only one printer can use this mode.

## Deutsch

Bambu‑Drucker nehmen nur von Bambus Apps **signierte** Startbefehle an. Im Studio‑Weg bedient Loopimir **dein angemeldetes Bambu Studio** auf einem virtuellen Bildschirm; Bambu Studio signiert und sendet. Der Drucker bleibt in der Cloud. Loopimir slict und prüft weiterhin streng und bereitet den nächsten Auftrag schon beim Drucken vor.

**Einrichtung:** Drei Benutzer‑Dienste anlegen (virtueller Bildschirm `Xvfb :99 … 1600x1000x24`, `openbox`, Bambu Studio als `loopimir-bambu`), `loginctl enable-linger $USER`; einmal per VNC über SSH‑Tunnel **anmelden**, Drucker verbinden, **Sprache Deutsch**; in Bambu Studio ein cloud‑synchronisiertes **Benutzerprofil** `Bambu Lab P2S 0.4 nozzle Loopimir` anlegen (anderer Name → `studio.preset_name` in `config.json`); in Loopimir beim Drucker **Sendeweg: Bambu Studio** wählen. Nur ein Drucker kann diesen Weg nutzen.
