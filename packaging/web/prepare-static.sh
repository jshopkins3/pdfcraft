#!/usr/bin/env bash
# DigitalOcean's HTML builder installs an already-tested, checksum-pinned release.
# No Rust compilation or document processing takes place on the static host.
set -euo pipefail
: "${COMMAND_PDF_PACKAGE_URL:?Set the exact GitHub release ZIP URL}"
: "${COMMAND_PDF_PACKAGE_SHA256:?Set the verified release ZIP SHA-256}"
: "${COMMAND_PDF_SOURCE_SHA:?Set the reviewed 40-character source commit}"
[[ "$COMMAND_PDF_PACKAGE_URL" =~ ^https://github\.com/jshopkins3/pdfcraft/releases/download/[A-Za-z0-9._-]+/pdfcraft-web-[A-Za-z0-9._-]+\.zip$ ]]
[[ "$COMMAND_PDF_PACKAGE_SHA256" =~ ^[a-f0-9]{64}$ ]]
[[ "$COMMAND_PDF_SOURCE_SHA" =~ ^[a-f0-9]{40}$ ]]
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
curl --fail --location --retry 2 --max-time 180 "$COMMAND_PDF_PACKAGE_URL" -o "$tmp/site.zip"
echo "$COMMAND_PDF_PACKAGE_SHA256  $tmp/site.zip" | sha256sum -c -
python3 - "$tmp/site.zip" site "$COMMAND_PDF_SOURCE_SHA" <<'PY'
import json, sys
from pathlib import Path, PurePosixPath
from zipfile import ZipFile

archive, destination, source = sys.argv[1:]
destination = Path(destination).resolve()
with ZipFile(archive) as package:
    files = package.infolist()
    if len(files) > 2000 or sum(f.file_size for f in files) > 256 * 1024 * 1024:
        raise SystemExit("Static package exceeds the expected bounds")
    roots = set()
    for entry in files:
        path = PurePosixPath(entry.filename)
        if path.is_absolute() or ".." in path.parts or "\\" in entry.filename or not path.parts:
            raise SystemExit("Unsafe static package path")
        if (entry.external_attr >> 16) & 0o170000 == 0o120000:
            raise SystemExit("Static package must not contain symbolic links")
        roots.add(path.parts[0])
    if len(roots) != 1 or not next(iter(roots)).startswith("pdfcraft-web-"):
        raise SystemExit("Unexpected static package root")
    for entry in files:
        path = PurePosixPath(entry.filename)
        if entry.is_dir() or len(path.parts) < 2:
            continue
        target = destination.joinpath(*path.parts[1:])
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(package.read(entry))
if not (destination / "index.html").is_file() or not list(destination.glob("*.wasm")):
    raise SystemExit("Static package is missing the editor")
(destination / "build.json").write_text(json.dumps({"source": source}) + "\n")
print("Prepared verified Command PDF static package")
PY
