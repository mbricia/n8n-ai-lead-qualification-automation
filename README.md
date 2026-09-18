# AI-Powered Client Inquiry & Lead Qualification Automation

An end-to-end n8n automation that receives client inquiries, validates and deduplicates submissions, uses AI to extract project requirements, calculates an explainable lead score, stores leads in Google Sheets, generates personalized email responses, and routes leads based on qualification level.

## Overview

This project automates the client inquiry and lead qualification process for digital service businesses.

Instead of manually reviewing every inquiry, the workflow automatically:

- validates incoming form data
- prevents duplicate submissions
- extracts structured project details using AI
- calculates a deterministic lead score
- classifies leads as Hot, Warm, or Cold
- stores lead information in Google Sheets
- generates personalized client replies
- sends priority alerts for high-value leads
- schedules follow-up reminders for warm leads
- stores cold leads in a nurture queue
- logs invalid submissions
- monitors workflow failures through a separate error-handling workflow


## Built With

- n8n
- OpenAI GPT-5 Mini
- Google Sheets
- Gmail
- Webhooks
- JavaScript
