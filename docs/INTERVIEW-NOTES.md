# Interview Talking Points

## 30-Second Explanation

I built an n8n automation for client inquiry intake and lead qualification. A webhook receives the inquiry, then the workflow validates it and checks for duplicates before making any AI call. GPT-5 Mini extracts project details from the free-form message. I then use JavaScript rules to calculate a 0–100 lead score, save the result in Google Sheets, generate a personalized client reply, and route Hot, Warm, and Cold leads to different follow-up actions.

## Why Not Let AI Score the Lead?

I wanted the qualification decision to be predictable and explainable. AI is good at interpreting unstructured text, but business scoring rules should be deterministic. This lets me show exactly why a lead received a specific score.

## Why Check Duplicates Before AI?

It avoids unnecessary API usage and prevents repeated emails, notifications, and database rows.

## Why Google Sheets?

For a first real-world portfolio version, it is easy for a small business to inspect and manage. The architecture can later be migrated to a CRM or database without changing the overall workflow pattern.

## Why Separate Error Handling?

It centralizes operational monitoring. If the main workflow fails, a separate error workflow receives the failure information and sends an alert with the failed node, message, execution ID, and execution link.

## What Was the Hardest Part?

The main challenge was preserving the correct data shape across branches and AI nodes. Some nodes replace the current JSON output, so I created explicit build/restore record steps and tested each stage before connecting the full workflow.

## What Would You Improve Next?

Depending on client needs:
- replace Google Sheets with a CRM/database
- add configurable scoring thresholds
- add human approval for selected replies
- add analytics/dashboarding
- connect a real website form
- add structured observability and alert escalation

## What Did You Learn?

- how webhook payloads flow through n8n
- data mapping and JSON transformations
- when to use AI versus deterministic logic
- duplicate prevention
- safe retry decisions
- branch-specific processing
- delayed workflows
- production webhook responses
- centralized failure monitoring
