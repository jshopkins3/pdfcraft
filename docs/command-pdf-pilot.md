# Command PDF Windows pilot

Owner: John Hopkins III. Builder: Codex. First of installed Command tools; later versions replace this.

Source: PdfCraft v0.10.1, b77d57000c22c760f731206f6cf14486d149de72. Build only Windows x64. Original engine, permissions, save guards, opt-in control/MCP retained. No Command/Arive/SharePoint document integration or Intra-Lounge publication.

Map: approved Command branding -> pinned source -> x64 build -> MSI metadata/engine tests -> Windows installation -> synthetic open/edit/save/reopen/print -> uninstall -> John pilot review -> separately publish download.

Reference: preserve the existing PdfCraft desktop layout and tools, use approved Command mark and Command PDF title, My Community Mortgage installer publisher, separate product GUIDs and storage, and Command help. This is a pilot candidate pending actual render review.

Updates are manual and user-requested, restricted to the fork's releases. Never send users to upstream installers. No release published by CI. An unsigned candidate is test-only; signing and actual Windows acceptance are separate receipts. Keep Acrobat and original documents.

Acceptance: install/repair/upgrade/uninstall; no forced default association; no shared upstream profile; view/search; rotate/combine; form fill; comments; save/reopen in independent reader; print; 100/150/200 percent scaling. Physical printing is a separate hardware check.

The GitHub candidate workflow uploads test artifacts only. It does not create a release or an Intra-Lounge link. A successful job is CI evidence; it does not establish physical printer output, Windows desktop appearance, or signing trust on employee PCs. The manual update destination is the fork's releases page; no approved release exists there during preparation.

Pilot rollback: uninstall Command PDF using Windows Installed apps, keep Acrobat and all original files, and reinstall only the last approved Command PDF MSI if needed. The installer offers Open with and never forces itself as the default reader. Existing PdfCraft profiles and recovery files remain separate.

Command help opens the authenticated Intra-Lounge home page, where company contacts are available. The desktop pilot does not create a new support intake or promise an IT-specific form. The destination was inspected in the signed-in browser; an unsupported `help=it` query was removed.

Command Sign handoff (John authorized October21): E-Sign -> Open Command Sign -> company sign-in -> manually upload saved PDF -> choose recipients and fields -> signing -> download completed PDF. Existing local Fill & Sign stays available. The button opens https://sign.mychomeloans.com only; no file path, document bytes, recipient or credentials are sent by the desktop button. Save/Save As before upload; changes made after uploading do not update that envelope. Cancel in Command Sign if the wrong version was uploaded. Sending and completion are provider actions, not desktop success claims. Team access, actual synthetic completion and signed-file readback require separate evidence before rollout.
