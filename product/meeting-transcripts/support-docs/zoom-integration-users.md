# Integrations: Zoom (Users)

<!--
INTERNAL — DELETE THIS BLOCK BEFORE PUBLISHING TO ZENDESK.
Structure mirrors "Integrations: Microsoft Outlook (Users)"
(support.betterworks.com/hc/en-us/articles/6058655111565).

Verified against code 2026-09-09. Evidence:
  - haven .../components/meetings/ZoomTermsDialog.vue — the consent dialog is the WHOLE user
    flow: submitZoomConsent(ACCEPTED) → PATCH /services/meetings/meetings/conferencing-consent,
    then syncWithCalendar(). No OAuth redirect, no Zoom sign-in, no Marketplace install.
  - haven .../composables/meetings/useZoomIntegration.ts — isZoomConnected is consent_status ===
    'accepted'; isZoomIntegrationEnabled is org_conferencing_provider_enabled (the admin's gate).
  - meetings-api src/repo/models/zoom-webhook-inbound.js — a 1:1 is processed when AT LEAST ONE
    participant has consented; host_id is never read.
The previous draft's "Install the Betterworks app in Zoom" section and its host-only ACCESS wording
were removed as factually wrong.
A host dependency on GENERATION was then added (2026-09-09) and is a different thing: Zoom KB0058013
— "Only the meeting host and co-host can start or stop the Meeting summary through the in-meeting
controls" — so the host's Zoom settings decide whether a transcript exists at all. Keep the two
apart when editing: host decides IF there's a transcript; host is irrelevant to WHO can get a recap
from it. Open items: see zoom-requirements-notes.md in this folder.
-->

## Contents

- [Overview](#overview)
- [Pre-requisites](#pre-requisites)
- [Configuration](#configuration)
  - [Turn on Zoom transcripts in Betterworks](#turn-on-zoom-transcripts-in-betterworks)
- [Usage](#usage)
  - [Before your 1:1](#before-your-11)
  - [After your 1:1](#after-your-11)
  - [Action items](#action-items)
  - [Goal recommendations](#goal-recommendations)
  - [Add a transcript manually](#add-a-transcript-manually)
- [Real-time usage](#real-time-usage)
- [Disconnect Zoom](#disconnect-zoom)
- [Troubleshooting](#troubleshooting)
- [FAQs](#faqs)

## Overview

Betterworks has a Zoom integration so that your 1:1 meetings turn into useful follow-up without note-taking. Once you turn it on, Betterworks picks up the transcript Zoom already produces for your 1:1s and uses it to give you a private preparation brief before the meeting, and an AI recap with suggested action items and goal recommendations afterwards.

Turning it on takes one step, in Betterworks. You don't install anything, and you are never asked to sign in to Zoom — your administrator has already authorized Zoom for your whole organization. All that's left is your own consent.

Nothing joins your meeting. There is no bot and no extra participant. Betterworks only reads the transcript Zoom has already created, only for your 1:1s, and only after you have given consent.

You stay in control of everything Betterworks suggests. No recap, action item, or goal recommendation becomes part of your Betterworks record until you confirm it.

## Pre-requisites

- Your Betterworks administrator must have enabled **and** authenticated the Zoom integration for your organization. Until they have, you won't see the option to turn on Zoom transcripts.
- Your calendar must be connected to Betterworks, and your 1:1 must be scheduled as a calendar meeting with a Zoom join link. Betterworks matches a Zoom transcript to a 1:1 using the Zoom link on the invitation.
- **Zoom AI Companion must be turned on for whoever hosts the 1:1**, with **Meeting summary with AI Companion** enabled. AI Companion is what creates the transcript — without it there is nothing for Betterworks to read.
- Your Zoom administrator must allow transcripts generated with meeting summary to be retained.
- The person who hosts the 1:1 must be in your organization's Zoom account.

**Important:** Only a meeting's host or co-host can start meeting summary in Zoom. If your manager schedules and hosts your 1:1, it is **their** Zoom settings that decide whether a transcript is created — turning AI Companion on for yourself will not change it. If your 1:1s aren't producing recaps, this is the first thing to check with your manager or your Zoom administrator.

**Note:** Zoom licensing and the AI Companion settings above are managed by your organization's IT team or Zoom administrator. If you can't find these settings in Zoom, contact them rather than changing your own account settings.

## Configuration

### Turn on Zoom transcripts in Betterworks

1. Log into Betterworks.

2. Navigate to the **Meetings** page.

3. Select the option to connect Zoom on the banner or prompt.

4. Review the **Connect Zoom to Betterworks** dialog, which lists what Betterworks will access:

   - **1:1 transcripts** — read-only access to transcripts from 1:1s you host or attend
   - **AI 1:1 Prep** — pre-meeting summaries generated from past transcripts
   - **Action items & agenda topics** — suggested items extracted from your 1:1 discussions
   - **Recommendations & insights** — coaching insights and workflow recommendations

5. Select **Accept**.

Betterworks confirms that Zoom has been connected and syncs your calendar so your upcoming 1:1s are ready.

**Note:** You only need to do this once. There is no Zoom sign-in step, no app to install in Zoom, and nothing to reconnect after each meeting.

**Note:** Your 1:1 content is only used to generate your own insights. It is never shared with other users or third parties, and you can disconnect Zoom at any time from your integration settings.

<!-- SCREENSHOT: Betterworks Meetings page connect banner -->
<!-- SCREENSHOT: the "Connect Zoom to Betterworks" dialog listing the four access items and the data usage principles, with Cancel / Accept -->
<!-- INTERNAL: confirm the final connect entry point on the Meetings page with the Meetings pod
(CONN-CAP-001a). The dialog copy above is quoted from ZoomTermsDialog.vue; note the product uses
the org's configured term for "1:1" (CW() interpolation), so a customer whose instance renames
1:1s will see their own label. Consider phrasing the published article with that term. -->

## Usage

### Before your 1:1

1. Open the **Meetings** page and select your upcoming 1:1.

2. Review your preparation brief, which draws on your recent goals, feedback, and previous 1:1s.

**Note:** Your preparation brief is private to you. Your manager has their own brief, and neither of you can see the other's.

<!-- SCREENSHOT: pre-meeting preparation brief on the Meetings page -->

### After your 1:1

1. Open the **Meetings** page and select the 1:1 that has finished.

2. Review the AI recap of what was discussed.

3. Select any item to see the part of the transcript it came from.

**Note:** A recap appears only after Zoom has finished processing the meeting, so allow a short while after the call ends.

<!-- SCREENSHOT: AI recap with provenance / "where this came from" detail open -->

### Action items

1. Review the suggested action items on the recap.

2. Edit the wording of any item you want to change.

3. Select **Confirm** to keep an item, or dismiss the ones you don't want.

**Note:** Suggested action items are not saved anywhere in your Betterworks record until you confirm them.

### Goal recommendations

1. Review the goal recommendation cards on the recap.

2. Select a card to see the suggested goal and the discussion it came from.

3. Select **Confirm** to create or update the goal, or dismiss the recommendation.

**Note:** Confirming a recommendation is the only way it reaches your goals. Nothing is created automatically.

<!-- SCREENSHOT: goal recommendation card with confirm and dismiss actions -->

### Add a transcript manually

If a meeting wasn't captured by Zoom — for example, it happened somewhere else, or AI Companion wasn't running — you can still get a recap.

1. Open the **Meetings** page and select the meeting.

2. Select the option to add a transcript.

3. Upload a transcript file, or paste the transcript text.

Manually added transcripts are processed exactly the same way as transcripts retrieved from Zoom.

<!-- SCREENSHOT: manual transcript upload / paste option -->

## Real-time usage

Walk into a 1:1 already knowing what to raise, without digging through old notes.

Leave a 1:1 without writing anything down, and confirm the follow-ups afterwards in a few clicks.

Turn something your manager agreed to in conversation into an actual goal, with the discussion attached as evidence.

Catch a commitment you'd otherwise have forgotten between one 1:1 and the next.

## Disconnect Zoom

1. Go to your integration settings.

2. Select the Zoom connection.

3. Select **Disconnect**.

Disconnecting withdraws your consent, so Betterworks stops using Zoom transcripts to generate anything for you. Recaps and items already generated remain available to review, and anything you already confirmed stays in your Betterworks record. If you want your existing transcript-derived data deleted rather than just stopped, contact your administrator or the Betterworks Support Team.

**Note:** If the other person in a 1:1 still has Zoom connected, that meeting's transcript can still be processed for **them** — but nothing further is generated for you.

<!-- SCREENSHOT: disconnect Zoom confirmation dialog -->
<!-- INTERNAL: confirm the exact disconnect entry point with the Meetings pod — the component is
DisconnectZoomDialog.vue but the surface it launches from wasn't verified. -->

## Troubleshooting

Ensure that:

- Your administrator has enabled **and** authenticated the Zoom integration in Betterworks. An integration that is switched on but not yet authenticated does not retrieve anything.
- You have accepted the **Connect Zoom to Betterworks** dialog.
- Zoom AI Companion and **Meeting summary with AI Companion** are enabled for **the person who hosted the meeting**, and AI Companion actually ran during the call.
  - Only the host or a co-host can start meeting summary. If your manager hosted the 1:1, check with them — your own setting has no effect on a meeting you didn't host. Your Zoom administrator manages who has it enabled.
- Your Zoom administrator allows transcripts generated with meeting summary to be retained. If they don't, Zoom produces a summary and throws the transcript away, and nothing reaches Betterworks.
- The host is in your organization's Zoom account. A 1:1 hosted by someone on a different Zoom account isn't processed.
- The meeting was a 1:1 rather than a group meeting.
- The 1:1 was scheduled in your calendar with a Zoom join link, rather than started as an ad-hoc call.
- Your calendar is connected to Betterworks.
- The meeting started reasonably close to its scheduled time. A 1:1 that ran hours away from its calendar slot may not be matched.
- Enough time has passed since the meeting ended for Zoom to finish processing the transcript.

**Note:** If you don't see your issue listed above, please reach out to the Betterworks Support Team — support@betterworks.com.

## FAQs

**Does Betterworks join or record my meetings?**

No. Betterworks never joins a meeting and never records anything. There is no bot in the call and no additional participant. Betterworks reads the transcript Zoom itself produced, after the meeting has ended.

**Do I need to install anything in Zoom?**

No. Your administrator authorizes Betterworks once for the whole organization, so there is no app for you to add and no Zoom sign-in for you to complete. Your only step is accepting the consent dialog in Betterworks.

**Do I only get a recap for 1:1s I hosted?**

No. Betterworks can process a 1:1 you attended but didn't host, and you don't need to be the host to get your own recap.

But the host does decide whether a transcript gets created in the first place, because Zoom only lets the host or a co-host start meeting summary. So if your manager hosts your 1:1s and doesn't have **Meeting summary with AI Companion** enabled, none of those meetings produce a transcript — and there is nothing you can turn on at your end to change that. Ask your manager or your Zoom administrator to enable it.

**Why do I need Zoom AI Companion if Betterworks has its own AI?**

Zoom AI Companion is what creates the transcript of your meeting. Betterworks then writes its own recap and recommendations from that transcript using Betterworks AI. Betterworks does not use or show Zoom's own summary — it needs AI Companion purely as the source of the transcript.

**Can my manager or admin see my preparation brief?**

No. Your brief is private to you and stored separately from your manager's. Administrators cannot read it.

**Can my administrator give consent for me?**

No. Your administrator authorizes Zoom for the organization, but the consent that lets Betterworks use your 1:1 transcripts is yours alone, and you can withdraw it at any time.

**Why do I only see recaps for some of my 1:1s?**

Usually it comes down to who hosted. AI Companion runs under the host's Zoom settings, so 1:1s hosted by someone who has meeting summary enabled produce recaps and 1:1s hosted by someone who doesn't produce nothing — which is why it can look inconsistent across your meetings. The other common reasons are that AI Companion wasn't started during the call, that the 1:1 wasn't scheduled in your calendar with a Zoom link, or that your Zoom administrator doesn't allow transcripts to be retained. See [Troubleshooting](#troubleshooting).

**Will anything be added to my goals or reviews automatically?**

No. Every AI suggestion needs your explicit confirmation before it becomes part of your Betterworks record.

**What access does Betterworks have in Zoom?**

Read-only access, granted by your administrator: enough to be told a transcript is ready, to read it, and to identify the meeting it belongs to. Betterworks cannot start, change, or delete Zoom meetings or recordings, and cannot change any Zoom setting.

**How long does Betterworks keep my transcripts?**

Transcripts are kept only for a limited period and are then removed. The recaps and items you confirmed remain in Betterworks under your organization's retention policy.

**What if a meeting wasn't on Zoom?**

You can upload or paste a transcript manually and get the same recap and recommendations. See [Add a transcript manually](#add-a-transcript-manually).
