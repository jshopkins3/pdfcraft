# Command PDF browser pilot

John approved this scope November 11, 2026. Task PDFWEB-1; owner Codex chat
01a1c0dc-5ea8-77b3-9b9f-8cd7a9d3c944. Existing Windows work is preserved.

Map: current main + existing Command branding -> browser candidate -> local synthetic
open/edit/form/comment/save/reopen/split/print -> HTTPS DigitalOcean static host ->
Microsoft 365 app manifest -> actual Outlook and Teams acceptance -> small catalog pilot.
The same URL may be installed as a standalone Edge app with Start/taskbar shortcuts.

Scope: Rust browser shell and platform file/print integration, a static host package,
M365 manifest, build workflow, synthetic acceptance and staff instructions. No OCR,
borrower documents, account/permission expansion, employee announcement, or forced install.
The M365 SDK is a pinned, integrity-checked vendor dependency; handwritten product JS
is not introduced. The SDK receives host-lifecycle messages, never PDF document bytes.

Basic workflows passed the prior upstream runtime assessment. They must pass again on
the exact branded candidate and actual M365 hosts. A standalone browser pass does not
establish Outlook/Teams desktop behavior. Split exports now use one ZIP because browsers
can suppress subsequent automatic downloads. Download URLs survive for 60 seconds so
embedded browser clients can consume them. Saving remains a file download, not a cloud
save-back integration. Do not describe a started download as a verified file on disk.

The pilot's web entry needs no Windows signing subscription or public Store listing.
Hosting remains on DigitalOcean. OCR, certificate signing, complex forms, large files
and advanced tools remain outside this first browser acceptance.

Verification pending: integration into main, exact-head hosted build/checks, branded browser
runtime, actual Outlook/Teams open/save/reopen/print, catalog installation and Edge shortcut.
Rollback: remove the pilot catalog entry and restore the last accepted static package;
leave employees' downloaded files and existing desktop installation untouched.

Deployment uses `packaging/web/digitalocean-pilot.json` with three explicit BUILD_TIME
values: COMMAND_PDF_PACKAGE_URL, COMMAND_PDF_PACKAGE_SHA256 and COMMAND_PDF_SOURCE_SHA.
The static builder downloads only the chosen release, verifies its checksum, validates
ZIP paths and bounds, and publishes its source ID at build.json. It never compiles Rust
on the production server. The app spec has no service, worker or database. November 11
API proposal classified it as static; the account had zero static apps and a free
allowance of three. The proposal omitted app_cost, so no numeric cost was returned.
DigitalOcean's published static-site allowance and bandwidth terms still apply.

The hosting source directory is `packaging/web/static-source`, containing only the
HTML build entry. DigitalOcean detects buildpacks before the custom command; using
`apps/pdfcraft-web` incorrectly selects Rust because that directory has Cargo.toml.
The custom command runs the adjacent `prepare-static.sh` and publishes only `site/`,
so the build entry is never served as the editor. The release artifact retains its
actual compiled source SHA even when a later main commit changes hosting settings.

The direct Teams admin Manage apps page and Entra cloud-admin access were observed in
Chrome. This bypasses the general admin-center landing page for this workflow; it does
not remove the tenant's GoDaddy redirect or change any employee sign-in configuration.
