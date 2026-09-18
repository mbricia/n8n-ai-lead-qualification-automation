# n8n Workflow Exports

This folder contains **sanitized exports of the actual n8n workflows used for this portfolio project**.

## Files

- [main-workflow.sanitized.json](main-workflow.sanitized.json) — main client inquiry and lead qualification workflow
- [error-handler.sanitized.json](error-handler.sanitized.json) — centralized workflow failure handler

## Sanitization Applied

Before committing the exports, account-specific and private values were removed or replaced, including:

- n8n credential references
- Gmail credential IDs
- Google Sheets credential IDs
- Google Spreadsheet IDs and cached URLs
- fixed internal notification email addresses
- webhook IDs
- workflow/version/instance identifiers
- error-workflow account linkage
- account-specific tag IDs

The exports are also committed with `active: false`.

## Reconnecting After Import

After importing the workflows into another n8n workspace:

1. Select your OpenAI credential for both model nodes.
2. Select your Gmail credential for client and internal email nodes.
3. Replace `owner@example.com` with the desired internal notification address.
4. Select/create the Google Sheets document and the required tabs:
   - Leads
   - Invalid Submissions
   - Nurture Queue
5. Re-select the correct sheet in each Google Sheets node.
6. Import the Error Handler workflow.
7. In the main workflow settings, assign the imported Error Handler as the **Error Workflow**.
8. Review the webhook path before publishing.
9. Run the synthetic test cases before enabling the production webhook.

## Important

These files are intended as portfolio/reference exports. They contain the workflow logic and node structure, but **do not contain working credentials or the original private Google Sheet connection**.

Never add real secrets or client data to the public versions.
