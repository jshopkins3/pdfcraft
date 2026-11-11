# Command PDF — Windows x64 pilot

![Command mark](docs/brand/command-mark.svg)

A local Windows PDF app for My Community Mortgage, based on **PdfCraft v0.10.1** by the ArtCraft Team and contributors. This fork preserves the PDF engine and file safeguards while using Command branding, separate installer IDs and separate user storage.

This is a pilot candidate. Final-source checks, publisher signing and John’s acceptance are recorded separately. It is not an approved employee download yet. See [pilot scope and acceptance](docs/command-pdf-pilot.md) and [publisher signing setup](docs/command-pdf-signing.md).

## Trying the pilot

1. Keep Acrobat available and use copies of documents. The installer requires Windows administrator rights and installs into `Program Files\Command PDF`.
2. Open a test PDF, search its text, rotate pages, add comments or fill a form, then save a new copy. Check the saved copy in another PDF reader.
3. Try combining test files and confirm the page order. Test printing with your own printer before depending on it for production documents.
4. Use **Get help** to open the signed-in Intra-Lounge and find company contacts.
5. To roll back, uninstall Command PDF through Windows Installed apps. Keep the original documents and your existing PDF app.

The installer offers Open with and optional context menus. It leaves the default PDF reader to the user. The portable package keeps settings and recovery data in `CommandPDFData` beside the executable. Both packages include the bundled OCR models and notices.

The app inherits PdfCraft’s alpha status. A test of a synthetic file does not establish compatibility with every lender document, signature or printer. Direct Command, Arive and SharePoint document integration is outside this pilot.

## Candidate downloads

[Draft pilot PR](https://github.com/jshopkins3/pdfcraft/pull/1) · [Windows build jobs and test artifacts](https://github.com/jshopkins3/pdfcraft/actions/workflows/command-pdf-pilot.yml)

Build artifacts are review candidates. An approved employee download will be published separately after acceptance. No release or Intra-Lounge download is published automatically by the build workflow.

## Building from this desk

Use Rust 1.95.0 with MSVC, the Windows SDK and WiX 5.0.2. The workflow pins its font input and build tools. Internal Rust crate names remain `pdfcraft*` for compatibility; the packaged programs are `command-pdf.exe` and `command-pdf-cli.exe`.

From this fork’s desk, this builds the app and CLI, checks x64 executable headers, and creates the MSI and portable package:

```powershell
pwsh packaging/windows/package.ps1 -Arch x64
```

Outputs are `dist/release/command-pdf-0.10.1-windows-x64.msi` and `dist/release/command-pdf-0.10.1-windows-x64-portable.zip`. Builds without a configured signing identity are explicitly unsigned test candidates. Required-signing mode refuses that fallback; see the signing setup document.

The hosted acceptance job installs, repairs, reinstalls and uninstalls the MSI. It exercises synthetic PDF operations through the installed CLI, then reads the saved results with an independent PDF library. The separate desktop check uses the app’s opt-in local test interface and synthetic files. Physical printer output and employee acceptance have their own receipts.

## Source map

- `apps/pdfcraft`: desktop entry point, native icon, window identity and manual update destination.
- `crates/ui-egui`: existing desktop interface and Command labels.
- `crates/engine` and `crates/automation`: existing PDF engine and discoverable local tools.
- `packaging/windows`: installer, portable package, signing and acceptance checks.
- `ATTRIBUTION.toml` and `ATTRIBUTION.md`: asset provenance and generated credits.

[Original pinned PdfCraft reference](https://github.com/storytold/pdfcraft/tree/b77d57000c22c760f731206f6cf14486d149de72) · [engine architecture](docs/architecture.md)

## Licenses and credits

Code remains **MIT OR Apache-2.0**. Original copyright and contributor notices remain in [NOTICE](NOTICE), [LICENSE-MIT](LICENSE-MIT) and [LICENSE-APACHE](LICENSE-APACHE). Third-party assets, fonts and models retain their own licenses and are listed in [ATTRIBUTION.md](ATTRIBUTION.md).

Command marks belong to My Community Mortgage and have restricted product-specific permission in [LICENSE-command.txt](docs/brand/LICENSE-command.txt). They are not relicensed under the code license. Upstream ArtCraft trademark graphics have been removed from this fork; plain-text attribution to PdfCraft and its contributors is retained.
