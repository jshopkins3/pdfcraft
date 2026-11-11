#!/usr/bin/env python3
"""Package the existing web build for the company catalog; no tenant mutation."""
import argparse
import json
from pathlib import Path
from urllib.parse import urlsplit
from zipfile import ZIP_DEFLATED, ZipFile

APP_ID = "c24217b7-c8b1-4ed5-bcb3-04e2e3e2cd4b"
ROOT = Path(__file__).resolve().parents[2]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--url", required=True, help="Verified HTTPS address of the deployed Command PDF site")
    parser.add_argument("--version", default="0.1.0")
    parser.add_argument("--out", type=Path, default=ROOT / "dist/release/command-pdf-m365-pilot.zip")
    args = parser.parse_args()
    url = urlsplit(args.url)
    if url.scheme != "https" or not url.hostname or url.username or url.password or url.query or url.fragment:
        parser.error("Use the site's HTTPS base URL without credentials, query or fragment")
    base = args.url.rstrip("/")
    manifest = {
        "$schema": "https://developer.microsoft.com/en-us/json-schemas/teams/v1.20/MicrosoftTeams.schema.json",
        "manifestVersion": "1.20",
        "version": args.version,
        "id": APP_ID,
        "developer": {
            "name": "My Community Mortgage",
            "websiteUrl": base,
            "privacyUrl": base + "/privacy.html",
            "termsOfUseUrl": base + "/terms.html",
        },
        "name": {"short": "Command PDF", "full": "Command PDF company pilot"},
        "description": {
            "short": "Edit, combine, annotate and fill PDFs on your device.",
            "full": "Command PDF is MCM's PDF workspace. Open a local PDF, edit text, fill standard forms, add comments, combine pages, then download your result. Pilot: use synthetic test documents until saving and printing have been accepted in your Microsoft client. Browser OCR and cloud save-back are not included.",
        },
        "icons": {"color": "color.png", "outline": "outline.png"},
        "accentColor": "#252428",
        "staticTabs": [{
            "entityId": "command-pdf",
            "name": "Command PDF",
            "contentUrl": base + "/?host=m365",
            "websiteUrl": base + "/",
            "scopes": ["personal"],
        }],
        "permissions": [],
        "validDomains": [url.hostname],
    }
    args.out.parent.mkdir(parents=True, exist_ok=True)
    with ZipFile(args.out, "w", ZIP_DEFLATED) as package:
        package.writestr("manifest.json", json.dumps(manifest, indent=2) + "\n")
        for name in ("color.png", "outline.png"):
            package.write(ROOT / "packaging/m365" / name, name)
    print(args.out)


if __name__ == "__main__":
    main()
