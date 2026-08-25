# Minimal Brave configuration

[![Verified with Brave 1.93.138](https://img.shields.io/badge/verified%20with%20Brave-1.93.138-FB542B)](https://github.com/wengkitt/minimal-brave-configuration/releases/tag/brave-1.93.138)

An unofficial, reversible guide for creating a minimalist regular Brave setup, inspired by the feature choices in **Brave Origin**, using documented browser policies and ordinary user settings.

**Current verified Brave version:** `1.93.138`. The configuration and policy behavior were checked in Brave 1.93.138 on macOS. Windows scripts have been reviewed for syntax and policy parity but have not yet been exercised on a Windows device. See [Releases](https://github.com/wengkitt/minimal-brave-configuration/releases) for immutable versioned snapshots.

> [!IMPORTANT]
> This is **not Brave Origin** and is not a substitute for the official product. It does not install Origin, enable paid functionality, modify purchase or activation state, or circumvent an access control. It only automates documented policies and settings available in regular Brave. Brave and Brave Origin are trademarks of Brave Software, Inc. This project is independent and is not affiliated with, sponsored by, or endorsed by Brave Software. See [NOTICE.md](NOTICE.md).

## Support Brave

This project is a community settings guide, not an alternative product and not an attempt to avoid supporting Brave. Brave develops and maintains the browser, Shields, Chromium security updates, and the official Origin experience. That work costs money.

If you find this configuration useful and can afford it, please consider [purchasing Brave Origin through Brave](https://brave.com/origin/) to support continued browser development. A purchase provides the official experience, including the standalone Origin build where available, easier built-in management, and automatic handling of new non-core features. This guide cannot provide those benefits.

The manual configuration remains useful for learning what the settings do, testing the workflow before purchasing, documenting managed installations, and helping users who need to make these choices themselves. Please use it in a way that respects Brave's work, trademarks, and official licensing.

## Staying up to date

A weekly GitHub Actions monitor checks Brave's official Origin documentation, Group Policy documentation, and latest stable release. If something changes, it opens a maintenance issue with a review checklist. See [Keeping the guide current](docs/MAINTENANCE.md).

## How this guide was developed

This project began as a hands-on collaboration between the repository maintainer and an AI coding assistant. The maintainer asked the assistant to inspect and help create a minimalist regular Brave configuration inspired by Origin's feature choices. The assistant researched Brave's official Origin and Group Policy documentation, operated the browser settings under the maintainer's direction, and verified the resulting policies at `brave://policy`.

The configuration was refined through an ongoing conversation. The maintainer reviewed the results, asked questions about choices such as Standard HTTPS upgrades, content-filter lists, Chinese-language website compatibility, and social-media blocking, and made the final decisions about the recommended balance between privacy and site compatibility. The same process was used to review the New Tab page, appearance, toolbar, sidebar, and other browser settings.

After the browser setup was working, the maintainer asked the assistant to turn the experience into a public, reversible, cross-checked guide. Together, that work became the documentation, platform scripts, verification steps, safety notes, and automated upstream-change monitor in this repository.

AI assistance helped with research, browser operation, drafting, scripting, and validation, but the project was initiated and directed by the maintainer. Recommendations should still be checked against Brave's current official documentation, and community testing and corrections are welcome. No passwords, browsing data, or other private session information are included in this repository.

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

## Apply the complete configuration

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
