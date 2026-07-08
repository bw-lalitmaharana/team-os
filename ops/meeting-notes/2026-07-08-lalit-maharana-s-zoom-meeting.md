---
date: 2026-07-08
meeting: Lalit Maharana's Zoom Meeting
type: design
attendees: [Harshini Vijay, Lalit Maharana, Anuj Pancholi]
source: zoom
meeting_uuid: 30528AE0-B600-4415-8D59-F6C9827F296A
---

# Lalit Maharana's Zoom Meeting — 2026-07-08

## Summary
Harshini, Lalit, and Anuj worked through consent management and transcript-handling design for Zoom integration ahead of a hackathon demo. They locked a three-level consent model (org, user, series), with the series-level checkbox deferred to a follow-up phase so it doesn't block core ingestion delivery. They also designed the manual-upload-vs-Zoom-transcript coexistence flow, a per-instance "sensitive" flag that excludes a transcript from AI processing, and multi-file upload support — while leaving the two-transcript race condition and sensitive-flag regeneration timing as open items for follow-up with Anuj and the AI team respectively.

## Key decisions
- Global Zoom connection via the "Connect Apps" side panel covers all future meeting series by default; users can opt out per series.
- Series-level "Sync meeting transcripts" checkbox (default ON) designed but **deferred** — core ingestion + AI insights ship first, consent checkbox added afterward to avoid delaying delivery.
- Existing meeting series get a Connect banner + confirmation pop-up, not a full consent re-flow.
- Per-instance "sensitive" flag: transcript is stored but never sent to AI; if flagged after ingestion, recap/prep are regenerated without that transcript (pending AI-team feasibility check).
- Manual upload when Zoom is connected only unlocks after the user deletes the Zoom transcript; on re-sync, both Zoom and uploaded files show together.
- Multiple file uploads supported (e.g. split recordings from dropped/rejoined sessions).
- Upload/paste stays available both before and after meeting-end, since meetings often end early and gating upload until end-time risks users forgetting.
- Calendar-connect banner (for unconnected users creating a meeting) must open the side panel so users can select Google or Outlook, since the system can't infer calendar type.

## Action items
- Harshini: Update Figma designs — Connect Zoom banner + consent in manual upload flow, sensitive-flag messaging (excluded from AI), multiple file upload support, Zoom checkbox in new series creation, re-sync view showing both Zoom and uploaded files.
- Anuj + Lalit: Reconvene post-lunch (~2:30 PM) to finalize the Zoom + manual-upload coexistence flow and two-transcript precedence strategy.
- Anuj: Confirm with Hiteen — add series-level consent field to backend after core Zoom ingestion clears code review.
- Lalit/Anuj: Run the sensitive-flag regeneration approach by the AI team.

## Follow-ups / open questions
- Two-transcript race condition (Zoom + manual upload arriving simultaneously): no finalized resolution — options include latest-upload-wins, Zoom-takes-precedence, or a UI override button.
- User attribution failure handling: what to display when a Zoom transcript arrives but speaker attribution fails — to be checked with Anuj.
- When exactly the "meeting ended" UI state triggers (derived from instance end time + duration, updates on page refresh/revisit, not real-time) — edge cases to confirm with Tinge.
- Sensitive-flag timing: if a transcript was already sent to the LLM before being flagged, whether recap/prep regeneration without it is feasible needs AI-team confirmation.
- Should the Zoom integration toggle also appear inside the Create New 1:1 flow alongside the calendar toggle?
- How to educate users about the per-series exclusion option without adding excessive banners — proposed folding it into the global consent form copy.

## Discussion notes
- Consent default is "yes" for new meetings; users can opt out or revoke per meeting/series.
- Calendar connection stays outside the main interface; Zoom integration gets its own banner + pop-up.
- For sensitive series, Zoom transcripts stay available locally but are excluded from AI sends.
- Harshini questioned the value of allowing manual upload/delete when Zoom is connected, since the point of connecting Zoom is automatic transcripts; team kept the delete-then-upload path but agreed not to surface manual upload by default when Zoom is present (users can still add content via notes).
- Consent implementation requires three levels of backend verification (org, user, series); Anuj flagged the added backend effort, and the team agreed to ship core ingestion first and add consent as a separate follow-on implementation to avoid migration issues.
- New-series checkbox: checking enables transcription for future meetings only; past meetings are unaffected.

## Next steps
- Harshini to update Figma per the action items above; Anuj and Lalit to reconvene post-lunch to close the two-transcript coexistence design.
