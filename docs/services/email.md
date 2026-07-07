# Email — Resend

Used for: onboarding drip, waitlist confirmations, win-back emails, blog draft delivery, milestone alerts, PH launch blast.

## Why Resend

- Free tier: 3,000 emails/month, 100/day — sufficient for current volume
- No sandbox restrictions — sends to any address immediately
- Simple SMTP credentials, no AWS IAM setup needed
- Mailpit (local trap) used only for testing workflow logic without sending real email

## Setup

1. Sign up at https://resend.com
2. Add domain: Domains → Add domain → `jobfrank.app`
3. Add the DNS records Resend provides (SPF, DKIM, DMARC) to your domain registrar
4. Wait for verification (usually under 5 minutes)
5. Create API key: API Keys → Create API Key → name it `jobfrank-marketing`
6. Add to `.env`:

```
SMTP_HOST=smtp.resend.com
SMTP_PORT=587
SMTP_USER=resend
SMTP_PASS=re_...
SMTP_FROM=hello@jobfrank.app
```

## n8n SMTP credential

Settings → Credentials → New → **SMTP** → name it `SMTP (Mailpit / SES)`

| Field | Value |
|---|---|
| Host | `smtp.resend.com` |
| Port | `587` |
| SSL/TLS | STARTTLS |
| Username | `resend` |
| Password | your Resend API key (`re_...`) |

## From addresses

All emails send from `hello@jobfrank.app`. Resend requires the domain to be verified before sending.

## Free tier limits

| Limit | Value |
|---|---|
| Monthly | 3,000 emails |
| Daily | 100 emails |
| Upgrade needed when | PH launch blast > 100 subscribers |

At the PH launch blast (workflow 08), if your waitlist exceeds 100, upgrade to Resend's $20/month plan (50,000 emails/month) before firing it.

## Testing locally

To test without sending real emails, temporarily swap to Mailpit in the n8n SMTP credential:

| Field | Value |
|---|---|
| Host | `mailpit` |
| Port | `1025` |
| SSL/TLS | off |
| Username | (empty) |
| Password | (empty) |

View captured emails at http://localhost:8026.
Swap back to Resend when done testing.

## Fallback — AWS SES

If you prefer to consolidate with the jobfrank app's email setup:
- SES SMTP host: `email-smtp.us-east-1.amazonaws.com`, port `587`
- Requires SES production access request (exits sandbox) before sending to unverified addresses
- See `docs/services/aws-ses.md` for SES-specific setup
