#!/usr/bin/env python3
"""Local UI for product/meeting-transcripts/open-actions.md. Stdlib only.

Run:  python3 automation/actions-ui/server.py   ->  http://127.0.0.1:8765
The markdown file stays the source of truth: the UI rewrites only the table rows you edit.
"""
import json, os, sys, tempfile
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
MD = os.environ.get("ACTIONS_MD", os.path.join(ROOT, "product/meeting-transcripts/open-actions.md"))
HTML = os.path.join(os.path.dirname(__file__), "index.html")
PORT = int(os.environ.get("PORT", 8765))


def split_row(line):
    return [c.strip() for c in line.strip().strip("|").split("|")]


def is_sep(line):
    s = line.strip().replace("|", "").replace(":", "").replace("-", "").strip()
    return line.strip().startswith("|") and s == ""


def read_lines():
    with open(MD, encoding="utf-8") as f:
        return f.read().split("\n")


def parse(lines):
    """Return tables: [{section, header, header_line, rows:[{line, cells}]}]"""
    tables, section, i = [], "", 0
    while i < len(lines):
        ln = lines[i]
        if ln.startswith("#"):
            section = ln.lstrip("#").strip()
        if ln.strip().startswith("|") and i + 1 < len(lines) and is_sep(lines[i + 1]):
            t = {"section": section, "header": split_row(ln), "header_line": i, "header_raw": ln, "rows": []}
            j = i + 2
            while j < len(lines) and lines[j].strip().startswith("|"):
                t["rows"].append({"line": j, "cells": split_row(lines[j]), "raw": lines[j]})
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
