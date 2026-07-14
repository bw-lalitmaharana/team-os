# Spin out `team-os` into a public starter repo — plan (FOR REVIEW)

**Status:** **DRAFT — awaiting your decisions** (§8). Proposes extracting the reusable framework from this private live workspace into a standalone, PII-free repo (working name **`pm-os-starter`**) that anyone can clone and fill with their own data. Builds on the tooling already in this repo: `scripts/new-team-os.sh` (clean generator), `scripts/scan-pii.sh` (leak scanner), and `QUICKSTART.md` (the self-build guide). Nothing ships publicly until `scan-pii.sh` is green in CI.

---

## 0. TL;DR — the one thing that matters

**This repo (`team-os`) stays private and unchanged.** We do **not** open it up, and we do **not** rewrite its history. Instead we *generate* a separate, clean repo from it — the same way `new-team-os.sh` already generates a clean skeleton locally — and publish **that**.

Three non-negotiables:
1. **Zero PII crosses the boundary.** The public repo is built by the generator (clean-by-construction) + a scrubbing pass on the opt-in skills, and every commit is gated by `scan-pii.sh` in CI. Not "we reviewed it" — a machine blocks the merge.
2. **The public repo is a *template*, not a fork of my workspace.** Content folders ship empty with placeholder `CLAUDE.md`s. Users bring their own data; none of mine is inherited.
3. **The framework we already validated is the payload.** We're not inventing new artifacts — we're packaging `new-team-os.sh`'s output, hardening it with CI, and writing the docs a stranger needs.

---

## 1. Why a separate repo (not "just share this one")

| Option | Verdict |
|---|---|
| Make `team-os` public | ❌ It's a live workspace — real names, emails, Jira/Aha keys, Slack IDs, meeting transcripts, decision records. Even with history rewrite, one missed string is a leak. |
| Publish a "sanitized branch" of `team-os` | ❌ Same git history/objects; a branch shares the object DB. Deleted-but-reachable blobs still leak. Too easy to `git log` your way to the PII. |
| **Generate a fresh, historyless repo** | ✅ New git init, no shared objects, clean-by-construction, CI-gated. The only safe boundary. |

The generator approach means the public repo has **its own history starting from commit 1** — there is no path back to my data because my data was never in its object database.

---

## 2. What ships in `pm-os-starter`

This is exactly `new-team-os.sh`'s output, plus the docs/CI that make it a real project. Three layers, same model as `QUICKSTART.md`:

### ✅ Clean framework — copied as-is
- `.claude/hooks/` (log-claudemd-change, warn-claudemd-size, warn-large-reads, index-signals)
- `.claude/settings.json` (hook wiring)
- `.claude/context-design.md` (the generic architecture — 3 time-scales, 5 principles, sizing rules)
- Generic commands: `/standup`, `/spec-review`, `/prd-review`, `/write-prd`
- `tldr-pdf` skill
- `.mcp.json` (server *slots*, no tokens — OAuth is per-user)
- `.gitignore`
- `scripts/scan-pii.sh` + `scripts/new-team-os.sh` (so users can re-scaffold sub-areas and self-audit)

### 🟡 Templated — placeholders, no real data
- Root `CLAUDE.md` with `<COMPANY>` / `<YOUR-NAME>` / `<ROLE>` / `<EPIC>` / `<NAMES>` tokens
- Empty content tree: `product/ analytics/ team/ ops/{daily,meeting-notes,action-notes,focus} knowledge/ decisions/ analytics/context-audit/`, each with a placeholder `CLAUDE.md`
- `README.md` (project-level, written for strangers — see §5)
- `QUICKSTART.md` (adapted: "you're already in the starter repo" framing)

### 🔵 Opt-in advanced skills — scrubbed, shipped as `*.template`
The high-value skills (`prd-agentic`, `sync-prd`, `sense-backlog`, `meeting-to-tasks`, `audit-context`) and the routine commands (`daily-meeting-extract`, `zoom-signal-sweep`) carry reusable logic **but have my specifics baked in**. Two choices to confirm in §8:
- **(A)** Ship them under `templates/skills/` scrubbed to placeholders (`<COMPANY>`, `<JIRA-KEY>`, `<NAME>`, `<TRIGGER-ID>`), with a one-time `enable-skill.sh <name>` that copies into `.claude/skills/` and reminds you to fill tokens. **(recommended — highest value; the skills are the reason anyone would want this)**
- **(B)** Omit them entirely; link back to this plan's scrub recipe and let users port by hand.

### ❌ Never ships
`ops/ decisions/ product/ team/ knowledge/ analytics/` **content**, daily briefs, PRDs, signals, roster, the Aegis plan, `ops/claudemd-changelog.md`. All my data. Recreated empty, never copied.

---

## 3. The extraction pipeline (how the clean repo is built)

```
team-os (private)                         pm-os-starter (public)
──────────────────                        ──────────────────────
new-team-os.sh  ──generates──►  /tmp/pm-os-starter-build
                                     │
scrub advanced skills ──────────────┤   (§8 decision A: strip to *.template)
                                     │
scan-pii.sh .  ─── must be CLEAN ────┤   ← hard gate, local
                                     ▼
                                git init && first commit
                                     │
                                push to new GitHub repo (Template repo = ON)
                                     ▼
                                GitHub Action: scan-pii.sh on every PR ← hard gate, CI
```

