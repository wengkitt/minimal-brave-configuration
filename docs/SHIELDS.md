# Recommended Shields settings

This balanced setup is simple, strong, and unlikely to break many sites:

| Setting | Recommendation | Why |
|---|---|---|
| Trackers & ads blocking | **Aggressive** | Strong first-party and third-party blocking |
| Upgrade connections to HTTPS | **Standard** | Upgrades safely and falls back when a site cannot use HTTPS |
| Block scripts | **Off** | Global script blocking breaks many modern sites; enable per-site when needed |
| Block fingerprinting | **On** | Useful anti-tracking protection |
| Cookies | **Block third-party cookies** | Strong cross-site protection with reasonable compatibility |
| Forget me when I close this site | **Off globally** | Enable per-site for sites where forced sign-out is desirable |
| Store contact info for broken-site reports | **Off** | Avoids retaining optional report contact data |

HTTPS **Strict** is appropriate if you prefer fail-closed security and accept manually handling old HTTP-only sites. Standard is the practical default because it still upgrades connections but avoids needless breakage.

## Content filters

Start small; overlapping lists increase breakage and debugging work.

- EasyList Cookie
- Fanboy's Anti-Newsletter
- Fanboy's Mobile Notifications
- AdGuard Chinese, **optional** for frequent Chinese-language sites such as `yfsp.tv`

Do not enable every regional or annoyance list. Add one list at a time, then test common sites. If video playback or login fails, lower Shields for that site or temporarily disable the most recently added list.

## Social media blocking

For the balanced configuration documented by this repository:

- **Allow Facebook logins and embedded posts** — On
- **Allow X embedded posts** — On
- **Allow LinkedIn embedded posts** — Off

This keeps commonly used Facebook and X embeds working while blocking LinkedIn embeds. These controls affect third-party content embedded on other sites; they do not prevent visiting the social networks directly. For maximum privacy, turn all three allowances off, accepting that embedded posts and some social-login buttons may stop working.
