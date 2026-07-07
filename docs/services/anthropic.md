# Anthropic Claude API

Used for: Reddit reply drafts, LinkedIn post generation, blog MDX drafts, win-back email copy.

## Model

`claude-sonnet-4-6` — best balance of quality and cost for marketing copy.

## Setup

1. Get API key from https://console.anthropic.com
2. Add to `.env`: `ANTHROPIC_API_KEY=sk-ant-...`

## Usage in n8n

All workflows call the API via `n8n-nodes-base.httpRequest`:

```
POST https://api.anthropic.com/v1/messages
Headers:
  x-api-key: {{ $env.ANTHROPIC_API_KEY }}
  anthropic-version: 2023-06-01
  content-type: application/json
Body:
  { "model": "claude-sonnet-4-6", "max_tokens": 1024, "messages": [...] }
```

## Cost notes

- Sonnet input: ~$3/MTok, output: ~$15/MTok
- Typical blog draft: ~2k tokens → ~$0.03
- Typical social post: ~500 tokens → ~$0.01
- Reddit reply: ~300 tokens → <$0.01
- Estimate: <$5/month at current volume

## Rate limits

- Default: 2,000 RPM, 200k TPM on Sonnet
- More than sufficient for scheduled workflows
