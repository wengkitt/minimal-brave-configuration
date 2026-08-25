# Complete minimalist Brave configuration

This checklist applies the complete balanced configuration documented by this project. It combines documented feature-disabling policies with a minimalist interface and practical Shields protection, inspired by the feature choices in Brave Origin.

This is a manual settings guide, not the official Brave Origin product or a license workaround. If the experience is valuable to you and you can afford it, consider [purchasing Brave Origin](https://brave.com/origin/) to support Brave's continued browser, privacy, and security work. The official product provides benefits this configuration cannot provide; see the main [README](../README.md).

Brave occasionally renames or moves controls. Use Settings search if a label is not in the stated section. The values below were verified with Brave 1.93 on desktop.

## 1. Install the Origin-related policies

Run the installer for your operating system from the main [README](../README.md), restart Brave, and verify every supported entry at `brave://policy` using [VERIFY.md](VERIFY.md).

This disables Leo, News, Playlist, Rewards/Ads, Speedreader, Talk, Tor, VPN, Wallet/Web3 domains, Wayback Machine, P3A, the daily statistics ping, Web Discovery, and usage/crash reporting.

## 2. New Tab page

Open a new tab and choose **Customize**. Use this minimalist setup:

| New Tab item | Setting |
|---|---|
| Sponsored images | **Off** |
| Brave News | **Off** |
| Brave Rewards card | **Off** |
| Background images | **Personal preference**; plain/off is the most minimalist |
| Top Sites / Favorites | **On** if useful; this is local convenience, not an Origin feature |
| Stats | **On** if useful; these are local blocked-item/time-saved counters, not the disabled daily usage ping |
| Clock | **On** if useful |
| Cards/widgets not needed | **Off** |

The managed policies may hide News and Rewards entirely. That is expected. Sponsored background images must be off; ordinary non-sponsored backgrounds do not fund or activate a Brave service, so their appearance is optional.

## 3. Appearance

Open `brave://settings/appearance` and apply these values:

| Setting | Value |
|---|---|
| Show tab search button | **On** |
| Show home button | **Off** |
| Bookmarks bar | **Only on the New Tab page** |
| Show tab groups in bookmarks bar | **On** |
| Automatically pin new tab groups | **On** |
| Address-bar autocomplete suggestions | **On** |
| Suggestion sources | **On-device, Browsing History, Bookmarks and Quick commands: On** |
| Use wide address bar | **Off** |
| Always show full URLs | **Off** |
| Always show toolbar in full screen | **On** |
| Compact mode | **Off** |
| Rounded corners on main content | **Off** |

Theme and color scheme are personal and do not affect the feature-disabling policies.

### Tabs

| Setting | Value |
|---|---|
| Vertical tabs | **Off** |
| Disable mute through speaker icon | **Off** |
| Always hide tab close button | **Off** |
| Middle-click closes tabs | **On** |
| Scrollable tab strip | **Off** |
| Tab hover mode | **Card** |
| Show memory usage on hover card | **On** |
| Inactive-tab appearance | **On** |

### Sidebar

Set **Show Sidebar** to **Never**. Its side preference is irrelevant while disabled; this configuration retains the default right side.

## 4. Toolbar

Under **Appearance → Customize your toolbar**, use this uncluttered layout:

| Button | Value |
|---|---|
| Forward | **On** |
| Add Bookmark | **On** |
| Install app | **On** |
| Home | **Off** |
| Open in Split View | **Off** |
| New Private Window | **Off** |
| Sidebar | **Off** |
| Password Manager | **Off** |
| Bookmarks Panel | **Off** |
| Reading List | **Off** |
| Downloads | **Off** |
| Delete Browsing Data | **Off** |
| Print, QR Code, Cast and Copy Link | **Off** |
| Send to your devices | **Off** |
| Task Manager and Developer Tools | **Off** |

Shields remains available in the address bar. Origin-related buttons such as Leo, VPN, Rewards and Wallet should be hidden by policy.

## 5. Privacy and security

Keep Brave's security protections and updates enabled. Then confirm:

- **Automatically send diagnostic reports** — Off. The project also requests this through `MetricsReportingEnabled=false`; the visible setting is a useful second check.
- **Web Discovery Project** — Off or unavailable because it is policy-disabled.
- **P3A / product analytics** — Off or unavailable because it is policy-disabled.
- **Safe Browsing** — Standard protection is the balanced recommendation. Do not disable it merely to imitate Origin.
- **Secure DNS** — Leave enabled with your preferred provider unless it causes a network-specific problem.
- **Clear cookies on exit / Forget me** — Off globally; use per-site when forced sign-out is wanted.

Sync is not part of Brave's published Origin-affected feature list. It can remain enabled if you use it.

## 6. Shields and content filters

Apply every value in [SHIELDS.md](SHIELDS.md). The resulting baseline is:

- Trackers and ads: **Aggressive**
- HTTPS upgrades: **Standard**
- Script blocking: **Off globally**
- Fingerprinting blocking: **On**
- Cookies: **Block third-party cookies**
- “Forget me when I close this site”: **Off globally**
- Save broken-site report contact information: **Off**
- Facebook embeds/logins: **Allowed**
- X embeds: **Allowed**
- LinkedIn embeds: **Blocked**

Enable EasyList Cookie, Fanboy's Anti-Newsletter and Fanboy's Mobile Notifications. Enable AdGuard Chinese if you frequently browse Chinese-language sites such as `ifun.tv`.

## 7. Final review

1. Restart Brave.
2. Confirm the policy table at `brave://policy`.
3. Confirm the New Tab page has no sponsored imagery, News or Rewards card.
4. Confirm there are no Leo, VPN, Rewards, Wallet or Sidebar toolbar buttons.
5. Visit a normal site and inspect the Shields panel to confirm the global baseline.
6. Test login and video playback on your commonly used sites. Use a site-specific Shields exception before weakening the global defaults.

At this point regular Brave has the documented **minimalist interface and balanced Shields configuration**, with the selected features disabled through ordinary policies. It is still regular Brave—not the Origin upgrade or standalone Origin binary; see the limitations in the main README.