Key property: the build directory is **outside** `team-os`, gets its **own** `git init`, and only reaches GitHub after a local CLEAN scan. CI then re-runs the scan on every future PR so a careless contributor can't reintroduce a marker.

---

## 4. PII defense-in-depth (four layers)

1. **Clean-by-construction** — `new-team-os.sh` copies an allowlist, never a denylist. Anything not explicitly listed simply isn't there.
2. **Scrub pass** — the opt-in skills get placeholder substitution (documented recipe in `QUICKSTART.md` §5, automatable as `scripts/scrub-skill.sh`).
3. **Local gate** — `scan-pii.sh .` must print `CLEAN` before the first push. It greps names/emails/company/Jira-Aha/`trig_`/`env_`/Slack-DM/`-Users-` paths/epics/vendors/channels.
4. **CI gate** — `.github/workflows/pii-scan.yml` runs `scan-pii.sh` on every push + PR; red = blocked merge. Prevents regressions after launch.

> ⚠️ `scan-pii.sh` is a **heuristic**, not a proof. Before the *first* public push, do one human review of the full generated tree in addition to the scan. The scanner catches known markers; a human catches the unknown-unknowns (a screenshot, an unusual acronym, a pasted transcript fragment).

**Note — live-repo hygiene, separate from this plan:** this workspace still contains `-Users-lalitkumarmaharana` (in `README.md` and `audit-context/SKILL.md`) and `trig_`/`env_`/Slack-DM IDs in the routine command docs. These never reach the public repo (they're in the ❌ / 🔵-scrubbed layers), so they don't block launch — but if you want them cleaned here too, that's a quick separate pass I can do on request.

---

## 5. Docs to write (for strangers, not teammates)

| File | Purpose |
|---|---|
| `README.md` | What this is (a Claude Code PM operating system — Markdown, not an app), the 60-second pitch, screenshot/gif of a session, the three-layer safety model, link to QUICKSTART. |
| `QUICKSTART.md` | Adapted from ours: "you cloned the starter → fill placeholders → connect MCP → add your first area." Drop the "don't clone my workspace" warning (moot here). |
| `CONTRIBUTING.md` | The one rule that matters: **never commit real data; CI will reject PII markers.** How to add a generic skill/command. |
| `LICENSE` | See §8 — recommend MIT. |
| `docs/architecture.md` | Lightweight pointer to `.claude/context-design.md` (the real doc), so the landing page isn't a wall of theory. |

---

## 6. Phased rollout

- **Phase 0 — decide (§8).** Name, license, visibility, skills-shipping mode (A/B). Blocks everything.
- **Phase 1 — build locally.** Run `new-team-os.sh` into a build dir; add scrubbed `templates/skills/` (if A); write README/CONTRIBUTING/LICENSE; adapt QUICKSTART. `scan-pii.sh` → CLEAN + human review.
- **Phase 2 — CI.** Add `.github/workflows/pii-scan.yml`. Verify it fails on a deliberately-planted marker, then passes on the clean tree.
- **Phase 3 — publish.** `create_repository` (public, "Template repository" enabled), push Phase-1 tree as commit 1. Confirm the green CI badge.
- **Phase 4 — polish.** Session screenshot/gif in README, topics/tags for discoverability, a short "why" blog/README section. Optional: a `degit`/`gh repo create --template` one-liner in QUICKSTART.

Phases 1–3 are ~a session's work given the tooling already exists. Phase 0 is the only real blocker.

---

## 7. What this plan deliberately does NOT do

- Does not touch `team-os` history or visibility.
- Does not auto-sync the two repos. If the framework improves here, porting the improvement over is a manual, scan-gated step (kept rare on purpose — divergence is fine).
- Does not ship any MCP tokens, CCR trigger/env IDs, or the Aegis runtime.
- Does not promise the scanner is exhaustive — hence the mandatory human review before commit 1.

---

## 8. Open decisions — need your call

1. **Repo name.** `pm-os-starter` (clear) · `team-os-template` (mirrors this repo) · `claude-pm-os` (SEO-friendly for "Claude Code PM") · something of yours. → *recommend `pm-os-starter`.*
2. **Visibility.** Public from day 1, or private-until-polished then flip? → *recommend private during Phases 1–2, flip public at Phase 3.*
3. **License.** MIT (max reuse) · Apache-2.0 (patent grant) · CC0 (public domain, docs-heavy repos often use it). → *recommend MIT.*
4. **Advanced skills.** Ship scrubbed under `templates/skills/` with an enable script (A, recommended) or omit and document the port recipe (B)?
5. **Owner.** Under your personal GitHub, or a `bw-` org repo? (Affects whether it reads as a Betterworks-endorsed thing vs. a personal project.) → *personal, unless you want it org-branded.*
6. **Where this plan lives.** I've put it at `proposals/template-repo/PLAN.md`. If you'd rather it sit under `decisions/` as an ADR once approved, say so and I'll fan it out.

---

## 9. Immediate next step

On your `go` for §8, I'll execute Phases 1–3 in one pass: generate → scrub → scan → write docs → add CI → create the public template repo → push commit 1, and report back the repo URL with a green PII-scan badge. Until then this is a proposal only — no repo gets created.
