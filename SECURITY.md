# Security & Privacy

This is a public portfolio repository. It intentionally excludes secrets and private account details.

## Do Not Commit

- n8n credentials
- OAuth tokens
- OpenAI/API keys
- private webhook URLs
- personal test email addresses
- Google Sheet IDs containing real client data
- n8n account or execution identifiers
- real client records

## Demo Data

All names, companies, email addresses, budgets, and inquiry messages used in this repository are synthetic examples.

## Workflow Exports

Before committing an n8n workflow export:

1. Export the workflow from n8n.
2. Open the JSON locally.
3. Search for credential IDs, webhook URLs, email addresses, spreadsheet IDs, and account-specific identifiers.
4. Replace or remove sensitive values.
5. Re-import the sanitized copy into a test workspace when possible.
6. Only then commit the export.

The repository documents the architecture even when the live workflow export is omitted for privacy.
