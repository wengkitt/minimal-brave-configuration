# Security policy

Please report a security issue through GitHub's private security-advisory feature rather than a public issue.

The scripts make only these privileged changes:

- macOS: Brave's managed-preferences plist and a local backup under `/Library/Application Support/BraveOriginLikeConfig`
- Windows: named Brave policy registry values and a local backup under `%ProgramData%\BraveOriginLikeConfig`

They do not download or execute remote code, collect data, or contact a network service.
