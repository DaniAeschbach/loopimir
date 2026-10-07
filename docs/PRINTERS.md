# Printers & hardware / Drucker & Hardware

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
- **P1S (beta):** first run the push on its own with a part on the plate, then a short print with *Printer only* next to the printer, only then *Passive bender*. Please report back via an issue ("Printer test report").
- **Stage 2 on A1 / P1S is untested:** the signals are generated and checked, but the bed position for the active bender (P1S: bed down to Z235) is a best guess — a FarmLoop Stage 2 print file for these printers would help; please open an issue.
- **Stop print:** in Bambu Studio mode Loopimir presses Bambu Studio's stop button and confirms (tested on the P2S; it only reports success once the printer itself stops). In LAN mode it sends the stop command over MQTT (needs developer mode; with the cloud on the printer rejects it) — tested on the A1.
- **Push height:** the nozzle pushes at **part height − 10 mm** (at least 3 mm), so the top of the part is never more than 10 mm above the nozzle level. On P2S/P1S the bed moves up for the push, a tall part would otherwise hit the toolhead, the gantry or the ceiling. Parts thinner than about 3 mm cannot be pushed (the nozzle passes over them). Large or heavy parts are not tested: watch the first ones.
- **Not yet proven on real hardware:** the board's fan, AMS auto-dry (Studio mode only).

## Deutsch

P2S ✅ erprobt · A1 ✅ getestet · **P1S 🧪 Beta** (noch kein echter Druck). Andere Modelle ungetestet.

**Zusatz‑Hardware — eine Wahl pro Drucker:** **Nur Drucker** (abkühlen, schieben; bei P2S/P1S die **Tür vor jedem Druck offen lassen**) · **Passiver Bender** (nur P2S/P1S; Bett fährt 6× in Z gegen einen festen Bender; beim P2S experimentell) · **FarmLoop Stage 2** ([Board](BOARD.md): P2S Tür + Bender · P1S Tür + Bender (+ optional Lüfter) · A1 Bender + Lüfter, keine Tür).

**Tür beim Drucken** (Stage 2 am P2S/P1S, *Einstellungen → Kühlprofile*, pro Material): *zu* sendet beim Druckstart „Tür zu“ (Standard); *auf* sendet „Tür auf“ und lässt sie am Ende offen — bei PLA/PETG gegen Heat Creep. Braucht Board‑Firmware 1.10.

**Mehrere Drucker:** Eine Warteschlange für alle. Ein Auftrag geht an einen Drucker mit **passendem Filament** und der **kürzesten Schlange**; ABS/ASA/PC/PA nur auf geschlossene Drucker. Mit dem Auswahlfeld am Auftrag lässt er sich fest zuweisen.

**P1S (Beta):** erst den Schiebevorgang allein mit einem Teil auf der Platte testen, dann ein kurzer Druck mit *Nur Drucker* neben dem Drucker, erst danach *Passiver Bender*. Rückmeldung bitte als Issue („Printer test report“). **Stage 2 an A1/P1S ist ungetestet** (Bett‑Position für den Bender ist geschätzt). **Druck stoppen:** im Bambu‑Studio‑Weg drückt Loopimir den Stopp‑Knopf von Bambu Studio (am P2S getestet; Erfolg wird erst gemeldet, wenn der Drucker wirklich stoppt); im LAN‑Modus per MQTT (braucht Entwicklermodus; am A1 getestet). **Noch nicht an echter Hardware bewiesen:** Lüfter am Board, AMS‑Trocknen.
**Schiebehöhe:** Die Düse schiebt auf **Teilehöhe − 10 mm** (mindestens 3 mm). Die Oberkante des Teils steht so nie mehr als 10 mm über der Düsenebene. Beim P2S/P1S fährt das Bett zum Schieben hoch, ein hohes Teil stieße sonst an Druckkopf, Querträger oder Decke. Teile unter etwa 3 mm Höhe lassen sich nicht schieben (die Düse fährt darüber). Große oder schwere Teile sind nicht getestet: die ersten beaufsichtigen.
