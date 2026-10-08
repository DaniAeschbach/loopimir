<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="images/logo-wide-light.png">
  <img src="images/logo-wide.png" width="360" alt="Loopimir">
</picture>

### Run your Bambu Lab print farm unattended.
One dashboard, any number of printers, no subscription.

[![Release](https://img.shields.io/github/v/release/DaniAeschbach/loopimir?include_prereleases&color=2f8a55)](https://github.com/DaniAeschbach/loopimir/releases)
[![Free](https://img.shields.io/badge/price-free-2f8a55.svg)](LICENSE)
[![Printers](https://img.shields.io/badge/printers-P2S%20%C2%B7%20A1%20%C2%B7%20P1S-F07800.svg)](docs/PRINTERS.md)
[![Platform](https://img.shields.io/badge/platform-Linux%20x86--64-444.svg)](docs/GUIDE.md)

[**Deutsch**](README.de.md) · [Guide](docs/GUIDE.md) · [Troubleshooting](docs/TROUBLESHOOTING.md)

<img src="images/dashboard.jpg" width="820" alt="Loopimir dashboard">

</div>

## What it does

Upload models (or a whole order). Loopimir slices each piece for the printer it runs on, prints it, cools it right for the material, ejects it, and starts the next one — on all your printers, from one shared queue.

<div align="center">
<img src="images/how-it-works.svg" width="860" alt="How it works: upload, slice, print, cool, eject, then the next part automatically">
</div>

## Why Loopimir

- 🖨️ **Many printers, one queue** — jobs go to a printer that has the filament loaded and the shortest line.
- ♻️ **Hands-off ejection** — cools per material, then bends and pushes the part off so the next job can start.
- 🧩 **Your hardware, your choice** — printer only, passive bender, or the FarmLoop Stage 2 board.
- 🔒 **Stays on your network** — no cloud account required, no subscription. LAN mode or a signed-in Bambu Studio.
- 🇩🇪🇬🇧 **German & English** — the app and every doc page.

## Install

On an always-on x86‑64 Linux machine (Debian / Ubuntu / Mint, ~4 GB RAM — a Raspberry Pi does not work):

```bash
curl -fsSL https://raw.githubusercontent.com/DaniAeschbach/loopimir/main/scripts/install.sh | bash
```

Open `http://<your-machine>:8090`, set a page password, add your printers, drop in a model, switch on **Start jobs automatically**. That's it.
To update, run the same command again — or let Loopimir update itself (*Settings → Updates*).

→ Full walkthrough: [**Guide**](docs/GUIDE.md)

## Printers

| | Status | Extra hardware (optional) |
|---|---|---|
| **Bambu Lab P2S** | ✅ proven | Printer only · Passive bender *(experimental)* · FarmLoop Stage 2 |
| **Bambu Lab A1** | ✅ tested | Printer only · FarmLoop Stage 2 |
| **Bambu Lab P1S** | 🧪 **beta** — no real print yet | Printer only · Passive bender · FarmLoop Stage 2 |

> Pre-release: start with short test prints and stay nearby until you trust your setup. Details in [docs/PRINTERS.md](docs/PRINTERS.md).

## Docs

| | |
|---|---|
| [**Guide**](docs/GUIDE.md) | Install and your first print |
| [Printers & hardware](docs/PRINTERS.md) | Models, the extra-hardware options, the push |
| [Board](docs/BOARD.md) | FarmLoop Stage 2: flashing, setup, wiring |
| [Cooling](docs/COOLING.md) | Per-material cooling profiles |
| [Bambu Studio mode](docs/STUDIO-MODE.md) | Keep the printer in the Bambu cloud |
| [Troubleshooting](docs/TROUBLESHOOTING.md) | Printer offline, upload fails, queue waits … |

Found a bug or tested a printer? [Open an issue](https://github.com/DaniAeschbach/loopimir/issues/new/choose) — test reports are very welcome.

## License

Free to use and share, closed source — see [LICENSE](LICENSE) and [NOTICE](NOTICE.md). Not affiliated with Bambu Lab. Use at your own risk.
