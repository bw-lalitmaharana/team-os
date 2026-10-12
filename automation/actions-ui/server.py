#!/usr/bin/env python3
"""Local UI for product/meeting-transcripts/open-actions.md. Stdlib only.

Run:  python3 automation/actions-ui/server.py   ->  http://127.0.0.1:8765
The markdown file stays the source of truth: the UI rewrites only the table rows you edit.
"""
import datetime, json, os, re, sys, tempfile
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
MD = os.environ.get("ACTIONS_MD", os.path.join(ROOT, "product/meeting-transcripts/open-actions.md"))
HTML = os.path.join(os.path.dirname(__file__), "index.html")
PORT = int(os.environ.get("PORT", 8765))
HERE = os.path.dirname(__file__)


def load_json(name):
    try:
        with open(os.path.join(HERE, name), encoding="utf-8") as f:
            return json.load(f)
    except (OSError, ValueError):
        return []


# Derived, read-only fields. The markdown stays the source of truth; edit people.json / tracks.json to tune them.
PEOPLE, TRACKS = load_json("people.json"), load_json("tracks.json")
ALIAS = {a: p["name"] for p in PEOPLE for a in p.get("aliases", [p["name"]])}
PEOPLE_RE = re.compile(r"(?<![\w])(" + "|".join(re.escape(a) for a in sorted(ALIAS, key=len, reverse=True)) + r")(?![\w])") if ALIAS else None
ISO_RE = re.compile(r"(?<![\d-])(20\d\d)-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])(?![\d-])")
MD_RE = re.compile(r"(?<![\d/.-])(1[0-2]|[1-9])/(3[01]|[12]\d|0?[1-9])(?![\d/])")
PREFIX_RE = re.compile(r"^((?:🔥|🟦)\s*)?\*\*([^*]+?):\*\*\s*")


def col(header, *pats):
    for p in pats:
        for i, h in enumerate(header):
            if re.search(p, h, re.I):
                return i
    return None


def split_row(line):
    return [c.strip() for c in line.strip().strip("|").split("|")]


def is_sep(line):
    s = line.strip().replace("|", "").replace(":", "").replace("-", "").strip()
    return line.strip().startswith("|") and s == ""


def read_lines():
    with open(MD, encoding="utf-8") as f:
        return f.read().split("\n")


def derive(header, cells, today=None):
    """raised date, stakeholders, track and display title for one row."""
    today = today or datetime.date.today()
    main = col(header, r"action", r"owe", r"dependency") or 0
    text = cells[main] if main < len(cells) else ""
    m = PREFIX_RE.match(text)
    prefix = m.group(2).strip() if m else ""
    title = (m.group(1) or "") + text[m.end():] if m else text
    # raised = earliest date in the From cell (cross-pod table: dates in the status, e.g. "Pending (7/20)")
    fi = col(header, r"\bfrom\b")
    src = cells[fi] if fi is not None and fi < len(cells) else ISO_RE.sub("", cells[-1] if cells else "")
    found = []
    for y, mo, d in ISO_RE.findall(src) if fi is not None else []:
        found.append(datetime.date(int(y), int(mo), int(d)))
    for mo, d in MD_RE.findall(src):
        try:
            c = datetime.date(today.year, int(mo), int(d))
        except ValueError:
            continue
        found.append(c if c <= today + datetime.timedelta(days=14) else c.replace(year=c.year - 1))
    # stakeholders: counterparties named in the action / dependency first, then who raised it
    order = [i for i in (col(header, r"action|dependency"), col(header, r"owe")) if i is not None]
    order += [i for i in (col(header, r"\bfrom\b"),) if i is not None]
    who = []
    for i in dict.fromkeys(order):
        for a in PEOPLE_RE.findall(cells[i]) if PEOPLE_RE and i < len(cells) else []:
            if ALIAS[a] not in who:
                who.append(ALIAS[a])
    # track: an exact track-name prefix wins, then rules on the prefix, then rules on the whole row
    track = next((t["name"] for t in TRACKS if t["name"].lower() == prefix.lower()), None)
    for blob in ([prefix] if prefix else []) + [" ".join(cells[:main + 1])]:
        for t in TRACKS:
            if track is None and re.search(t["match"], blob, re.I):
                track = t["name"]
    return {"raised": min(found).isoformat() if found else None, "people": who,
            "track": track or "Other", "title": title, "prefix": prefix}


