# The board (FarmLoop Stage 2) / Das Board

Optional. Loopimir works without it. The board (ESP32‑S3, FarmBoard V2.2) opens/closes the printer door and drives the bender (P2S, P1S), or the bender and fan (A1, no door). **One board per printer.** The firmware is free but closed source.

## English

### Two files — don't mix them up
| File | Use it | How |
|---|---|---|
| `loopimir-board-vX-usb-full.bin` | **first install** (and to recover a board that doesn't start) | flash by USB with esptool |
| `loopimir-board-vX-web-update.bin` | **updates** | upload on the board's own page, *Firmware update* (the page refuses the wrong file) |

Both are on the [latest release](https://github.com/DaniAeschbach/loopimir/releases).

### Install the firmware (first time)
1. `pip install esptool`. **Back up the original firmware first** (it contains your WiFi password and printer data — keep the file private):
   `esptool.py --port <port> read_flash 0 0x1000000 original_backup.bin`
2. Connect the board by USB and flash the **usb-full** file:
   `esptool.py --chip esp32s3 --port <port> write_flash 0x0 loopimir-board-vX-usb-full.bin`

   `<port>` is the board's USB port: **Windows** `COM3` (see *Device Manager → Ports*), **Linux** `/dev/ttyACM0` (compare `ls /dev/tty*` before and after plugging in), **macOS** `/dev/cu.usbmodem…`. If nothing shows up, use a data cable (not charge-only) and hold **BOOT** while plugging in.
3. The board opens the WiFi network **Loopimir‑Setup**. Join it, open **http://192.168.4.1/setup** and enter your **WiFi**, the **printer's IP, access code and serial number** and, if you like, a **board password** (min. 6 characters; enter the same one in Loopimir under *Printers → Board password*). Without a password anyone on your network can move the door or flash the board. To remove it later, type `-` into the password field on `/setup` and save.
4. The board restarts. Find its **IP address** in your router's device list (name *loopimir*) and open `http://<that IP>`. Give it a **fixed IP** in your router. (`http://loopimir.local` often works too, but the name lookup fails on some Windows PCs and browsers — the IP always works.)

If the board doesn't start (nothing on the WiFi list, no page): erase it and flash the usb‑full file again: `esptool.py --chip esp32s3 --port <port> erase_flash`.

### First start: the board page tells you what to do
The top of the board page shows a **Getting started** list until it is done:
1. **Door position** — look at the door and press *Position is OPEN* or *Position is CLOSED* (nothing moves).
2. **Loopimir mode ON** (card *Loopimir mode*, off by default).
3. **Check the setup** to match your kit and test bender and fan once by hand, with the build plate and your hands clear: **P2S** Door + Bender · **P1S** Door + Bender, Fan if you fitted it · **A1** Bender + Fan, no door. If *Bender up* moves the wrong way, tap *Bender direction*.

The door values (travel time, clamp limit) come **pre‑calibrated** from a Stage 2 door. Calibrate (*Door calibration*, door free) only if your door behaves differently.

### Connect it to Loopimir
In Loopimir add the printer with hardware **FarmLoop Stage 2** and enter the **board's IP** as *Board address* (and the board password, if you set one). The board only *reads* the printer's status, so the printer does **not** need LAN mode for the board.

### Updates
Open the board page → *Firmware update* → choose the **web‑update** file. The board restarts and keeps all settings.

### If the board page is not reachable
- Check the **WiFi signal** on the board page (*Settings*, last line): worse than about −70 dBm is unreliable. Move the router or an extender closer. The board only supports 2.4 GHz.
- Firmware 1.16+ reconnects or restarts by itself when the connection is lost and writes the reason into `http://<IP>/log.txt` (lines with *Selbstheilung*, *WLAN getrennt (Grund …)*, *Speicher:*). Wait a few minutes before unplugging it.

### Signals
The print file tells the board what to do through the nozzle target temperature: `M104 S1` door close · `S4` door open (print start) · `S2` door open + fan on · `S3` fan off + bend · `S5` door close. The board only *reads* the printer's status, so the printer does **not** need LAN mode for the board.

### Wiring
Door: GPIO 7 close · 15 open · 8 current. Bender: 13 up · 12 down · 6 current. Fan: 14 (MOSFET, 24 V blower, check polarity). Door button 10, bender button 11.

## Deutsch

### Zwei Dateien — nicht verwechseln
| Datei | Wofür | Wie |
|---|---|---|
| `loopimir-board-vX-usb-full.bin` | **Erstinstallation** (und wenn ein Board nicht startet) | per USB mit esptool flashen |
| `loopimir-board-vX-web-update.bin` | **Updates** | auf der Board‑Seite hochladen, *Firmware‑Update* (die Seite lehnt die falsche Datei ab) |

Beide liegen auf der [Release‑Seite](https://github.com/DaniAeschbach/loopimir/releases).

### Firmware installieren (erstmalig)
1. **Erst die Original‑Firmware sichern** (enthält WLAN‑Passwort und Druckerdaten, privat halten): `esptool.py --port <port> read_flash 0 0x1000000 original_backup.bin`
2. Board per USB anschließen und die **usb‑full**‑Datei flashen: `esptool.py --chip esp32s3 --port <port> write_flash 0x0 loopimir-board-vX-usb-full.bin`. `<port>` ist der USB‑Anschluss des Boards: **Windows** `COM3` (siehe *Geräte‑Manager → Anschlüsse*), **Linux** `/dev/ttyACM0` (`ls /dev/tty*` vor und nach dem Einstecken vergleichen), **macOS** `/dev/cu.usbmodem…`. Wird nichts angezeigt: Datenkabel verwenden (nicht nur Ladekabel) und beim Einstecken **BOOT** gedrückt halten.
3. Das Board öffnet das WLAN **Loopimir‑Setup**; verbinden, **http://192.168.4.1/setup** öffnen und **WLAN** sowie **IP, Zugangscode und Seriennummer des Druckers** und optional ein **Board‑Passwort** (mindestens 6 Zeichen; dasselbe in Loopimir unter *Drucker → Board‑Passwort* eintragen) eintragen. Ohne Passwort kann jeder in deinem Netz die Tür bewegen oder das Board neu flashen. Zum Entfernen später auf `/setup` im Passwortfeld `-` eintragen und speichern.
4. Das Board startet neu. Seine **IP‑Adresse** steht in der Geräteliste deines Routers (Name *loopimir*); `http://<IP>` öffnen und im Router eine **feste IP** vergeben. (`http://loopimir.local` geht oft auch, aber die Namenssuche scheitert auf manchen Windows‑PCs und Browsern — die IP geht immer.)

Startet das Board nicht (kein WLAN in der Liste, keine Seite): löschen und die usb‑full‑Datei neu flashen: `esptool.py --chip esp32s3 --port <port> erase_flash`.

### Erster Start: die Board‑Seite sagt, was zu tun ist
Oben auf der Board‑Seite steht eine **Einrichtung**‑Liste, bis alles erledigt ist:
1. **Tür‑Position** — Tür ansehen und *Position ist OFFEN* oder *Position ist ZU* drücken (nichts fährt).
2. **Loopimir‑Modus EIN** (Karte *Loopimir‑Modus*, standardmäßig aus).
3. **Aufbau passend zum Kit** setzen und Bender und Lüfter einmal von Hand testen (Druckplatte und Hände weg): **P2S** Tür + Bender · **P1S** Tür + Bender, Lüfter falls verbaut · **A1** Bender + Lüfter, keine Tür. Fährt *Bender hoch* in die falsche Richtung, *Bender‑Richtung* umschalten.

Die Tür‑Werte (Fahrzeit, Klemmgrenze) sind **vorkalibriert** (Stage‑2‑Tür). Nur kalibrieren (*Tür‑Kalibrierung*, Tür frei), wenn sich deine Tür anders verhält.

### Mit Loopimir verbinden
In Loopimir den Drucker mit **FarmLoop Stage 2** hinzufügen und als *Board‑Adresse* die **IP des Boards** eintragen (und das Board‑Passwort, falls gesetzt). Das Board liest den Druckerstatus nur — der Drucker braucht dafür **keinen** LAN‑Modus.

### Updates
Board‑Seite → *Firmware‑Update* → die **web‑update**‑Datei wählen. Das Board startet neu, alle Einstellungen bleiben.

### Board‑Seite nicht erreichbar
- **WLAN‑Signal** auf der Board‑Seite prüfen (*Einstellungen*, letzte Zeile): schlechter als etwa −70 dBm ist unzuverlässig. Router oder Repeater näher stellen. Das Board kann nur 2,4 GHz.
- Firmware 1.16+ verbindet sich bei Verbindungsverlust selbst neu oder startet neu und schreibt den Grund in `http://<IP>/log.txt` (Zeilen mit *Selbstheilung*, *WLAN getrennt (Grund …)*, *Speicher:*). Ein paar Minuten warten, bevor man den Strom abzieht.
