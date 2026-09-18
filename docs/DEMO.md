# Demo Walkthrough

A short demo should focus on business value first, then show the technical flow.

## Recommended 3–5 Minute Demo

### 1. Problem
Explain that client inquiries often arrive as unstructured messages and must be reviewed manually.

### 2. Submit a Demo Inquiry
Send a sample POST request or submit from a small contact form.

Suggested demo inquiry:

Name: Jordan Lee  
Company: Atlas Studio  
Email: jordan@example.com  
Message: We need a five-page company website with services, case studies, testimonials, and a contact form. Our budget is $2,000 USD and we would like it completed within six weeks.

### 3. Show the API Result
For a new valid lead, show:
- HTTP 202
- accepted status
- generated lead ID

### 4. Show the Lead Database
Open Google Sheets and show:
- original inquiry
- extracted project details
- lead score
- lead quality
- scoring reasons

### 5. Show the Client Reply
Open the privacy-safe email example and explain that the reply was generated from the actual inquiry details.

### 6. Show Smart Routing
Explain:
- Hot → immediate alert
- Warm → one-day reminder
- Cold → nurture queue

### 7. Show Protection
Briefly show:
- invalid submission returns 400
- duplicate returns 200 and stops before AI

### 8. Show Error Monitoring
Show the separate Error Handler workflow and the failure-alert example.

## Key Talking Point

The AI is used to interpret unstructured text and draft communication. Lead qualification itself is rule-based, so the decision is predictable and explainable.
