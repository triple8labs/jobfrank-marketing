# Buffer

Used for: LinkedIn post scheduling (workflow 03).

## Setup

1. Create account at https://buffer.com
2. Connect LinkedIn profile
3. Generate access token: https://buffer.com/developers/api → create app → get token
4. Get profile ID: `GET https://api.bufferapp.com/1/profiles.json?access_token=YOUR_TOKEN`
5. Add to `.env`: BUFFER_ACCESS_TOKEN, BUFFER_PROFILE_ID (the LinkedIn profile id from above)

## API used

```
POST https://api.bufferapp.com/1/updates/create.json
Body:
  access_token=...
  profile_ids[]=...
  text=...
  scheduled_at=... (ISO 8601, optional — omit to add to queue)
```

## Posting schedule

Mon / Wed / Fri at 8am (configured in workflow 03 cron).
Buffer queues the post; actual send time depends on your Buffer schedule settings.

## Content themes

| Day | Theme |
|-----|-------|
| Monday | Job search tip / career insight |
| Wednesday | Resume / ATS insight |
| Friday | JobFrank feature highlight or user win |

## Free plan limits

- 1 connected channel
- 10 scheduled posts per channel
- Sufficient for 3×/week cadence