def parse(lines):
    """Return tables: [{section, header, header_line, rows:[{line, cells}]}]"""
    tables, section, i = [], "", 0
    while i < len(lines):
        ln = lines[i]
        if ln.startswith("#"):
            section = ln.lstrip("#").strip()
        if ln.strip().startswith("|") and i + 1 < len(lines) and is_sep(lines[i + 1]):
            hdr = split_row(ln)
            t = {"section": section, "header": hdr, "header_line": i, "header_raw": ln, "rows": [],
                 "kind": "wait" if col(hdr, r"owe") is not None else "mine",
                 "main": col(hdr, r"action", r"owe", r"dependency") or 0}
            j = i + 2
            while j < len(lines) and lines[j].strip().startswith("|"):
                cells = split_row(lines[j])
                t["rows"].append({"line": j, "cells": cells, "raw": lines[j], **derive(hdr, cells)})
                j += 1
            tables.append(t)
            i = j
            continue
        i += 1
    return tables


def fmt(cells):
    return "| " + " | ".join(c.replace("|", "/").replace("\n", " ") for c in cells) + " |"


def save(lines):
    d = os.path.dirname(MD)
    fd, tmp = tempfile.mkstemp(dir=d, suffix=".tmp")
    with os.fdopen(fd, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))
    os.replace(tmp, MD)


class H(BaseHTTPRequestHandler):
    def _send(self, code, body, ctype="application/json"):
        data = body if isinstance(body, bytes) else body.encode()
        self.send_response(code)
        self.send_header("Content-Type", ctype + "; charset=utf-8")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def _json(self):
        return json.loads(self.rfile.read(int(self.headers.get("Content-Length", 0))) or b"{}")

    def log_message(self, *a):
        pass

    def do_GET(self):
        if self.path == "/api/tables":
            return self._send(200, json.dumps(parse(read_lines())))
        if self.path == "/api/meta":
            return self._send(200, json.dumps({"tracks": TRACKS, "people": {p["name"]: p.get("role", "") for p in PEOPLE}}))
        if self.path in ("/", "/index.html"):
            with open(HTML, "rb") as f:
                return self._send(200, f.read(), "text/html")
        self._send(404, "{}")

    def do_PUT(self):  # edit a row; refuses if the file changed underneath
        b = self._json()
        lines = read_lines()
        n = b["line"]
        if n >= len(lines) or lines[n] != b["raw"]:
            return self._send(409, json.dumps({"error": "File changed on disk; reload."}))
        lines[n] = fmt(b["cells"])
        save(lines)
        self._send(200, json.dumps({"ok": True}))

    def do_POST(self):  # append a row to a table
        b = self._json()
        lines = read_lines()
        tables = parse(lines)
        t = next((t for t in tables if t["header_line"] == b["header_line"]), None)
        if not t or lines[t["header_line"]].strip() != b["header_raw"].strip():
            return self._send(409, json.dumps({"error": "File changed on disk; reload."}))
        at = (t["rows"][-1]["line"] if t["rows"] else t["header_line"] + 1) + 1
        lines.insert(at, fmt(b["cells"]))
        save(lines)
        self._send(200, json.dumps({"ok": True}))


if __name__ == "__main__":
    if not os.path.exists(MD):
        sys.exit(f"Not found: {MD}")
    print(f"Editing {MD}\nhttp://127.0.0.1:{PORT}  (Ctrl+C to stop)")
    ThreadingHTTPServer(("127.0.0.1", PORT), H).serve_forever()
