# Troubleshooting / Fehlersuche

[← Loopimir](../README.md) · [English](#english) · [Deutsch](#deutsch)

## English

| Problem | Fix |
|---|---|
| Search finds no printer | The search only works in the **same subnet**. Type the IP by hand. |
| Adding a printer fails | The message tells the cause. **“Can’t reach the printer”**: wrong IP or different network (port 8883). **“Access code rejected”**: check code and serial. **“Connected, but no status”**: check the serial and close other programs using the printer (Bambu Studio, phone app, Home Assistant, the board). **LAN Only mode and Developer mode** must be on. Slow printers (P1S) can take up to 30 s. |
| “No file access (FTPS) – is an SD card inserted?” | Put an **SD card** in the printer. |
| Printer shows offline later | The IP changed — give it a **fixed IP**. |
| “mqtt message verify failed” | Developer mode is off. Switch it on (or use [Studio mode](STUDIO-MODE.md)). |
| Job: “Preparing failed” | Read `~/.local/share/loopimir/jobs/<job>/work/slice.log`. Usually a broken or too big model. A STEP file that fails to convert (time or memory limit): export it as STL and upload that. |
| Job: a check failed | The file does not match your hardware choice, so it is **never sent**. *More → Checks* shows which. |
| Job waits | The reason is under the job. Common: **Plate is clear** needed, filament not loaded, printer busy, pinned (📌) to another printer. |
| Part does not come off | Cool further: lower the release temperature in *Settings → Cooling profiles*. Use a textured PEI plate. |
| A1 never reaches 25 °C | Normal (open frame, release at ~30 °C). |
| Nozzle hits the door | On P2S/P1S without the board **keep the door open** before every print. |
| Board does nothing | **Loopimir mode** on? Printer IP / access code / serial correct on `http://<board IP>/setup`? Board reachable (see next row)? |
| Board page unreachable for minutes | Check the WiFi signal on the board page (*Settings*, last line): worse than about −70 dBm is unreliable, move the router or an extender closer. Use the board’s IP instead of `loopimir.local`, give it a fixed IP. Firmware 1.16+ reconnects or restarts by itself and writes the reason into `/log.txt`. |
| Board does not start after flashing | Flash the **usb-full** file by USB (after `esptool.py erase_flash`); the **web-update** file only works on the board page. See [Board](BOARD.md). |
| Print started outside Loopimir stayed on the plate | By design — such prints are not ejected. Remove the part, press **Plate is clear**. |
| Camera shows nothing | Optional: only the image and the empty-plate check are missing. In LAN mode the P1S/A1 need **LAN Mode Liveview** switched on (printer settings) and only **one** stream at a time (close Studio / phone app). Or use [Studio mode](STUDIO-MODE.md). |
| Studio mode: “printer profile” check fails / preset not found | The preset name in Loopimir must match your Bambu Studio preset **exactly** (printer dialog → *Bambu Studio preset (name)*). It must be a synced copy of **your** printer's preset, e.g. `Bambu Lab P1S 0.4 nozzle Loopimir`. See [Studio mode](STUDIO-MODE.md). |
| Forgot the page password | Stop the service (`sudo systemctl stop loopimir`), set `"password_hash": ""` under `"web"` in `~/.local/share/loopimir/config.json`, start it again. |
| Restart / logs | `sudo systemctl restart loopimir` · `journalctl -u loopimir -n 200` · Studio mode: `journalctl --user -u loopimir-bambu -n 200` |

Still stuck? [Open an issue](https://github.com/DaniAeschbach/loopimir/issues/new/choose) with the version, printer model, hardware choice and the log — **without** access codes or serial numbers.

---

## Deutsch

| Problem | Lösung |
|---|---|
| Suche findet keinen Drucker | Die Suche geht nur im **selben Subnetz**. IP von Hand eintragen. |
| Drucker hinzufügen schlägt fehl | Die Meldung nennt die Ursache. **„Drucker nicht erreichbar“**: falsche IP oder anderes Netz (Port 8883). **„Zugangscode abgelehnt“**: Code und Seriennummer prüfen. **„Verbunden, aber kein Status“**: Seriennummer prüfen und andere Programme schließen, die den Drucker nutzen (Bambu Studio, Handy‑App, Home Assistant, das Board). **Nur‑LAN‑ und Entwicklermodus** müssen an sein. Langsame Drucker (P1S) brauchen bis zu 30 s. |
| „Kein Dateizugriff (FTPS) – SD‑Karte?“ | **SD‑Karte** in den Drucker stecken. |
| Drucker später offline | IP hat sich geändert — **feste IP** vergeben. |
| „mqtt message verify failed“ | Entwicklermodus ist aus — einschalten (oder [Studio‑Weg](STUDIO-MODE.md#deutsch)). |
| Auftrag: „Vorbereiten fehlgeschlagen“ | `~/.local/share/loopimir/jobs/<Auftrag>/work/slice.log` lesen. Meist ein defektes oder zu großes Modell. Scheitert die Umwandlung einer STEP‑Datei (Zeit‑ oder Speichergrenze): als STL exportieren und diese hochladen. |
| Auftrag: Prüfung nicht bestanden | Die Datei passt nicht zu deiner Hardware‑Wahl und wird **nie gesendet**. *Mehr → Prüfungen* zeigt welche. |
| Auftrag wartet | Der Grund steht darunter. Häufig: **Platte ist frei** nötig, Filament nicht geladen, Drucker beschäftigt, 📌 einem anderen Drucker zugewiesen. |
| Teil löst sich nicht | Weiter abkühlen: Lösetemperatur in *Einstellungen → Kühlprofile* senken. Textured‑PEI‑Platte verwenden. |
| A1 erreicht 25 °C nie | Normal (offener Rahmen, Lösen bei ~30 °C). |
| Düse fährt gegen die Tür | Bei P2S/P1S ohne Board die **Tür vor jedem Druck offen lassen**. |
| Board tut nichts | **Loopimir‑Modus** an? IP/Zugangscode/Seriennummer des Druckers auf `http://<Board-IP>/setup` richtig? Board erreichbar (siehe nächste Zeile)? |
| Board‑Seite minutenlang nicht erreichbar | WLAN‑Signal auf der Board‑Seite prüfen (*Einstellungen*, letzte Zeile): schlechter als etwa −70 dBm ist unzuverlässig, Router oder Repeater näher stellen. Die IP des Boards statt `loopimir.local` benutzen, feste IP vergeben. Firmware 1.16+ verbindet sich selbst neu oder startet neu und schreibt den Grund in `/log.txt`. |
| Board startet nach dem Flashen nicht | Per USB die **usb‑full**‑Datei flashen (vorher `esptool.py erase_flash`); die **web‑update**‑Datei geht nur auf der Board‑Seite. Siehe [Board](BOARD.md#deutsch). |
| Druck außerhalb von Loopimir blieb liegen | Gewollt — solche Drucke werden nicht ausgeworfen. Teil entfernen, **Platte ist frei**. |
| Kamera zeigt nichts | Optional: nur Bild und Platten‑Prüfung fehlen. Im LAN‑Modus brauchen P1S/A1 **LAN Mode Liveview** (Druckereinstellungen) und nur **einen** Videostrom gleichzeitig (Studio/Handy‑App schließen). Oder den [Studio‑Weg](STUDIO-MODE.md#deutsch) nehmen. |
| Studio‑Weg: Prüfung „Druckerprofil“ schlägt fehl / Profil nicht gefunden | Der Profilname in Loopimir muss **genau** dem Profil in Bambu Studio entsprechen (Drucker‑Dialog → *Bambu‑Studio‑Profil (Name)*), als synchronisierte Kopie **deines** Druckerprofils, z. B. `Bambu Lab P1S 0.4 nozzle Loopimir`. Siehe [Studio‑Weg](STUDIO-MODE.md#deutsch). |
| Seiten‑Passwort vergessen | Dienst stoppen (`sudo systemctl stop loopimir`), in `~/.local/share/loopimir/config.json` unter `"web"` `"password_hash": ""` setzen, Dienst starten. |
| Neustart / Log | `sudo systemctl restart loopimir` · `journalctl -u loopimir -n 200` · Studio‑Weg: `journalctl --user -u loopimir-bambu -n 200` |

Kommst du nicht weiter? [Issue eröffnen](https://github.com/DaniAeschbach/loopimir/issues/new/choose) mit Version, Druckermodell, Hardware‑Wahl und Log — **ohne** Zugangscodes und Seriennummern.
