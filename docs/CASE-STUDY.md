# Case Study

## Project

AI-Powered Client Inquiry & Lead Qualification Automation

## Problem

A service business can receive client inquiries containing different levels of detail. Manually reading each message, identifying requirements, evaluating lead quality, replying, and remembering follow-ups creates repetitive work and increases the chance of missed opportunities.

## Objective

Create an automation that can:

- accept website inquiries
- reject malformed submissions
- avoid duplicate processing
- convert free-form messages into structured data
- qualify leads using transparent business rules
- store lead records
- send personalized replies
- route leads to the appropriate follow-up action
- alert the owner when the automation fails

## Solution

I built an end-to-end n8n workflow using a webhook, JavaScript business logic, OpenAI, Google Sheets, and Gmail.

AI handles two tasks:
1. extracting structured information from unstructured inquiry text
2. drafting a personalized client response

Lead scoring is intentionally not delegated to AI. A deterministic 100-point scoring system evaluates completeness, budget, timeline, project type, and requirement clarity.

## Production-Style Safeguards

The final workflow includes:
- input validation
- email-format validation
- invalid-submission audit log
- deduplication before AI
- unique lead IDs
- explainable scoring reasons
- correct HTTP status responses
- selective retry-on-failure
- centralized error monitoring

## Outcome

The finished system can receive an inquiry and automatically produce:
- a structured lead record
- a qualification score
- a Hot/Warm/Cold classification
- a Google Sheets entry
- a personalized client email
- the appropriate internal follow-up action

The workflow was validated with Hot, Warm, Cold, invalid, duplicate, and intentional-error scenarios, then tested through the production webhook.
