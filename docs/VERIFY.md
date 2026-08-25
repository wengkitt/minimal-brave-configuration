# Verify the result

1. Fully quit and relaunch Brave.
2. Open `brave://policy`.
3. Click **Reload policies**.
4. Each policy in the [policy matrix](POLICY-MATRIX.md) should show the intended value, **Machine**, **Mandatory**, and **OK**.
5. Open `brave://settings` and confirm the affected features are absent, disabled, or unavailable.

If a policy is missing, update Brave and restart it. If it shows an error, check that its type is Boolean/DWORD rather than text. `MetricsReportingEnabled` can require an OS-recognized managed state on some platforms; if Brave does not enforce it, turn off diagnostic reporting manually in Brave's privacy settings.

The “Managed by your organization” label is normal after installing machine policies. It does not mean a remote organization was added; these scripts create local policies. Uninstalling all locally applied policies and restarting Brave removes the label unless another tool also manages the browser.

## Confirm reversibility

Run the OS-specific uninstall script, restart Brave, then reload `brave://policy`. Project-owned values should be gone or restored to their pre-install values.
