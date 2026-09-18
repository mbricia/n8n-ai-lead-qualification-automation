# Privacy-safe webhook test helper
# Usage:
#   $env:N8N_WEBHOOK_URL = "https://YOUR-N8N-HOST/webhook/client-inquiry"
#   .\sample-data\test-webhook.ps1

if (-not $env:N8N_WEBHOOK_URL) {
    Write-Error "Set N8N_WEBHOOK_URL before running this script."
    exit 1
}

$body = @{
    client_name = 'Jordan Lee'
    client_email = 'jordan@example.com'
    company_name = 'Atlas Studio'
    inquiry_message = 'Hi, we need a five-page company website with services, case studies, testimonials, and a contact form. Our budget is $2,000 USD and we would like it completed within 6 weeks.'
} | ConvertTo-Json

try {
    $response = Invoke-WebRequest `
        -Uri $env:N8N_WEBHOOK_URL `
        -Method POST `
        -ContentType "application/json" `
        -Body $body

    Write-Host "Status:" $response.StatusCode
    Write-Host "Body:" $response.Content
}
catch {
    $response = $_.Exception.Response
    if ($response) {
        Write-Host "Status:" ([int]$response.StatusCode)
    } else {
        Write-Host "Request failed:" $_.Exception.Message
    }
}
