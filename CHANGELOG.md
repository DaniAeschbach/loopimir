# Changelog

## v0.2.0-rc18
- Board firmware 1.17: the board page lists what to do on first start; the web update refuses the wrong (USB) file; selbst-heal and WiFi improvements from 1.16 are final
- Board files renamed: `…-usb-full.bin` (first install by USB) and `…-web-update.bin` (updates on the board page) so they can't be mixed up
- Bambu Studio mode: the preset name matches your printer model by default and can be edited in the printer dialog; new `studio-setup.sh` creates the services with one command
- Board address field recommends the IP; docs rewritten for Board, Studio mode, update and troubleshooting

## v0.2.0-rc17
- Installer: updating while Loopimir is running no longer fails with "Text file busy"; verifies the download checksum and restarts the service
- Adding a printer now tells you why it failed: not reachable (IP/network), access code rejected, or connected but no status (e.g. another program holds the connection); waits up to 30 s for slow printers

## v0.2.0-rc16
- Board firmware 1.15: new boards start with calibrated door values, so printer signals work without calibrating first (you only set the door position)
- Board firmware 1.14: the board password can be removed again (enter `-` on the setup page)
- Board firmware 1.13: the board page is available in English and German (switch button at the top, follows the browser language)
- Board firmware 1.12: fixes the board being unreachable for about two minutes after start on the P1S (removed a blocking connection test), logs the reset reason
- Security: updates are signed (Ed25519) and verified before installing
- Security: blocks requests from other websites and DNS rebinding, upload size limits, security headers, data files readable only by the service user
- Installer: service runs with fewer privileges

## v0.2.0-rc15
- Board firmware 1.11: password protection (door, bender, settings and firmware update need the board password); Loopimir sends it automatically (Printers → Board password)
- Login lockout after 5 wrong passwords; leftover phone-notification settings are removed
- Installer: finds the Bambu Studio download itself, rejects non-x86 machines
- Docs: USB port hint for flashing the board

## v0.2.0-rc14
- Push height follows the part height (60 %, 2–10 mm)

## v0.2.0-rc13
- Fix: PETG sliced with the support filament profile on the P2S; correct material-to-profile mapping
- Bambu Studio mode: Sync Infos + AMS spool selection before every print, material check on the export
- STEP: finer conversion with memory/time limits; fixed a threading error
- New setting: orient parts automatically

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
