# Command PDF publisher signing

John authorized setup on 2026-10-21. This document records preparation, not an active signing service or a signed build.

## Observed state

The Azure portal is authenticated as John in the MCM `mychomeloans.com` directory. Its subscription list shows zero available subscriptions for that account. Enrollment redirects to the company's GoDaddy sign-in. No subscription, paid resource, identity request or permission grant has been created in this scope. Billing approval and the human sign-in remain pending.

The proposed service is Microsoft Artifact Signing Basic, currently USD 9.99 per month for 5,000 signatures, plus applicable taxes and USD 0.005 per additional signature. Confirm the account's actual price before creating it. Sources: [Microsoft pricing tiers](https://learn.microsoft.com/en-us/azure/artifact-signing/how-to-change-sku), [setup and identity requirements](https://learn.microsoft.com/en-us/azure/artifact-signing/quickstart).

## Proposed setup

1. Establish an MCM-owned Azure subscription or obtain access to an existing one. Keep the company directory and billing ownership explicit.
2. Create `rg-command-pdf-signing` in East US and an available signing account name such as `mcm-command-pdf`, Basic tier. These are proposed names, not created resources.
3. Submit Public organization identity validation using MCM's exact legal entity, business address, website, business identifier and authorized contacts. John completes required identity checks personally. Microsoft documents a processing range of 1–20 business days, potentially longer; do not promise same-day signing.
4. After validation, create a Public Trust profile such as `mcm-command-pdf-public`. Restrict signing access to that profile. Prefer a protected GitHub environment and short-lived federated authentication for automation; do not give general repository workflows a reusable client secret or broad subscription role.
5. Sign both executables before packaging, then sign the MSI with a SHA-256 signature and timestamp. Require successful signature verification, repeat installer acceptance, and record file hashes and certificate subject before any employee download.

## Prepared packaging support

`packaging/windows/sign.ps1` supports existing PFX configuration or Microsoft Artifact Signing. Set `AZURE_SIGNING_USE_CLI=1` for an already-authenticated Azure CLI session, together with `AZURE_SIGNING_ENDPOINT`, `AZURE_SIGNING_ACCOUNT` and `AZURE_CERT_PROFILE`. This method excludes other credential sources. No Azure CLI login or signing permission has been established by this preparation.

The client is pinned to Microsoft.ArtifactSigning.Client 1.0.146 and SHA-256 `7761e5d8f31e54b764da21d33cd8b0a2940e1b05526c7dfcb5e94b0431426f70`. Its x64 library was downloaded from Microsoft's NuGet package and its Authenticode signature read back as Valid, Microsoft Corporation, on the pilot PC. This validates the client download, not MCM's publisher identity or a signed installer.

`COMMAND_PDF_REQUIRE_SIGNING=1` refuses an unconfigured signing identity. Packaging signs executable payloads before WiX creates the installer and signs the MSI afterward. The acceptance script checks the installed executable's signature when signing is required. Normal test builds remain explicitly unsigned. Signing is not enabled automatically for branch pushes.

Signing identifies the publisher and protects integrity. A new signed app can still receive a SmartScreen reputation warning. [Microsoft guidance](https://learn.microsoft.com/en-us/windows/apps/package-and-deploy/smartscreen-reputation).
