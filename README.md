# AI-Powered Client Inquiry & Lead Qualification Automation

An end-to-end n8n automation that receives client inquiries, validates and deduplicates submissions, uses AI to extract project requirements, calculates an explainable lead score, stores leads in Google Sheets, generates personalized email responses, and routes leads based on qualification level.

## Overview

This project automates the client inquiry and lead qualification process for digital service businesses.

Instead of manually reviewing every inquiry, the workflow automatically:

- Validates incoming form data
- Rejects incomplete or invalid submissions
- Prevents duplicate inquiries before AI processing
- Extracts structured project details using AI
- Calculates a deterministic lead score
- Classifies leads as Hot, Warm, or Cold
- Stores qualified leads in Google Sheets
- Generates personalized client email responses
- Sends immediate alerts for Hot leads
- Schedules follow-up reminders for Warm leads
- Stores Cold leads in a nurture queue
- Logs invalid submissions for auditing
- Returns appropriate HTTP responses for valid, invalid, and duplicate submissions
- Monitors workflow failures using a separate error-handling workflow

## Built With

- **n8n** — workflow automation and orchestration
- **OpenAI GPT-5 Mini** — inquiry extraction and personalized reply generation
- **Google Sheets** — lead database, nurture queue, and validation logs
- **Gmail** — client replies and internal notifications
- **Webhooks** — incoming client inquiry endpoint
- **JavaScript** — lead scoring, validation, metadata, and error processing

## Key Features

### Input Validation
Checks required fields and validates email format before any AI processing occurs.

### Duplicate Prevention
Creates a normalized deduplication key using the client's email and inquiry message. Duplicate inquiries are stopped before calling the AI model, reducing unnecessary API usage.

### AI-Powered Information Extraction
Converts unstructured inquiry messages into structured information such as:

- Project type
- Budget amount
- Currency
- Timeline
- Requirements
- Urgency

### Explainable Lead Scoring
Lead qualification is handled using deterministic JavaScript rules rather than allowing the AI model to decide whether a lead is good or bad.

Each lead receives:

- A score from `0–100`
- A qualification of `Hot`, `Warm`, or `Cold`
- A list of reasons explaining the score

### Personalized Client Responses
AI generates a professional reply based on the client's actual project details, budget, timeline, and lead classification.

### Smart Lead Routing

**Hot Lead**
- Client receives a personalized response
- Business owner receives an immediate priority alert

**Warm Lead**
- Client receives a personalized response
- Workflow waits one day
- Business owner receives a follow-up reminder

**Cold Lead**
- Client receives a personalized response
- Lead is added to a nurture queue for future follow-up

### Error Monitoring
A separate n8n error-handling workflow captures failed executions and sends an internal alert containing:

- Workflow name
- Failed node
- Error message
- Execution ID
- Execution link
- Failure timestamp

## API Responses

The webhook returns different responses depending on the submission:

| Scenario | HTTP Status | Result |
| --- | --- | --- |
| Valid new inquiry | `202 Accepted` | Lead accepted and processing continues |
| Duplicate inquiry | `200 OK` | Existing inquiry detected and processing stops |
| Invalid submission | `400 Bad Request` | Missing or invalid fields are reported |

## AI-Assisted Development

This project was developed with AI-assisted guidance for planning, debugging, documentation, and reviewing implementation decisions.

The workflow itself was manually configured, tested, debugged, and validated in n8n, including:

- Node configuration
- Data mapping
- JavaScript business logic
- Lead-scoring rules
- Conditional routing
- API/webhook testing
- Google Sheets integration
- Gmail integration
- Error handling
- Production testing



## Architecture

The automation follows a layered workflow designed to validate, protect, process, qualify, and respond to client inquiries while minimizing unnecessary AI usage.

![Workflow Architecture](assets/workflow-architecture.png)

### High-Level Flow

```text
Client / Website Form
        ↓
Webhook Intake
        ↓
Normalize Data
        ↓
Validate Submission
   ┌───────────────┴───────────────┐
 Invalid                         Valid
    ↓                              ↓
Log Invalid                  Add Metadata
Submission                        ↓
    ↓                        Duplicate Check
HTTP 400                  ┌───────┴────────┐
                      Duplicate          New Lead
                          ↓                  ↓
                      HTTP 200         AI Extraction
                                             ↓
                                      Build Lead Record
                                             ↓
                                      Calculate Lead Score
                                             ↓
                                      Google Sheets
                                      ↙            ↘
                                HTTP 202        AI Reply
                                                  ↓
                                             Client Email
                                                  ↓
                                          Lead Quality Routing
                                      ┌────────┼────────┐
                                     Hot      Warm      Cold
                                      ↓         ↓         ↓
                                 Priority    Wait     Nurture
                                   Alert     1 Day      Queue
                                               ↓
                                            Reminder
AI is also intentionally used **inside the finished automation** for information extraction and personalized response generation, while critical business decisions such as lead scoring and routing remain rule-based and explainable.
