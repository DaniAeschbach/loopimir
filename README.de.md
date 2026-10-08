<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="images/logo-wide-light.png">
  <img src="images/logo-wide.png" width="360" alt="Loopimir">
</picture>

### Deine Bambu‑Lab‑Druckfarm läuft von allein.
Ein Dashboard, beliebig viele Drucker, kein Abo.

[![Release](https://img.shields.io/github/v/release/DaniAeschbach/loopimir?include_prereleases&color=2f8a55)](https://github.com/DaniAeschbach/loopimir/releases)
[![Kostenlos](https://img.shields.io/badge/Preis-kostenlos-2f8a55.svg)](LICENSE)
[![Drucker](https://img.shields.io/badge/Drucker-P2S%20%C2%B7%20A1%20%C2%B7%20P1S-F07800.svg)](docs/PRINTERS.md)

[English](README.md)

<img src="images/dashboard.jpg" width="820" alt="Loopimir Dashboard">

</div>

## Was es macht

Modelle (oder eine Bestellung) hochladen. Loopimir slict jedes Teil für den Drucker, auf dem es läuft, druckt es, kühlt passend zum Material ab, wirft es aus und startet das nächste — auf allen Druckern aus einer Warteschlange.

## Installieren

```bash
curl -fsSL https://raw.githubusercontent.com/DaniAeschbach/loopimir/main/scripts/install.sh | bash
```

`http://<deine-maschine>:8090` öffnen, Drucker hinzufügen, ein Modell hineinziehen, **Automatisch starten** einschalten. Fertig.
Braucht einen dauerhaft laufenden x86‑64‑Linux‑Rechner (Debian / Ubuntu / Mint, ~4 GB RAM) — ein Raspberry Pi geht nicht.
Zum Aktualisieren denselben Befehl noch einmal ausführen (oder Loopimir aktualisiert sich selbst: *Einstellungen → Updates*).

## Drucker

| | Stand | Zusatz‑Hardware (optional) |
|---|---|---|
| **Bambu Lab P2S** | ✅ erprobt | Nur Drucker · Passiver Bender *(experimentell)* · FarmLoop Stage 2 |
| **Bambu Lab A1** | ✅ getestet | Nur Drucker · FarmLoop Stage 2 |
| **Bambu Lab P1S** | 🧪 **Beta** — noch kein echter Druck | Nur Drucker · Passiver Bender · FarmLoop Stage 2 |

> Vorabversion: mit kurzen Testdrucken beginnen und in der Nähe bleiben, bis du deinem Aufbau traust. Details: [docs/PRINTERS.md](docs/PRINTERS.md).

## Anleitungen

[**Anleitung**](docs/GUIDE.md#deutsch) · [Drucker & Hardware](docs/PRINTERS.md#deutsch) · [Board](docs/BOARD.md#deutsch) · [Kühlprofile](docs/COOLING.md#deutsch) · [Bambu‑Studio‑Weg](docs/STUDIO-MODE.md#deutsch) · [Fehlersuche](docs/TROUBLESHOOTING.md#deutsch) · [Änderungen](CHANGELOG.md) · [Sicherheit](SECURITY.md)

Fehler gefunden oder einen Drucker getestet? [Issue eröffnen](https://github.com/DaniAeschbach/loopimir/issues/new/choose) — Testberichte sind sehr willkommen (gern auf Deutsch).

## Lizenz

Kostenlos nutzbar und weitergebbar, Quellcode nicht offen — siehe [LICENSE](LICENSE) und [NOTICE](NOTICE.md). Nicht mit Bambu Lab verbunden. Nutzung auf eigenes Risiko.
