# The board (FarmLoop Stage 2) / Das Board

Optional. Loopimir works without it. The board (ESP32‑S3, FarmBoard V2.2) opens/closes the printer door and drives the bender (P2S, P1S), or the bender and fan (A1, no door). **One board per printer.** The firmware is free but closed source.

## English

### Install the firmware
1. `pip install esptool`. **Back up the original firmware first** (it contains your WiFi password and printer data — keep the file private):
   `esptool.py --port <port> read_flash 0 0x1000000 original_backup.bin`
2. Connect the board by USB and flash `loopimir-board-v1.13-full.bin` (download it from the [latest release](https://github.com/DaniAeschbach/loopimir/releases)):
   `esptool.py --chip esp32s3 --port <port> write_flash 0x0 loopimir-board-v1.13-full.bin`

   `<port>` is the board's USB port: **Windows** `COM3` (see *Device Manager → Ports*), **Linux** `/dev/ttyACM0` (compare `ls /dev/tty*` before and after plugging in), **macOS** `/dev/cu.usbmodem…`. If nothing shows up, use a data cable (not charge-only) and hold **BOOT** while plugging in.
3. The board opens the WiFi network **Loopimir‑Setup**. Join it, open **http://192.168.4.1/setup** and enter your **WiFi**, the **printer's IP, access code and serial number** and a **board password** (min. 6 characters; enter the same one in Loopimir under *Printers → Board password*). Without a password anyone on your network can move the door or flash the board. It restarts and is then reachable at `http://loopimir.local`.

**Never flash the `-update.bin` file with esptool** (it has no bootloader and the board will not start). Use `-full.bin` for flashing by USB, and `-update.bin` only in the board's web page. If the board doesn't start: `esptool.py --chip esp32s3 --port <port> erase_flash`, then flash `-full.bin` again.

Later updates: upload `loopimir-board-v1.13-update.bin` (also on the release page) on the board's own page (*Firmware update*). WiFi and printer data can be changed any time at `http://loopimir.local/setup`. Forgot the password? Erase the board with `esptool.py --port <port> erase_flash` and flash it again.

### Set it up
On the board page: switch **Loopimir mode ON** (off by default), tick what your kit has (**P2S:** Door + Bender · **P1S:** Door + Bender, Fan if you fitted it · **A1:** Bender + Fan, no door), check the bender direction, and test each movement by hand. In Loopimir add the printer with **FarmLoop Stage 2** and enter the board's address.

The print file tells the board what to do through the nozzle target temperature: `M104 S1` door close · `S4` door open (print start) · `S2` door open + fan on · `S3` fan off + bend · `S5` door close. The board only *reads* the printer's status, so the printer does **not** need LAN mode for the board.

### Wiring
Door: GPIO 7 close · 15 open · 8 current. Bender: 13 up · 12 down · 6 current. Fan: 14 (MOSFET, 24 V blower, check polarity). Door button 10, bender button 11.

## Deutsch

**Firmware installieren:** 1. **Erst die Original‑Firmware sichern** (enthält WLAN‑Passwort und Druckerdaten, privat halten): `esptool.py --port <port> read_flash 0 0x1000000 original_backup.bin`. 2. Board per USB anschließen und `loopimir-board-v1.13-full.bin` (von der [Release‑Seite](https://github.com/DaniAeschbach/loopimir/releases)) flashen: `esptool.py --chip esp32s3 --port <port> write_flash 0x0 loopimir-board-v1.13-full.bin`. `<port>` ist der USB‑Anschluss des Boards: **Windows** `COM3` (siehe *Geräte‑Manager → Anschlüsse*), **Linux** `/dev/ttyACM0` (`ls /dev/tty*` vor und nach dem Einstecken vergleichen), **macOS** `/dev/cu.usbmodem…`. Wird nichts angezeigt: Datenkabel verwenden (nicht nur Ladekabel) und beim Einstecken **BOOT** gedrückt halten. 3. Das Board öffnet das WLAN **Loopimir‑Setup**; verbinden, **http://192.168.4.1/setup** öffnen und **WLAN** sowie **IP, Zugangscode und Seriennummer des Druckers** und ein **Board‑Passwort** (mindestens 6 Zeichen; dasselbe in Loopimir unter *Drucker → Board‑Passwort* eintragen) eintragen. Ohne Passwort kann jeder in deinem Netz die Tür bewegen oder das Board neu flashen. Danach erreichst du es unter `http://loopimir.local`.

**Wichtig:** Die Datei `-update.bin` **nie** mit esptool flashen (ohne Bootloader startet das Board nicht), nur auf der Board‑Seite hochladen. Für USB immer `-full.bin`. Startet das Board nicht: `esptool.py --chip esp32s3 --port <port> erase_flash`, danach `-full.bin` neu flashen. **Updates:** `loopimir-board-v1.13-update.bin` (also on the release page) auf der Board‑Seite hochladen (*Firmware‑Update*). WLAN/Drucker jederzeit unter `http://loopimir.local/setup` ändern.

**Einrichten:** Auf der Board‑Seite **Loopimir‑Modus EIN** (standardmäßig aus), **Tür / Bender / Lüfter** passend zum Kit setzen (P2S: Tür + Bender · P1S: Tür + Bender, Lüfter falls verbaut · A1: Bender + Lüfter, keine Tür), Bender‑Richtung prüfen, jede Bewegung von Hand testen. In Loopimir den Drucker mit **FarmLoop Stage 2** hinzufügen und die Board‑Adresse eintragen. Das Board liest den Druckerstatus nur — der Drucker braucht dafür **keinen** LAN‑Modus.
