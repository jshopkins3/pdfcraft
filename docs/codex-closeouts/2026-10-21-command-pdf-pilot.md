# Command PDF pilot test receipt — 2026-10-21

KIND: NEW. Direct John request: build Windows x64 Command PDF and test before any Intra-Lounge distribution. ARC: first internal desktop PDF pilot. First of installed Command tools; later versions replace this.

John deferred publisher signing on October 21. No Azure purchase or enrollment; no signing prerequisite for his personal trial. No main merge, GitHub release or Intra-Lounge publication.

## Download under test

Source: 42366544c4d4f103f9080585fece7b50699b5b87. Build: https://github.com/jshopkins3/pdfcraft/actions/runs/39633795556 .

MSI: command-pdf-0.10.1-windows-x64.msi, 72,384,512 bytes. SHA256: d33f56ffd7832565195de39cede6d8f28424fbcffe26c66ce9431d0e1a5e94b2 . Portable ZIP SHA256: 2069ebe1aa64d93e3aa16500e7350eb3c032556d974ef1215ae6d92a58b82ce9 . Both downloaded hashes independently matched the run receipt. Authenticode: NotSigned.

Local candidate and receipts: C:/Command/handoffs/command-pdf-4236654 . These local screenshots are machine-local evidence, not published assets.

## Verification layers

Windows hosted runner: MSI install, installed branding/licenses, repair, same-version reinstall and uninstall passed. Compiled MSI scope/default-association checks passed. Synthetic create/rotate/comment/form-fill/combine/search/save/reopen/render/print-ready PDF and independent pypdf readback passed. 629 core tests passed, four ignored. Source formatting, asset provenance and architecture checks passed.

Run overall FAILED: actual UI group selected eight tests, seven passed; home_screen_links failed because label Command matches both Image and Button. Five intended links tests were actually selected; four passed and one had that selector failure. No assertion removed. Test-only e240aff2092758d5a9b571e166ba5f69c374e1ac selects Button plus label, preserving destination checks. Rerun https://github.com/jshopkins3/pdfcraft/actions/runs/39668926709 is pending at this receipt. No aggregate green claimed. Earlier c992 run passed Clippy but mistakenly selected zero UI links tests; that false green was caught and corrected.

Windows 11 Pro x64 native candidate423: actual app rendered with no page errors; save persisted an additional90-degree rotation (90 to180), independent pypdf retained field PilotReviewer=MCM synthetic reviewer. Image-only PDF OCR independently recovered123.45. Home screenshot visually inspected. App quit normally with no dirty prompt. Prior c992, whose app source is identical to423, additionally passed desktop search, light/dark and interface scaling100/150/200; these are interface scale checks, not a physical display matrix. At200 close side panels for reading room. App launch must be visible during input testing; hidden-window input timeouts were test setup, not passed checks.

Not tested: physical printing, higher-version upgrade, local Win11 machine-wide MSI install (host lacks elevation), real employee documents or John acceptance. Keep Acrobat and originals; use PDF copies for trial. No production integrations or provider writes.

## Try and rollback

Open the MSI, follow Windows installation prompts, then Start menu -> Command PDF. Machine-wide installation may request an administrator. An unsigned publisher warning is expected; do not change company security policies if installation is blocked. Trial: open a copy, rotate/comment/fill, Save As, reopen in another PDF reader, and print a non-sensitive page. Uninstall through Windows Installed apps to roll back. Default PDF association is not forced.

Repo receipt is documentation only; tested artifact remains source423, not a later documentation commit. Final corrected test rerun must be recorded separately before claiming all automated checks passed.
