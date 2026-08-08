#!/usr/bin/env python3
"""Regression test: _data/events.yml must list all current training events.

Dependency-free (mirrors the simple grep-based parsing in
scripts/fetch_cards.sh) since events.yml is a flat list of records.
"""
import re
import sys
from pathlib import Path

EVENTS_FILE = Path(__file__).resolve().parent.parent / "_data" / "events.yml"

REQUIRED_URLS = {
    "https://cppunderthesea.nl/#workshops",
    "https://accuonsea.uk/2026/sessions/cpp-best-practices/",
    "https://cppcon.org/class-2026-best-practices/",
    "https://ndctechtown.com/workshops/cpp-best-practices/6c9af33497b9",
}

REQUIRED_FIELDS = ("title", "date_start", "location", "url")


def parse_events(text):
    records = re.split(r"\n(?=- title:)", text)
    events = []
    for record in records:
        if not record.strip().startswith("- title:"):
            continue
        fields = {}
        for match in re.finditer(r'^\s*-?\s*(\w+):\s*"?([^"\n]*?)"?\s*$', record, re.MULTILINE):
            fields[match.group(1)] = match.group(2)
        events.append(fields)
    return events


def main():
    events = parse_events(EVENTS_FILE.read_text())

    urls = {event.get("url") for event in events}
    missing = REQUIRED_URLS - urls
    assert not missing, f"Missing required events for URLs: {sorted(missing)}"

    for event in events:
        for field in REQUIRED_FIELDS:
            assert event.get(field), f"Event {event.get('title')!r} missing required field {field!r}"

    print(f"OK: {len(events)} events found, all {len(REQUIRED_URLS)} required URLs present.")


if __name__ == "__main__":
    main()
