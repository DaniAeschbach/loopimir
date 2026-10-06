# Changelog

## v0.2.0-rc12
- Camera in Bambu Studio mode made robust (maximizes the window, checks the Device tab, recognizes a dark picture, closes stray windows)

## v0.2.0-rc11
- Stop print fixed in Bambu Studio mode (verified against the printer state, closes the "task cancelled" pop-up)

## v0.2.0-rc10
- Camera image refreshes about every minute on every printer (own loop per printer); fixed Studio-mode camera after a Bambu Studio restart

## v0.2.0-rc9
- Door open/closed switch on printer cards with a Stage 2 door

## v0.2.0-rc8
- Light button on every printer card

## v0.2.0-rc7
- **Door while printing, per material** (Settings → Cooling profiles): send “door open” instead of “door close” at the start of a print, e.g. for PLA/PETG against heat creep. Board firmware 1.10 (new signal `M104 S4`; the board's own “door close at print start” fallback now waits for a signal)

## v0.2.0
- One dashboard for **any number of printers** (P2S, A1, P1S) with one shared queue and automatic assignment by filament and load
- Per printer: *Printer only*, *Passive bender* or *FarmLoop Stage 2* board
- **P1S support (beta)**, A1 support
- Stop print, self-update
- Board firmware 1.9: WiFi and printer data are set on the board's own page (no more building from source); free, closed source
- Phone notifications removed; simpler docs

## v0.1.0
- First public release: LAN mode, Bambu Studio mode, cooling profiles, camera, queue, German + English
