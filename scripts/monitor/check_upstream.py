#!/usr/bin/env python3
"""Check official Brave documentation and the latest stable release."""

from __future__ import annotations

import argparse
import hashlib
import html
from html.parser import HTMLParser
import json
import os
from pathlib import Path
import re
import sys
import urllib.request


SOURCES = {
    "origin_article": {
        "api": "https://support.brave.app/api/v2/help_center/en-us/articles/38561489788173.json",
        "url": "https://support.brave.app/hc/en-us/articles/38561489788173-What-is-Brave-Origin",
    },
    "group_policy_article": {
        "api": "https://support.brave.app/api/v2/help_center/en-us/articles/360039248271.json",
        "url": "https://support.brave.app/hc/en-us/articles/360039248271-Group-Policy",
    },
}
RELEASE_API = "https://api.github.com/repos/brave/brave-browser/releases/latest"


class TextExtractor(HTMLParser):
    def __init__(self) -> None:
        super().__init__()
        self.parts: list[str] = []

    def handle_data(self, data: str) -> None:
        self.parts.append(data)


def fetch_json(url: str) -> dict:
    headers = {
        "Accept": "application/json",
        "User-Agent": "minimal-brave-configuration-monitor/1.0",
    }
    if url.startswith("https://api.github.com/") and os.environ.get("GITHUB_TOKEN"):
        headers["Authorization"] = f"Bearer {os.environ['GITHUB_TOKEN']}"
    request = urllib.request.Request(
        url,
        headers=headers,
    )
    with urllib.request.urlopen(request, timeout=30) as response:
        return json.load(response)


def normalize_html(value: str) -> str:
    parser = TextExtractor()
    parser.feed(value)
    text = html.unescape(" ".join(parser.parts))
    return re.sub(r"\s+", " ", text).strip()


def current_state() -> dict:
    result: dict[str, dict[str, str]] = {}
    for name, source in SOURCES.items():
        article = fetch_json(source["api"])["article"]
        normalized = normalize_html(article["body"])
        result[name] = {
            "title": article["title"],
            "url": source["url"],
            "updated_at": article["updated_at"],
            "content_sha256": hashlib.sha256(normalized.encode("utf-8")).hexdigest(),
        }

    release = fetch_json(RELEASE_API)
    result["stable_release"] = {
        "tag": release["tag_name"],
        "url": release["html_url"],
        "published_at": release["published_at"],
    }
    return result


def changes_between(baseline: dict, current: dict) -> list[str]:
    changes: list[str] = []
    for name, latest in current.items():
        previous = baseline.get(name)
        if previous is None:
            changes.append(f"- **{name}** is new: `{json.dumps(latest, sort_keys=True)}`")
            continue
        changed_fields = [key for key in latest if latest.get(key) != previous.get(key)]
        if changed_fields:
            details = ", ".join(
                f"`{key}`: `{previous.get(key, 'missing')}` → `{latest.get(key)}`"
                for key in changed_fields
            )
            changes.append(f"- **{name}** changed — {details}")
    for name in baseline.keys() - current.keys():
        changes.append(f"- **{name}** disappeared from the current check")
    return changes


def report(changes: list[str]) -> str:
    return "\n".join(
        [
            "## Upstream Brave changes detected",
            "",
            *changes,
            "",
            "### Maintenance checklist",
            "",
            "- [ ] Review the official Origin affected-feature list",
            "- [ ] Review newly added, removed, or renamed Brave policies",
            "- [ ] Test macOS installation and removal",
            "- [ ] Test Windows installation and removal",
            "- [ ] Recheck New Tab, Appearance, Shields, social controls, and filter-list names",
            "- [ ] Update the tested Brave version in the documentation",
            "- [ ] Refresh `.github/upstream-baseline.json` after the review",
            "",
            "To refresh the baseline after validating the changes:",
            "",
            "```bash",
            "python3 scripts/monitor/check_upstream.py --write-baseline .github/upstream-baseline.json",
            "```",
            "",
            "Commit the reviewed documentation and baseline together, then close this issue.",
        ]
    )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--baseline", type=Path)
    parser.add_argument("--write-baseline", type=Path)
    parser.add_argument("--report-file", type=Path)
    parser.add_argument("--github-output", type=Path)
    args = parser.parse_args()

    current = current_state()
    if args.write_baseline:
        args.write_baseline.write_text(json.dumps(current, indent=2) + "\n", encoding="utf-8")
        print(f"Wrote {args.write_baseline}")
        return 0

    if not args.baseline:
        print(json.dumps(current, indent=2))
        return 0

    baseline = json.loads(args.baseline.read_text(encoding="utf-8"))
    changes = changes_between(baseline, current)
    body = report(changes) if changes else "No upstream changes detected."
    print(body)

    if args.report_file:
        args.report_file.write_text(body + "\n", encoding="utf-8")
    if args.github_output:
        with args.github_output.open("a", encoding="utf-8") as output:
            output.write(f"changed={'true' if changes else 'false'}\n")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as error:
        print(f"Monitor failed: {error}", file=sys.stderr)
        raise
