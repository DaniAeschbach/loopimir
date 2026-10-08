# Printers & hardware / Drucker & Hardware

[← Loopimir](../README.md) · [English](#english) · [Deutsch](#deutsch)

## English

| Printer | Status | What happens after the print |
|---|---|---|
| **P2S** | ✅ proven | cool → (bend) → nozzle pushes the part off |
| **A1** | ✅ tested (LAN, one full print) | cool → nozzle push + clearing sweep |
| **P1S** | 🧪 **beta** — no real print yet | cool → (bend over Z) → nozzle push |

Other models are untested.

### Extra hardware — one choice per printer

| | P2S | A1 | P1S | |
|---|:-:|:-:|:-:|---|
| **Printer only** | ✓ | ✓ | ✓ | Cool, then push. On P2S/P1S **keep the door open** before every print. |
| **Passive bender** | ✓ | – | ✓ | Before the push the bed moves 6× in Z against a fixed bender. *P2S: experimental.* |
| **FarmLoop Stage 2** | ✓ | ✓ | ✓ | The [board](BOARD.md): P2S door + bender · P1S door + bender (+ optional fan) · A1 bender + fan (no door). |

**Door while printing** (Stage 2 on P2S / P1S, *Settings → Cooling profiles*, per material): *closed* sends “door close” at the start of the print (default); *open* sends “door open” at the start and leaves it open at the end — useful for PLA/PETG against heat creep. Needs board firmware 1.10.

Every file is checked before it is sent: it must contain exactly what your choice needs.

### Several printers
One queue for all. A job goes to a printer that **has the filament loaded** and the **shortest queue**; ABS/ASA/PC/PA only to enclosed printers (P2S, P1S). Pin a job to a printer with the drop-down on the job. Each job is sliced for the printer it runs on.

### Notes
- **A1:** no AMS (external spool), slow cooling (~35–40 min, ~30 °C release), camera empty-plate check off.
- **P1S (beta):** first run the push on its own with a part on the plate, then a short print with *Printer only* next to the printer, only then *Passive bender*. Please report back via an issue ([Printer test report](https://github.com/DaniAeschbach/loopimir/issues/new?template=printer_test_report.yml)).
- **Stage 2 on A1 / P1S is untested:** the signals are generated and checked, but the bed position for the active bender (P1S: bed down to Z235) is a best guess — a FarmLoop Stage 2 print file for these printers would help; please open an issue.
- **Stop print:** in Bambu Studio mode Loopimir presses Bambu Studio's stop button and confirms (tested on the P2S; it only reports success once the printer itself stops). In LAN mode it sends the stop command over MQTT (needs developer mode; with the cloud on the printer rejects it) — tested on the A1.
- **Pushing, two passes:** first slowly at **part height − 10 mm** (at least 3 mm), so the top of the part is never more than 10 mm above the nozzle level. Then a fast second pass at **3 mm** (A1: 2 mm) for parts up to **30 mm** high. A taller part could still be standing and the bed would lift it into the toolhead rail (measured on the P2S: the rail is 45 mm above the nozzle level when the bed is all the way up), so taller parts get the second pass at the same height as the first. Parts thinner than about 3 mm cannot be pushed (the nozzle passes over them). Tall, narrow parts (about 100 mm) are only moved or tipped, not reliably ejected: the plate check then stops the queue until you press **Plate is clear**. Large or heavy parts are not tested: watch the first ones.
- **Not yet proven on real hardware:** the board's fan, AMS auto-dry (Studio mode only).

---

## Deutsch

| Drucker | Stand | Was nach dem Druck passiert |
|---|---|---|
| **P2S** | ✅ erprobt | abkühlen → (biegen) → Düse schiebt das Teil weg |
| **A1** | ✅ getestet (LAN, ein ganzer Druck) | abkühlen → Düse schiebt + Räum‑Fahrt |
| **P1S** | 🧪 **Beta** — noch kein echter Druck | abkühlen → (biegen über Z) → Düse schiebt |

Andere Modelle sind ungetestet.

### Zusatz‑Hardware — eine Wahl pro Drucker

| | P2S | A1 | P1S | |
|---|:-:|:-:|:-:|---|
| **Nur Drucker** | ✓ | ✓ | ✓ | Abkühlen, dann schieben. Bei P2S/P1S die **Tür vor jedem Druck offen lassen**. |
| **Passiver Bender** | ✓ | – | ✓ | Vor dem Schieben fährt das Bett 6× in Z gegen einen festen Bender. *P2S: experimentell.* |
| **FarmLoop Stage 2** | ✓ | ✓ | ✓ | Das [Board](BOARD.md#deutsch): P2S Tür + Bender · P1S Tür + Bender (+ optional Lüfter) · A1 Bender + Lüfter (keine Tür). |

**Tür beim Drucken** (Stage 2 am P2S / P1S, *Einstellungen → Kühlprofile*, pro Material): *zu* sendet beim Druckstart „Tür zu“ (Standard); *auf* sendet beim Start „Tür auf“ und lässt sie am Ende offen — bei PLA/PETG gegen Heat Creep. Braucht Board‑Firmware 1.10.

Jede Datei wird vor dem Senden geprüft: Sie muss genau das enthalten, was deine Wahl braucht.

### Mehrere Drucker
Eine Warteschlange für alle. Ein Auftrag geht an einen Drucker, der **das Filament geladen** hat und die **kürzeste Schlange** hat; ABS/ASA/PC/PA nur auf geschlossene Drucker (P2S, P1S). Mit dem Auswahlfeld am Auftrag lässt er sich fest einem Drucker zuweisen. Jeder Auftrag wird für den Drucker gesliced, auf dem er läuft.

### Hinweise
- **A1:** kein AMS (externe Spule), langsames Abkühlen (~35–40 min, Lösen bei ~30 °C), Kamera‑Prüfung der leeren Platte aus.
- **P1S (Beta):** erst den Schiebevorgang allein mit einem Teil auf der Platte testen, dann ein kurzer Druck mit *Nur Drucker* neben dem Drucker, erst danach *Passiver Bender*. Rückmeldung bitte als Issue ([Printer test report](https://github.com/DaniAeschbach/loopimir/issues/new?template=printer_test_report.yml)).
- **Stage 2 an A1 / P1S ist ungetestet:** Die Signale werden erzeugt und geprüft, aber die Bett‑Position für den aktiven Bender (P1S: Bett runter auf Z235) ist geschätzt — eine FarmLoop‑Stage‑2‑Druckdatei für diese Drucker würde helfen; bitte ein Issue eröffnen.
- **Druck stoppen:** Im Bambu‑Studio‑Weg drückt Loopimir den Stopp‑Knopf von Bambu Studio und bestätigt (am P2S getestet; Erfolg wird erst gemeldet, wenn der Drucker wirklich stoppt). Im LAN‑Modus sendet es den Stopp‑Befehl per MQTT (braucht Entwicklermodus; mit eingeschalteter Cloud lehnt der Drucker ihn ab) — am A1 getestet.
- **Schieben in zwei Durchgängen:** erst langsam auf **Teilehöhe − 10 mm** (mindestens 3 mm), die Oberkante des Teils steht so nie mehr als 10 mm über der Düsenebene. Danach ein schneller zweiter Durchgang auf **3 mm** (A1: 2 mm) für Teile bis **30 mm** Höhe. Ein höheres Teil könnte noch stehen, und das Bett würde es in die Schiene des Druckkopfs heben (am P2S gemessen: Die Schiene liegt bei ganz oben gefahrenem Bett 45 mm über der Düsenebene). Bei höheren Teilen läuft der zweite Durchgang deshalb auf derselben Höhe wie der erste. Teile unter etwa 3 mm Höhe lassen sich nicht schieben (die Düse fährt darüber). Hohe, schmale Teile (etwa 100 mm) werden nur bewegt oder gekippt, nicht zuverlässig ausgeworfen: Die Platten‑Prüfung hält dann die Warteschlange an, bis du **Platte ist frei** drückst. Große oder schwere Teile sind nicht getestet: die ersten beaufsichtigen.
- **Noch nicht an echter Hardware bewiesen:** Lüfter am Board, AMS‑Trocknen (nur Studio‑Weg).
