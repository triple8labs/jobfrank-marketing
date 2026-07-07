# Email — Mailpit (local) / AWS SES (production)

Used for: onboarding drip, waitlist confirmations, win-back emails, blog draft delivery, milestone alerts.

## Local (Mailpit)

Mailpit runs as a Docker service. No credentials needed.

```
SMTP_HOST=mailpit
SMTP_PORT=1025
SMTP_FROM=hello@jobfrank.app
```

View sent emails at http://localhost:8025.

## Production (AWS SES)

SES is already initialized in the JobFrank LocalStack environment. For production:

1. Verify sending domain `jobfrank.app` in SES console
2. Request production access (exit sandbox) — required to email non-verified addresses
3. Create SMTP credentials: SES → SMTP Settings → Create credentials
4. Update `.env`:

```
SMTP_HOST=email-smtp.us-east-1.amazonaws.com
SMTP_PORT=587
SMTP_USER=AKIAIOSFODNN7EXAMPLE
SMTP_PASS=your-ses-smtp-password
SMTP_FROM=hello@jobfrank.app
```

5. Update n8n SMTP credential to match

## n8n SMTP credential

In n8n UI: Settings → Credentials → New → SMTP

| Field | Local value | Prod value |
|-------|-------------|------------|
| Host | mailpit | email-smtp.us-east-1.amazonaws.com |
| Port | 1025 | 587 |
| SSL/TLS | off | STARTTLS |
| User | (none) | SES SMTP user |
| Password | (none) | SES SMTP password |

## Sending limits

- SES sandbox: 200 emails/day, verified addresses only
- SES production: 50,000/day default, request increase as needed

## From addresses used

| Workflow | From | Subject prefix |
|----------|------|----------------|
| 01 onboarding | hello@jobfrank.app | — |
| 05 waitlist | hello@jobfrank.app | — |
| 06 blog draft | hello@jobfrank.app | [Blog Draft] |
| 07 winback | hello@jobfrank.app | — |
| 08 PH blast | hello@jobfrank.app | — |
| alerts | hello@jobfrank.app | [Alert] |
