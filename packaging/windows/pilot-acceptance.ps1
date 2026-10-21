$ErrorActionPreference = 'Stop'
$root = (Resolve-Path "$PSScriptRoot/../..").Path
$out = Join-Path $root 'dist/release'
$installers = @(Get-ChildItem $out -Filter 'command-pdf-*-windows-x64.msi')
if ($installers.Count -ne 1) { throw 'Exactly one Command PDF MSI is required' }
$msi = $installers[0]
$receipt = [ordered]@{ source = (git rev-parse HEAD); platform = 'Windows x64 GitHub hosted runner'; signature = 'not tested'; steps = @(); physical_printing = 'not tested'; interactive_ui = 'not tested' }
function Installer-Step([string]$Name,[string[]]$Arguments) {
  $p = Start-Process msiexec.exe -ArgumentList $Arguments -Wait -PassThru -WindowStyle Hidden
  if ($p.ExitCode -notin 0,3010) { throw "$Name failed: msiexec exit $($p.ExitCode)" }
  $script:receipt.steps += "$Name passed (exit $($p.ExitCode))"
}
$folder = Join-Path $env:ProgramFiles 'Command PDF'
try {
  Installer-Step 'install' @('/i',"`"$($msi.FullName)`"",'/qn','/norestart','INSTALLDESKTOPSHORTCUT=0','INSTALLPDFCONTEXTMENU=0','INSTALLIMAGECONTEXTMENU=0','/l*v',"`"$out/install.log`"")
  $cli = Join-Path $folder 'command-pdf-cli.exe'
  if (-not (Test-Path $cli)) { throw "Installed CLI missing: $cli" }
  $sig=Get-AuthenticodeSignature (Join-Path $folder 'command-pdf.exe')
  $receipt.signature=$sig.Status.ToString()
  if ((Get-Item (Join-Path $folder 'command-pdf.exe')).VersionInfo.ProductName -ne 'Command PDF') { throw 'Executable has the wrong product name' }
  $receipt.steps += 'installed executable branding passed'
  $work=Join-Path $out 'synthetic'; New-Item -ItemType Directory -Force $work | Out-Null
  @'
Command PDF pilot synthetic fixture.
No borrower or employee data.
Original amount: 123.45
'@ | Set-Content -Encoding ascii (Join-Path $work 'fixture.txt')
  $steps=@(
    @{tool='doc_create';args=@{from='text';path='fixture.txt'}},
    @{tool='doc_save';args=@{doc=1;path='original.pdf'}},
    @{tool='form_add_field';args=@{doc=1;page=1;type='text';name='PilotReviewer';rect=@(50,130,250,155)}},
    @{tool='form_fill';args=@{doc=1;values=@{PilotReviewer='MCM synthetic reviewer'}}},
    @{tool='page_rotate';args=@{doc=1;pages=@(1);degrees=90}},
    @{tool='comment_add';args=@{doc=1;page=1;type='note';at=@(50,50);contents='Synthetic pilot review'}},
    @{tool='doc_save';args=@{doc=1;path='edited.pdf'}},
    @{tool='doc_open';args=@{path='edited.pdf'}},
    @{tool='doc_print';args=@{doc=2;path='print-ready.pdf';paper='Letter';layout='fit'}},
    @{tool='page_render';args=@{doc=2;page=1;dpi=96};out='edited.png'}
  )
  $steps | ConvertTo-Json -Depth 8 | Set-Content (Join-Path $work 'steps.json')
  # The CLI's own discoverable schema is retained as evidence, never assumed from README names.
  & $cli tools | Set-Content (Join-Path $out 'tool-schemas.json')
  if ($LASTEXITCODE -ne 0) { throw 'Installed CLI tools failed' }
  $receipt.steps += 'installed CLI schema discovery passed'
  & $cli run --root $work --script (Join-Path $work 'steps.json') --report | Set-Content (Join-Path $out 'engine-roundtrip.json')
  if ($LASTEXITCODE -ne 0) { throw 'Create, rotate, comment, save, reopen or render failed' }
  $receipt.steps += 'installed CLI create/rotate/comment/save/reopen/render passed'
  python -m pip install pypdf==6.1.1 --quiet
  if ($LASTEXITCODE -ne 0) { throw 'Independent PDF reader installation failed' }
  $env:COMMAND_PDF_FIXTURE=$work
  @'
import os
from pathlib import Path
from pypdf import PdfReader
p=Path(os.environ['COMMAND_PDF_FIXTURE'])
original=PdfReader(p/'original.pdf'); edited=PdfReader(p/'edited.pdf')
assert len(original.pages)==len(edited.pages)==1
assert original.pages[0].get('/Rotate',0)==0
assert edited.pages[0].get('/Rotate',0)==90
assert 'Original amount: 123.45' in edited.pages[0].extract_text()
assert edited.get_fields()['PilotReviewer']['/V']=='MCM synthetic reviewer'
assert any(a.get_object().get('/Contents')=='Synthetic pilot review' for a in edited.pages[0]['/Annots'])
assert (p/'edited.png').stat().st_size>1000
assert len(PdfReader(p/'print-ready.pdf').pages)==1
print('Independent pypdf: page count, original unchanged, rotation, text, filled form, comment and print-ready output passed')
'@ | python - | Set-Content (Join-Path $out 'independent-readback.txt')
  if ($LASTEXITCODE -ne 0) { throw 'Independent PDF readback failed' }
  $receipt.steps += 'independent pypdf readback passed'
  Installer-Step 'repair' @('/fa',"`"$($msi.FullName)`"",'/qn','/norestart','/l*v',"`"$out/repair.log`"")
  Installer-Step 'same-version upgrade' @('/i',"`"$($msi.FullName)`"",'/qn','/norestart','/l*v',"`"$out/upgrade.log`"")
} finally {
  if (Test-Path $folder) {
    Installer-Step 'uninstall' @('/x',"`"$($msi.FullName)`"",'/qn','/norestart','/l*v',"`"$out/uninstall.log`"")
    if (Test-Path (Join-Path $folder 'command-pdf.exe')) { throw 'Executable remains after uninstall' }
  }
  $receipt | ConvertTo-Json -Depth 8 | Set-Content (Join-Path $out 'pilot-acceptance.json')
}
