# n8n

Self-hosted workflow automation. Runs as a Docker service backed by PostgreSQL.

## Access

- URL: http://localhost:5678
- Username: `admin`
- Password: `N8N_PASSWORD` from `.env`

## Setup

1. Copy `.env.example` → `.env`, set `N8N_ENCRYPTION_KEY` (32+ random chars), `N8N_PASSWORD`, `POSTGRES_PASSWORD`
2. `bash scripts/start.sh`
3. Open http://localhost:5678, log in
4. Import workflows: Settings → Import workflow → select JSON from `n8n/workflows/`
5. In each workflow, set credentials (SMTP, HTTP headers for APIs)

## Credentials to create in n8n UI

| Name | Type | Notes |
|------|------|-------|
| SMTP (Mailpit / SES) | SMTP | Host: mailpit, Port: 1025 (local) |

All API calls to Anthropic, Reddit, Buffer use `n8n-nodes-base.httpRequest` with headers set inline from `$env.*`. No additional n8n credentials needed for those.

## Data persistence

- Workflow definitions: `n8n-data` Docker volume (PostgreSQL)
- Execution history: same volume, pruned after 7 days (`EXECUTIONS_DATA_MAX_AGE=168`)
- Static workflow data (`$getWorkflowStaticData`): persisted in n8n DB

## Updating n8n

```bash
docker compose pull n8n
docker compose up -d n8n
```

## Logs

```bash
docker compose logs -f n8n
```
