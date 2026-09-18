# Architecture & Design Decisions

## Goal

Build a client-inquiry automation that is understandable, testable, and useful for a real digital-services business.

## Main Design Principle

Use AI for **language interpretation**, but use deterministic rules for **business decisions**.

This keeps the workflow explainable and prevents lead quality from changing because of model variation.

## Processing Layers

### 1. Intake
A POST webhook receives client name, email, company, and inquiry message.

### 2. Normalization
The raw webhook body is converted into a clean internal record. Unneeded request metadata is removed.

### 3. Validation
Required fields are checked before any AI call. Email format is also validated.

Invalid submissions are logged and return HTTP 400.

### 4. Intake Metadata
Valid requests receive:
- lead ID
- received timestamp
- deduplication key

### 5. Deduplication
The workflow searches Google Sheets for an existing deduplication key before AI processing.

Duplicate requests return HTTP 200 and stop early.

### 6. AI Extraction
GPT-5 Mini converts free-form inquiry text into:
- project type
- budget amount
- budget currency
- deadline
- requirements
- urgency

### 7. Lead Record
Original client data, metadata, and AI-extracted fields are combined into one record.

### 8. Deterministic Scoring
JavaScript assigns points using explicit rules. The result includes:
- lead_score
- lead_quality
- score_reasons

### 9. Persistence
New leads are appended to Google Sheets as a lightweight lead database.

### 10. API Acknowledgement
After storage, the webhook returns HTTP 202 Accepted while downstream communication continues.

### 11. AI Reply
A second AI step drafts a personalized response based on the structured lead record.

The prompt is constrained not to invent pricing, availability, or commitments.

### 12. Routing
Hot, Warm, and Cold leads receive different internal actions.

### 13. Error Monitoring
A separate error workflow receives n8n execution failures, normalizes the error payload, and sends an internal Gmail alert.

## Why Duplicate Checking Happens Before AI

Duplicate prevention was moved upstream after testing.

Benefits:
- no unnecessary LLM call for repeated submissions
- fewer API costs
- no duplicate client reply
- no duplicate internal alert
- no duplicate database row

## Why Google Sheets

Google Sheets was chosen for the first portfolio version because it is:
- easy to inspect
- common in small-business automations
- simple to demonstrate
- sufficient for the expected demo scale

For a larger production implementation, the same architecture can be adapted to a CRM or database such as HubSpot, Airtable, PostgreSQL, or Supabase.

## Retry Strategy

Automatic retries are enabled only where repeating an operation is reasonably safe:
- AI extraction
- AI reply generation
- read-only duplicate lookup

Write/send actions are treated more conservatively because blind retries can create duplicate rows or duplicate emails.

## HTTP Behavior

| Case | Status |
| --- | --- |
| Invalid submission | 400 |
| Duplicate submission | 200 |
| New accepted lead | 202 |
