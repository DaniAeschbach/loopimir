# Cooling profiles / Kühlprofile

[← Loopimir](../README.md) · [English](#english) · [Deutsch](#deutsch)

## English

Loopimir cools the plate differently depending on the material, then bends and pushes the part off. You can change every value under **Settings → Cooling profiles**.

### Defaults

| Material | Door while cooling | Fans | Release temp | Stepped |
|---|---|---|---|---|
| **PLA**  | open before | on | 25 °C | — |
| **PETG** | open before | on | 30 °C | — |
| **TPU**  | open before | on | 30 °C | — |
| **ABS**  | **closed** | off | 40 °C | 5 °C every 180 s |
| **ASA**  | **closed** | off | 40 °C | 5 °C every 180 s |
| **PC**   | **closed** | off | 50 °C | 5 °C every 180 s |
| **PA**   | **closed** | off | 50 °C | 5 °C every 180 s |

### Why
- **PLA/PETG** don't warp much. Open the door and run the fans to cool fast, then release early. The part usually pops off by itself around 33–35 °C; the bend finishes the job.
- **ABS/ASA/PC/PA** warp when cooled too fast. Keep the **door closed** and fans off so the chamber stays warm, and step the bed temperature down slowly (e.g. 5 °C, wait, 5 °C, …). Only when the plate reaches the release temperature does the door open for bending and pushing.

### Fields
- **Door** — `before` = open before cooling, `after` = stay closed, open only after cooling.
- **Door while printing** — *closed* (default) or *open*, only with Stage 2 on P2S / P1S. See [Printers](PRINTERS.md).
- **Fans** — chamber/aux fans on or off while cooling.
- **Release temp** — bed temperature at which the part is bent and pushed off.
- **Step / wait** — cool in steps of this many °C, waiting this many seconds per step. `0` = cool as fast as possible.

### What the door and fans mean on each setup

| Setup | Door | Fans while cooling |
|---|---|---|
| **P2S / P1S + Stage 2** | The board opens/closes it by signal. ABS/ASA/PC/PA: closed until the release temperature. | P2S: chamber fan per profile (no board fan). P1S: printer fans per profile, optional board fan. |
| **P2S / P1S, Printer only or Passive bender** | **You** keep it open (PLA/PETG). For ABS/ASA/PC/PA the printer cannot open it later, so leave it **closed** for the cooldown and open it yourself before the push — or print those materials on a printer with the board. | Printer fans per profile (P1S: part, aux, chamber). |
| **A1** (open frame) | None. | Printer only: none — cooling is slow (35–40 min), effectively ~30 °C release. With Stage 2 the kit's 24 V fan speeds it up. ABS/ASA/PC/PA are not auto-assigned to an open printer. |

> **ABS/ASA without a board:** a profile that says “closed, open afterwards” cannot be carried out by the printer alone. Use **PLA/PETG/TPU** on printers without a board, or accept that the part cools with the door in whatever position you left it.

The numbers above are good starting points. The exact release temperature depends on your plate and part — find it with a test print.

---

## Deutsch

Loopimir kühlt die Platte je nach Material anders ab, biegt dann und schiebt das Teil weg. Alle Werte änderst du unter **Einstellungen → Kühlprofile**.

### Standardwerte

| Material | Tür beim Abkühlen | Lüfter | Lösen bei | Stufen |
|---|---|---|---|---|
| **PLA**  | vorher auf | an | 25 °C | — |
| **PETG** | vorher auf | an | 30 °C | — |
| **TPU**  | vorher auf | an | 30 °C | — |
| **ABS**  | **zu** | aus | 40 °C | 5 °C alle 180 s |
| **ASA**  | **zu** | aus | 40 °C | 5 °C alle 180 s |
| **PC**   | **zu** | aus | 50 °C | 5 °C alle 180 s |
| **PA**   | **zu** | aus | 50 °C | 5 °C alle 180 s |

### Warum
- **PLA/PETG** verziehen kaum. Tür auf, Lüfter an, schnell abkühlen, früh lösen. Das Teil löst sich oft von selbst bei ~33–35 °C; das Biegen erledigt den Rest.
- **ABS/ASA/PC/PA** verziehen bei zu schnellem Abkühlen. **Tür zu**, Lüfter aus, Kammer warm halten, Bett‑Temperatur langsam in Stufen senken (z. B. 5 °C, warten, 5 °C …). Erst bei der Lösetemperatur geht die Tür auf – dann Biegen und Schieben.

### Felder
- **Tür** — `before` = vor dem Abkühlen auf, `after` = zu lassen, erst nach dem Abkühlen auf.
- **Tür beim Drucken** — *zu* (Standard) oder *auf*, nur mit Stage 2 am P2S / P1S. Siehe [Drucker](PRINTERS.md#deutsch).
- **Lüfter** — Kammer‑/Zusatzlüfter beim Abkühlen an oder aus.
- **Lösetemperatur** — Bett‑Temperatur, bei der das Teil gebogen und weggeschoben wird.
- **Stufe / Wartezeit** — in Stufen von so vielen °C abkühlen und je Stufe so viele Sekunden warten. `0` = so schnell wie möglich.

### Tür und Lüfter je Aufbau

| Aufbau | Tür | Lüfter beim Abkühlen |
|---|---|---|
| **P2S / P1S + Stage 2** | Das Board öffnet/schließt sie per Signal. ABS/ASA/PC/PA: zu bis zur Lösetemperatur. | P2S: Kammerlüfter laut Profil (kein Board‑Lüfter). P1S: Druckerlüfter laut Profil, optional Board‑Lüfter. |
| **P2S / P1S, Nur Drucker oder Passiver Bender** | **Du** lässt sie offen (PLA/PETG). Bei ABS/ASA/PC/PA kann der Drucker sie später nicht öffnen: zum Abkühlen **zu** lassen und vor dem Schieben selbst öffnen — oder diese Materialien auf einem Drucker mit Board drucken. | Druckerlüfter laut Profil (P1S: Bauteil, Zusatz, Kammer). |
| **A1** (offener Rahmen) | Keine. | Nur Drucker: keine — Abkühlen dauert lange (35–40 min), Lösen praktisch bei ~30 °C. Mit Stage 2 beschleunigt der 24‑V‑Lüfter des Kits. ABS/ASA/PC/PA werden offenen Druckern nicht automatisch zugewiesen. |

> **ABS/ASA ohne Board:** Ein Profil „zu, danach auf“ kann der Drucker allein nicht ausführen. Auf Druckern ohne Board **PLA/PETG/TPU** nehmen oder akzeptieren, dass das Teil mit der Tür in der Stellung abkühlt, in der du sie gelassen hast.

Die Werte sind Startpunkte; die genaue Lösetemperatur hängt von Platte und Teil ab – mit einem Testdruck ermitteln.
