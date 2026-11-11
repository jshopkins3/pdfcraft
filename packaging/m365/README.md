# Company catalog package

This wraps the deployed Command PDF browser editor as a personal tab in supported
Microsoft 365 hosts. It requests no Graph permissions, mail access, file access,
identity permission or bot installation. Files are selected and downloaded by the
user. The app is not an Outlook attachment handler or cloud save-back integration.

The builder's command below packages the shelf's approved app address into a ZIP;
it does not upload or install anything in Microsoft's catalog:

```powershell
python packaging/m365/package.py --url https://VERIFIED-APP-HOST --out dist/release/command-pdf-m365-pilot.zip
```

Replace the example host with the verified HTTPS site. Keep the app ID stable on
updates, and increment `--version` for each catalog update. The ZIP contains only
manifest.json and the required color and outline icons. Those icons derive from
the existing approved Command mark and are recorded in ATTRIBUTION.toml.

Use the existing cloud administrator account at
https://admin.teams.microsoft.com/policies/manage-apps. Direct access was verified
November 11, 2026; the general Microsoft 365 admin landing page redirected to GoDaddy.
Entra's My Apps link is an optional launch shortcut, not this embedded app catalog.

For the first installation, limit availability to John while verifying synthetic
open/edit/form/comment/download/reopen and Print to PDF in the actual Outlook and
Teams clients. Do not treat an uploaded manifest or standalone browser pass as
client acceptance. Expand availability to the small pilot only after that result.

Reference: https://learn.microsoft.com/en-us/microsoftteams/platform/m365-apps/publish
