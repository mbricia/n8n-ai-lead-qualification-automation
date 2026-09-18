# Testing Strategy

The workflow was tested incrementally while it was being built, then validated again using the production webhook.

## Test Matrix

| Test | Input / Condition | Expected Result | Result |
| --- | --- | --- | --- |
| Valid Hot lead | Complete inquiry with budget and timeline | Score 80–100, stored, client reply, immediate alert | Passed |
| Valid Warm lead | Useful inquiry but missing some qualification signals | Score 50–79, stored, delayed reminder | Passed |
| Valid Cold lead | Minimal inquiry with low information | Score 0–49, stored, nurture queue | Passed |
| Missing email | Empty client_email | Invalid branch, audit log, HTTP 400 | Passed |
| Invalid email | client_email = hello | Invalid branch, validation issue, HTTP 400 | Passed |
| Duplicate inquiry | Same email + same normalized inquiry | Stop before AI, HTTP 200, no duplicate row | Passed |
| New valid inquiry | Unique inquiry | HTTP 202 after storage | Passed |
| AI reply delivery | Real controlled test inbox | Personalized email received | Passed |
| Hot lead alert | Hot lead | Internal Gmail alert received | Passed |
| Warm reminder | Warm lead with temporary 1-minute test delay | Reminder received | Passed |
| Error workflow | Intentional Stop and Error test | Separate error workflow executed and emailed alert | Passed |

## Example Scoring Tests

### Hot
Expected signals:
- complete contact info
- clear project type
- budget amount and currency
- timeline
- detailed requirements

Expected range: 80–100.

### Warm
Example:
- complete contact info
- clear project type
- budget amount
- no currency
- no deadline
- detailed requirements

Observed example score: 70.

### Cold
Example:
- complete contact info
- clear project type
- no budget
- no timeline
- basic requirements

Observed example score: 45.

## Production Smoke Test

A final production URL test verified:
- webhook accepted a new inquiry
- HTTP 202 was returned
- lead was written to Google Sheets
- personalized client reply reached a separate test inbox
- Hot lead alert reached the internal inbox
- workflow completed successfully

## Notes

All testing used synthetic demo records. No real client data is included in this repository.
