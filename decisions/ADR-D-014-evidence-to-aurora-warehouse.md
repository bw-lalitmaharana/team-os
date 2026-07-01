---
id: ADR-D-014
status: accepted
date: 2026-05-13 (PM)
deciders: AI Platform Lead (JZ) + Exec Sponsor (NL)
related_prd: PRD-AI-PROCESSING-PIPELINE
open_decision: OPEN-D7 (annotate §A.1 architecture diagram with "Aurora" label)
---

# ADR-D-014 — Evidence rows write to data warehouse (Aurora), not siloed pod DBs

## Context
Storage choice for the canonical `evidence` table: (a) siloed pod DBs — each pod (Goals, Feedback, Skills, Meetings) keeps evidence in its own datastore, with cross-pod consumers querying via service APIs — high coupling, slow analytics, hard to do cross-module reporting; (b) shared data warehouse (Aurora) — single canonical home; cross-pod consumers + analytics reporting layer both query the same store; matches the centralized-evidence architecture (ADR-D-003).

## Decision
Evidence rows SHALL write to the **shared data warehouse (Aurora)**, NOT siloed pod DBs. Cross-pod consumers (Goals/Feedback/Skills/Meetings) + analytics reporting layer query the same store. Polymorphic FK in Postgres (ADR-D-008) maps to Aurora as a native Postgres-compatible relational store.

## Consequences
- Single source of truth for AI evidence across the org.
- Cross-pod read access without service-API hop.
- Analytics/reporting can join evidence with existing fact tables.
- Pod ownership boundary preserved at the read-permission level (RLS), not at the storage-tier level.
- Open partial: ADR-D-014 is logged but the §A.1 architecture diagram does not yet explicitly label "Aurora" — tracked as OPEN-D7.

## Source
- Product Acceptance call 2026-05-13 PM
- PRD-AI-PROCESSING-PIPELINE §5 MUST + §A.1
