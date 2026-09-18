# n8n Workflow Exports

The live n8n workflows are documented in this repository, but the exact account export is not committed by default because workflow JSON can contain account-specific identifiers, credential references, webhook information, and integration IDs.

## Workflows

### Main
AI Lead Qualification | Client Inquiry Automation

Core stages:
- webhook intake
- normalization
- validation
- invalid-submission logging
- metadata generation
- duplicate check
- AI information extraction
- lead scoring
- lead storage
- HTTP response
- personalized reply generation
- Gmail delivery
- Hot/Warm/Cold routing

### Error Handler
AI Lead Qualification | Error Handler

Core stages:
- Error Trigger
- error payload normalization
- Gmail failure notification

## Before Adding an Export

Export the workflow from n8n, then sanitize:
- credential IDs
- webhook URLs
- personal email addresses
- Google Sheet IDs
- account/workspace IDs
- execution URLs
- any real client data

After sanitization, save suggested files as:

~~~text
workflows/
├── main-workflow.sanitized.json
└── error-handler.sanitized.json
~~~

Do not invent or hand-write a fake n8n export. Commit only an export produced by n8n and reviewed for privacy.
