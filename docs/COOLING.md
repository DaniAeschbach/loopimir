# Cooling profiles / Kühlprofile

Loopimir cools the plate differently depending on the material, then bends and pushes the part off. You can change every value under **Settings → Cooling profiles**.

Loopimir kühlt die Platte je nach Material anders ab, biegt dann und schiebt das Teil weg. Alle Werte änderst du unter **Einstellungen → Kühlprofile**.

## Defaults / Standardwerte

| Material | Door while cooling / Tür beim Abkühlen | Fans / Lüfter | Release temp / Lösen bei | Stepped / Stufen |
|----------|------|------|------|------|
| **PLA**  | open / auf before | on / an | 25 °C | — |
| **PETG** | open / auf before | on / an | 30 °C | — |
| **TPU**  | open / auf before | on / an | 30 °C | — |
| **ABS**  | **closed / zu** | off / aus | 40 °C | 5 °C every 180 s |
| **ASA**  | **closed / zu** | off / aus | 40 °C | 5 °C every 180 s |
| **PC**   | **closed / zu** | off / aus | 50 °C | 5 °C every 180 s |
| **PA**   | **closed / zu** | off / aus | 50 °C | 5 °C every 180 s |

## Why / Warum

- **PLA/PETG** don't warp much. Open the door and run the fans to cool fast, then release early. The part usually pops off by itself around 33–35 °C; the bend finishes the job.
- **ABS/ASA/PC/PA** warp when cooled too fast. Keep the **door closed** and fans off so the chamber stays warm, and step the bed temperature down slowly (e.g. 5 °C, wait, 5 °C, …). Only when the plate reaches the release temperature does the door open for bending and pushing.

- **PLA/PETG** verziehen kaum. Tür auf, Lüfter an, schnell abkühlen, früh lösen. Das Teil löst sich oft von selbst bei ~33–35 °C; das Biegen erledigt den Rest.
- **ABS/ASA/PC/PA** verziehen bei zu schnellem Abkühlen. **Tür zu**, Lüfter aus, Kammer warm halten, Bett‑Temperatur langsam in Stufen senken (z. B. 5 °C, warten, 5 °C …). Erst bei der Lösetemperatur geht die Tür auf – dann Biegen und Schieben.

## Fields / Felder

- **Door** — `before` = open before cooling, `after` = stay closed, open only after cooling. / `auf vor dem Abkühlen` bzw. `zu, erst danach auf`.
- **Fans** — chamber/aux fans on or off while cooling. / Kammer‑/Zusatzlüfter an oder aus.
- **Release temp** — bed temperature at which the part is bent and pushed off. / Bett‑Temperatur zum Lösen.
- **Step / wait** — cool in steps of this many °C, waiting this many seconds per step. `0` = cool as fast as possible. / Abkühlen in Stufen; `0` = so schnell wie möglich.

## What the door and fans mean on each setup / Tür und Lüfter je Aufbau

| Setup | Door | Fans while cooling |
|---|---|---|
| **P2S / P1S + Stage 2** | The board opens/closes it by signal. ABS/ASA/PC/PA: closed until the release temperature. | P2S: chamber fan per profile (no board fan). P1S: printer fans per profile, optional board fan. |
| **P2S / P1S, Printer only or Passive bender** | **You** keep it open (PLA/PETG). For ABS/ASA/PC/PA the printer cannot open it later, so leave it **closed** for the cooldown and open it yourself before the push — or print those materials on a printer with the board. | Printer fans per profile (P1S: part, aux, chamber). |
| **A1** (open frame) | None. | Printer only: none — cooling is slow (35–40 min), effectively ~30 °C release. With Stage 2 the kit's 24 V fan speeds it up. ABS/ASA/PC/PA are not auto-assigned to an open printer. |

*Heads-up for ABS/ASA without a board:* a profile that says “closed, open afterwards” cannot be carried out by the printer alone. Use **PLA/PETG/TPU** on printers without a board, or accept that the part cools with the door in whatever position you left it.

> The numbers above are good starting points. The exact release temperature depends on your plate and part — find it with a test print. / Die Werte sind Startpunkte; die genaue Lösetemperatur hängt von Platte und Teil ab – mit einem Testdruck ermitteln.
