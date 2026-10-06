# Bambu Studio mode (advanced) / Bambu‑Studio‑Weg

> **Beta · one printer.** Use LAN mode ([Guide](GUIDE.md)) unless you want the printer to stay in the Bambu cloud. Tuned for a **German** Bambu Studio on a **1600×1000** virtual screen. Tested on the P2S; P1S and A1 are beta.

## English

Bambu printers only accept start commands **signed by Bambu's apps**. In Studio mode Loopimir operates **your signed‑in Bambu Studio** on a virtual screen — Bambu Studio signs and sends the job. The printer stays in the cloud (Handy app and MakerWorld keep working). Loopimir still slices, checks the file strictly, and prepares the next job while one is printing. The camera image also comes from Bambu Studio in this mode.

### Setup (once)
1. **Install** as usual: `install.sh` adds Bambu Studio and the tools.
2. **Create the services** (virtual screen, window manager, Bambu Studio, local VNC) with one command, as your normal user:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/DaniAeschbach/loopimir/main/scripts/studio-setup.sh | bash
   ```
3. **Sign in once** (this part only you can do): open a tunnel `ssh -L 5900:localhost:5900 <user>@<server>`, connect a VNC viewer to `localhost:5900`, and in Bambu Studio **sign in**, bind your printer, set the **language to German**.
4. **Make the preset.** In Bambu Studio save a **user preset that is a copy of your own printer's preset** and let it sync to the Bambu cloud (Studio deletes presets that are not synced). Name it after your model, for example:
   - P2S: `Bambu Lab P2S 0.4 nozzle Loopimir`
   - P1S: `Bambu Lab P1S 0.4 nozzle Loopimir`
   - A1: `Bambu Lab A1 0.4 nozzle Loopimir`
5. **In Loopimir:** edit the printer → **Send mode: Bambu Studio** → the field **Bambu Studio preset (name)** is filled with the name above for your model. If you named your preset differently, type exactly that name (same upper/lower case). IP and access code are still needed. Only **one** printer can use this mode.

### Good to know
- The name is free, it just has to match in both places. It is best to end it with *Loopimir*: Loopimir finds the preset by its last word.
- Loopimir overwrites that preset with each job's settings, so don't use your everyday preset.
- Close the live view in the Bambu apps; only one video stream works at a time.

## Deutsch

Bambu‑Drucker nehmen nur von Bambus Apps **signierte** Startbefehle an. Im Studio‑Weg bedient Loopimir **dein angemeldetes Bambu Studio** auf einem virtuellen Bildschirm; Bambu Studio signiert und sendet. Der Drucker bleibt in der Cloud. Loopimir slict und prüft weiterhin streng und bereitet den nächsten Auftrag schon beim Drucken vor. Auch das Kamerabild kommt in diesem Modus aus Bambu Studio.

### Einrichtung (einmalig)
1. **Installieren** wie gewohnt: `install.sh` legt Bambu Studio und die Werkzeuge an.
2. **Dienste anlegen** (virtueller Bildschirm, Fenstermanager, Bambu Studio, lokales VNC) mit einem Befehl, als normaler Benutzer:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/DaniAeschbach/loopimir/main/scripts/studio-setup.sh | bash
   ```
3. **Einmal anmelden** (das kannst nur du): Tunnel öffnen `ssh -L 5900:localhost:5900 <benutzer>@<server>`, VNC‑Viewer mit `localhost:5900` verbinden, in Bambu Studio **anmelden**, Drucker verbinden, **Sprache Deutsch** einstellen.
4. **Profil anlegen:** In Bambu Studio ein **Benutzerprofil als Kopie deines eigenen Druckerprofils** speichern und mit der Cloud synchronisieren lassen (nicht synchronisierte Profile löscht Studio). Name nach deinem Modell, z. B. `Bambu Lab P1S 0.4 nozzle Loopimir` (P2S / A1 entsprechend).
5. **In Loopimir:** Drucker bearbeiten → **Sendeweg: Bambu Studio** → im Feld **Bambu‑Studio‑Profil (Name)** steht der Name passend zu deinem Modell. Hast du dein Profil anders genannt, genau diesen Namen eintragen (Groß‑/Kleinschreibung gleich). IP und Zugangscode sind weiter nötig. Nur **ein** Drucker kann diesen Weg nutzen.

### Gut zu wissen
- Der Name ist frei, er muss nur an beiden Stellen gleich sein. Am besten endet er mit *Loopimir*: Loopimir findet das Profil über das letzte Wort.
- Loopimir überschreibt dieses Profil bei jedem Auftrag; nimm nicht dein Alltagsprofil.
- Live‑Ansicht in den Bambu‑Apps schließen; es geht nur ein Videostrom gleichzeitig.
