# Keeping the guide current

The repository includes a weekly GitHub Actions monitor. It checks:

- Brave's official “What is Brave Origin?” article body;
- Brave's official Group Policy article body;
- the latest non-prerelease `brave/brave-browser` release.

The workflow runs every Monday at 02:17 UTC and can also be started from **Actions → Monitor upstream Brave changes → Run workflow**.

If a source differs from `.github/upstream-baseline.json`, the workflow opens one issue titled **Upstream Brave changes detected**. It will not create duplicates while that issue remains open.

## Responding to an alert

1. Open the links in the generated issue and inspect the upstream changes.
2. Compare the Origin feature list with `docs/POLICY-MATRIX.md` and the policy files/scripts.
3. Test the complete setup on current macOS and Windows Brave releases.
4. Update the documentation and scripts if necessary.
5. Refresh the baseline only after completing that review:

```bash
python3 scripts/monitor/check_upstream.py --write-baseline .github/upstream-baseline.json
```

6. Commit the documentation and baseline together, then close the maintenance issue.

7. Create a release tag for the Brave version that was tested. Tags use the exact format `brave-X.Y.Z`, for example:

```bash
gh release create brave-1.93.138 \
  --title "Verified for Brave 1.93.138" \
  --notes "Configuration reviewed and verified for Brave 1.93.138."
```

Update the version badge and current-version statement in `README.md` in the same maintenance change. A release means the guide was actually reviewed against that Brave version; do not create a tag merely because Brave published a new build.

Refreshing a baseline means “this upstream state has been reviewed”; do not refresh it merely to silence an alert.

## Release convention

- Use `brave-X.Y.Z` tags so users can immediately see the corresponding Brave version.
- Treat tags as immutable snapshots; correct mistakes with a new patch tag or clearly documented replacement release rather than moving an existing tag.
- State which operating systems were tested in the release notes.
- Keep older releases available for users who have not upgraded Brave yet.

## Additional notifications

On GitHub, watch the official [`brave/brave-browser`](https://github.com/brave/brave-browser) repository with **Watch → Custom → Releases**. Its release feed also contains prereleases, so prioritize entries titled **Release**, not Nightly or Beta.
