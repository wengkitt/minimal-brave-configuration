# Brave Origin-like configuration

An unofficial, reversible configuration that makes regular desktop Brave closely resemble the **Brave Origin upgrade experience** by applying documented browser policies and a small set of recommended privacy settings.

> [!IMPORTANT]
> This is **not Brave Origin**, does not install the standalone Origin build, does not unlock a purchase, and does not bypass activation or payment. The standalone product compiles features out; this project only disables or hides features in regular Brave. Brave and Brave Origin are trademarks of Brave Software, Inc. This project is not affiliated with or endorsed by Brave Software.

## Support Brave

This project is a community settings guide, not an alternative product and not an attempt to avoid supporting Brave. Brave develops and maintains the browser, Shields, Chromium security updates, and the official Origin experience. That work costs money.

If you find this configuration useful and can afford it, please consider [purchasing Brave Origin through Brave](https://brave.com/origin/) to support continued browser development. A purchase provides the official experience, including the standalone Origin build where available, easier built-in management, and automatic handling of new non-core features. This guide cannot provide those benefits.

The manual configuration remains useful for learning what the settings do, testing the workflow before purchasing, documenting managed installations, and helping users who need to make these choices themselves. Please use it in a way that respects Brave's work, trademarks, and official licensing.

## What it changes

The installers disable the currently documented Origin-related features:

- Leo, News, Playlist, Rewards/Ads, Speedreader and Talk
- Tor, VPN, Wallet/Web3 domains and Wayback Machine
- P3A, daily usage ping and Web Discovery
- usage and crash reporting through the Chromium `MetricsReportingEnabled` policy

The policy set is based on Brave's [Origin explanation](https://support.brave.app/hc/en-us/articles/38561489788173-What-is-Brave-Origin) and [Group Policy reference](https://support.brave.app/hc/en-us/articles/360039248271-Group-Policy). See [the policy matrix](docs/POLICY-MATRIX.md) for exact values and limitations.

## Requirements

- Brave 1.84 or newer is recommended (some policies appeared in 1.82–1.84).
- Administrator/root access to install machine policies.
- Desktop macOS or Windows. Mobile platforms are not covered.

Linux is intentionally not supported by this project because Brave provides the [official Brave Origin experience free on Linux](https://support.brave.app/hc/en-us/articles/38561489788173-What-is-Brave-Origin). Linux users should use that instead of recreating it with this configuration.

## Install

Download or clone this repository, fully quit Brave, then run the command for your OS.

### macOS

```bash
cd scripts/macos
sudo ./install.sh
```

### Windows

Open PowerShell **as Administrator**:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\scripts\windows\install.ps1
```

Relaunch Brave, open `brave://policy`, click **Reload policies**, and follow [verification](docs/VERIFY.md). Seeing “Managed by your organization” is expected: local machine policies trigger that Chromium label even on a personal computer.

## Recommended Shields setup

The scripts deliberately do not force Shields preferences, because site compatibility is personal and these controls are not part of Origin. A simple, effective setup is documented in [Shields recommendations](docs/SHIELDS.md).

## Reproduce the complete experience

After installing the policies, follow the [complete configuration checklist](docs/COMPLETE-SETUP.md). It covers:

- the minimalist New Tab page;
- appearance, tabs, toolbar and sidebar;
- privacy and diagnostic settings;
- Shields, content filters and social-media blocking;
- final verification.

The policy scripts automate only settings that Brave officially exposes as managed policies. The remaining interface preferences are documented as manual steps so they stay transparent, portable and easy to adjust.

## Undo

Fully quit Brave and run the matching uninstall script with the same administrator privileges:

- macOS: `sudo ./scripts/macos/uninstall.sh`
- Windows (Administrator PowerShell): `.\scripts\windows\uninstall.ps1`

The uninstallers remove only this project's named policies. macOS and Windows installers also preserve pre-existing values so uninstall can restore them.

## Limitations

- This mirrors the **upgrade-style behavior**, not the standalone Origin binary. Disabled code remains in regular Brave.
- Brave can add features or policies later. Check the official policy reference after major Brave updates.
- Email aliases are currently a Nightly feature and have no documented policy in Brave's public policy table, so this project cannot reliably control them.
- A policy may be unavailable on an older build or restricted by platform management rules. `brave://policy` is the source of truth on your device.
- Existing company/device-management policies take precedence and should not be changed without administrator approval.

## Security

Read scripts before running them. They require elevated privileges only to write browser policy locations. The project contains no downloads, telemetry, credentials, or background services. See [SECURITY.md](SECURITY.md).

## License

MIT — see [LICENSE](LICENSE).
