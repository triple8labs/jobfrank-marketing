# JobFrank Marketing Automations

Self-hosted marketing automation stack for JobFrank. All workflows run in n8n (Docker) with human-in-the-loop approval gates before anything posts publicly.

## Services

| Service  | Purpose                          | URL                        |
|----------|----------------------------------|----------------------------|
| n8n      | Workflow automation              | http://localhost:5678      |
| mailpit  | Local SMTP / email inbox         | http://localhost:8025      |
| postgres | n8n data persistence             | internal                   |

## Quick start

```bash
cp .env.example .env
# fill in secrets in .env
bash scripts/start.sh
```

Import workflows from `n8n/workflows/` via n8n UI: Settings → Import workflow.

## Workflows

| # | File | Trigger | Channel |
|---|------|---------|---------|
| 01 | email-onboarding-drip | Webhook (new user) | Email |
| 02 | reddit-monitor-reply | Every 2 hours | Reddit |
| 03 | linkedin-pipeline | Mon/Wed/Fri 8am | LinkedIn |
| 04 | reddit-daily-posts | Daily 10am | Reddit |
| 05 | waitlist-capture | Webhook (signup) | Email |
| 06 | seo-blog-generator | Manual webhook | Blog |
| 07 | winback-emails | Daily 9am | Email |
| 08 | ph-launch-blast | Manual trigger | Email |
| 09 | linkedin-job-seeker-ads | Manual trigger | LinkedIn Ads |

## Docs

- [Inventory](docs/inventory.md) — all SaaS/API accounts and credentials map
- [Services](docs/services/) — per-service setup notes
- [Logs](docs/logs/) — daily activity log
