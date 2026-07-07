# SaaS / API Inventory

Master list of all external services used in the marketing stack. Update this whenever a credential is created, rotated, or revoked.

## Services

| Service | Purpose | Status | Setup Doc | Credential Location |
|---------|---------|--------|-----------|---------------------|
| n8n | Workflow automation (self-hosted) | Active | [docs/services/n8n.md](services/n8n.md) | `.env` — N8N_PASSWORD, N8N_ENCRYPTION_KEY |
| Anthropic Claude | Content generation | Needs key | [docs/services/anthropic.md](services/anthropic.md) | `.env` — ANTHROPIC_API_KEY |
| Reddit API | Post + monitor | Needs OAuth app | [docs/services/reddit.md](services/reddit.md) | `.env` — REDDIT_CLIENT_ID/SECRET/USERNAME/PASSWORD |
| LinkedIn Share API | Organic posts (workflow 03) | **Approved 2026-07-07** | [docs/services/linkedin-ads.md](services/linkedin-ads.md) | `.env` — LINKEDIN_ACCESS_TOKEN |
| LinkedIn Advertising API | Job seeker ad campaigns (workflow 09) | **Approved 2026-07-07** | [docs/services/linkedin-ads.md](services/linkedin-ads.md) | `.env` — LINKEDIN_ACCESS_TOKEN, LINKEDIN_ACCOUNT_ID, LINKEDIN_CAMPAIGN_GROUP_ID, LINKEDIN_JOB_SEEKER_URN |
| Resend | Transactional email | Needs API key + domain verify | [docs/services/email.md](services/email.md) | `.env` — SMTP_HOST/PORT/USER/PASS/FROM |
| Mailpit | Local SMTP testing only | Active (Docker, port 8026) | [docs/services/email.md](services/email.md) | Docker service |
| PostHog | Analytics | Separate (in-app) | — | jobfrank app config |

## Workflows → Services dependency map

| Workflow | Anthropic | Reddit | LinkedIn API | Buffer | SMTP |
|----------|-----------|--------|--------------|--------|------|
| 01 email-onboarding-drip | — | — | — | — | ✓ |
| 02 reddit-monitor-reply | ✓ | ✓ | — | — | — |
| 03 linkedin-pipeline | ✓ | — | Share API (or Buffer) | optional | — |
| 04 reddit-daily-posts | ✓ | ✓ | — | — | — |
| 05 waitlist-capture | — | — | — | — | ✓ |
| 06 seo-blog-generator | ✓ | — | — | — | ✓ |
| 07 winback-emails | ✓ | — | — | — | ✓ |
| 08 ph-launch-blast | — | — | — | — | ✓ |
| 09 linkedin-job-seeker-ads | ✓ | — | Advertising API | — | ✓ |

## Credential rotation log

| Date | Service | Action | Who |
|------|---------|--------|-----|
| 2026-07-07 | all | Initial setup | sivensadiyan |
| 2026-07-07 | LinkedIn Share API | Approved by LinkedIn | sivensadiyan |
| 2026-07-07 | LinkedIn Advertising API | Approved by LinkedIn | sivensadiyan |
