# Policy matrix

These documented policy values disable the features Brave currently lists as affected by Origin. Boolean values are stored as plist booleans on macOS and DWORD `0`/`1` on Windows.

| Policy | Value | Effect |
|---|---:|---|
| `TorDisabled` | `true` | Disables private windows with Tor |
| `BraveRewardsDisabled` | `true` | Disables Rewards and browser-based Brave Ads |
| `BraveWalletDisabled` | `true` | Disables Wallet and Web3 domains |
| `BraveVPNDisabled` | `true` | Disables VPN |
| `BraveAIChatEnabled` | `false` | Disables Leo |
| `BraveNewsDisabled` | `true` | Disables News |
| `BraveTalkDisabled` | `true` | Disables Talk |
| `BraveSpeedreaderEnabled` | `false` | Disables Speedreader |
| `BraveWaybackMachineEnabled` | `false` | Disables Wayback Machine prompts |
| `BraveP3AEnabled` | `false` | Disables privacy-preserving product analytics |
| `BraveStatsPingEnabled` | `false` | Disables daily usage/statistics ping |
| `BraveWebDiscoveryEnabled` | `false` | Disables Web Discovery Project |
| `BravePlaylistEnabled` | `false` | Disables Playlist where supported |
| `MetricsReportingEnabled` | `false` | Disables usage and crash-related reporting |

The first 13 are documented in Brave's [Group Policy reference](https://support.brave.app/hc/en-us/articles/360039248271-Group-Policy). `MetricsReportingEnabled` is an inherited Chromium policy documented by [Chrome Enterprise](https://chromeenterprise.google/policies/metrics-reporting-enabled/); confirm it appears without an error at `brave://policy` because enforcement support can vary by operating-system management state.

## Intentionally not changed

- Safe Browsing, updates and security services remain enabled.
- Sync is not disabled; Origin's published affected-feature list does not include Sync.
- Shields behavior is user-configurable and documented separately.
- No Origin flag, purchase token, activation state or executable is modified.
