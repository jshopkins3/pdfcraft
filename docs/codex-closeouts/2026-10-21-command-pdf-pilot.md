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

## Final automated result and existing-text edit — October 21

Corrected workflow39668926709 completed SUCCESS at source e240aff2092758d5a9b571e166ba5f69c374e1ac. Actual completed logs:637 tests passed,0 failed,4 ignored. All five intended UI link tests passed plus three PDF-link tests. Formatting, asset provenance, architecture checks, MSI build/install/repair/reinstall/uninstall, independent PDF smoke and Clippy all succeeded. This is the configured pilot workflow, not the entire upstream test universe (72 unrelated UI-group tests filtered). Installed runtime423 differs from e240 only in a test selector; no application source difference.

Actual installed command-pdf-cli.exe text_edit replaced existing line3 Original amount:123.45 with Revised amount:987.65 (spaces preserved in actual files). Saved after.pdf, reopened via engine, rendered150DPI and visually inspected. Independent pypdf confirmed new text, absence of old phrase, both surrounding lines intact, original file unchanged and page count1. This tests the installed editing engine through its supported automation interface, not manual mouse/keyboard operation of the inline text editor. Evidence C:/Command/handoffs/command-pdf-edit-test/{before.pdf,after.pdf,after.png,edit.json,result.json}. No customer data.

Readiness recommendation: suitable for a small named MCM pilot, with Acrobat retained and copies used. Not established as a company-wide Acrobat replacement. Physical printing, complex/mixed-font layouts, scans requiring OCR before editing, higher-version updates and representative employee workflows remain outside completed coverage. Signing remains deferred by John. No Intra-Lounge publication or employee send occurred.

## Microsoft login configuration — saved, deployment blocked

John approved MCM-only registration and created its180-day client credential. Entra app9b59d185-696b-4cb9-be3c-334d8c5b75e7, object97be8401-0f26-4b4a-8d24-0d3a42090c52, tenant7e3e524d-a7fc-42db-afad-ba2755dd805f. SingletenantWebcallback https://sign.mychomeloans.com/api/auth/callback/oidc. ID-token email optionalclaim saved and exactrow read back; onlyemail identity scope added, no mail/document API grant.

Runtime read-only SSH confirmed Documenso2.17.0. Tagged source supports instanceOIDC without the separate licensed organizationSSO path. New Railway provider settings were absent before this operation. Saved issuer restricted toMCMtenant, exactclientID, providerlabelMCMMicrosoft, promptselect_account, allowedsignupdomainmychomeloans.com, disableemailpasswordsignuptrue. Existingemailpasswordsignin preserved as recovery. OIDC_SKIP_VERIFY=true is required because Entra does not emit the provider's genericemail_verified claim: identity instead comes from the tenant-specific tokenendpoint/codeexchange; this is not a bypass of TLS or Microsoft MFA. Actual returnedclaims/accountlinking/isolation remain untested until deployment. No payment/subscription/license selected.

Credential saved via stdin, exactstoredvalue compared withoutprinting; temporaryrestrictedlocalcopy removed. A UI snapshot inadvertently included itsvalue in tooloutput before securecapture; no value is stored in source/receipt. Recommend replacing thatcredential beforeteamrollout; newcredentialcreation stays withJohn.

Railway redeploy refused with exit1: Deploys have been paused temporarily. Official https://status.railway.com atOct21 21:01UTC reportsmajoroutage/buildspause. Latest active deployment remains c1001178-4c06-4032-9162-171400429fd3 (Aug26), image digest sha256:1377ba20181d4d029e768b7b7615e4e49c39450a85588a525e78dc586dd2569c. Fresh browser signout/test showed old email/passwordpage and no Microsoftoption: settings-saved is not live-verified. No runtimepatch or deploymentpausebypass attempted.

Recovery: fromlinkedoperatorcontext C:/Command/handoffs, inspectservice documenso inprojectCommand-Sign; whenRailwaypermits, redeploysameartifact/settings thenverifyversion, liveproviderlabel,tenantURL, exactcallback, Johnexistingpersonalteam/user, nonadminisolation andsignedPDF roundtrip. Do notclaimteamready. NonsecretJSONreceipt C:/Command/handoffs/command-sign-microsoft-runtime-receipt.json; claim screenshot command-sign-email-claim-saved.png. OriginalCommandappcredentials/permissions unchanged. ESignbutton287bec3 build39673969989 stillpending atthischeckpoint; prior637passingtestsbelongtoe240beforebutton.
