# Setup / Recreation Guide

This document explains how to recreate the portfolio workflow without exposing the original account configuration.

## Requirements

- n8n workspace
- OpenAI-compatible chat model credential
- Google account with Sheets access
- Gmail credential in n8n

## Google Sheets

Create one spreadsheet with these tabs.

### Leads
Suggested columns:
- lead_id
- dedupe_key
- received_at
- client_name
- client_email
- company_name
- inquiry_message
- project_type
- budget_amount
- budget_currency
- deadline
- requirements
- urgency
- lead_score
- lead_quality
- score_reasons

### Nurture Queue
Suggested columns:
- added_at
- client_name
- client_email
- company_name
- project_type
- lead_score
- lead_quality
- requirements
- original_inquiry
- next_action

### Invalid Submissions
Suggested columns:
- rejected_at
- client_name
- client_email
- company_name
- inquiry_message
- validation_status
- missing_fields
- validation_reason
- validation_issues

## Main Workflow Order

1. Webhook — POST
2. Normalize inquiry
3. Validate required fields + email
4. Invalid branch → build invalid record → log → HTTP 400
5. Valid branch → add lead metadata
6. Check Google Sheets for dedupe key
7. Duplicate branch → HTTP 200
8. New branch → restore intake record
9. AI information extraction
10. Build lead record
11. Calculate lead score
12. Append lead to Google Sheets
13. Return HTTP 202
14. AI generate client reply
15. Build response record
16. Send client email
17. Route by lead quality
18. Hot → immediate internal alert
19. Warm → wait one day → reminder
20. Cold → append to nurture queue

## AI Extraction Fields

The extraction step should return:
- project_type
- budget_amount
- budget_currency
- deadline
- requirements
- urgency

The prompt should explicitly instruct the model not to invent missing information.

## Scoring Logic

Recommended portfolio scoring:
- complete contact information: 10
- clear project type: 25
- budget amount: 15
- budget currency: 10
- project timeline: 20
- detailed requirements: 20

Thresholds:
- Hot: 80+
- Warm: 50–79
- Cold: below 50

## Error Workflow

Create a second workflow:
1. Error Trigger
2. Code node to normalize the error payload
3. Gmail node to send an internal failure alert

Assign this workflow as the Error Workflow in the main workflow settings.

## Production Notes

- Use the production webhook URL only after the workflow is published.
- Keep client reply recipient dynamic.
- Keep internal notification recipients fixed to the business/admin inbox.
- Avoid enabling blind retry on email-send or append-row nodes unless the destination is idempotent.
- Never commit credentials or live webhook URLs to a public repository.
