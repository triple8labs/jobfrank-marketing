# Reddit API

Used for: monitoring job-search threads (workflow 02), daily value posts (workflow 04).

## App setup

1. Go to https://www.reddit.com/prefs/apps
2. Create app → type: **script**
3. Name: `JobFrank Marketing Bot`
4. Redirect URI: `http://localhost:8080` (unused but required)
5. Note the `client_id` (under app name) and `client_secret`
6. Add to `.env`: REDDIT_CLIENT_ID, REDDIT_CLIENT_SECRET, REDDIT_USERNAME, REDDIT_PASSWORD

## Auth flow

Workflows use OAuth2 password flow (script apps only):

```
POST https://www.reddit.com/api/v1/access_token
Authorization: Basic base64(client_id:client_secret)
Body: grant_type=password&username=...&password=...
```

Returns a bearer token valid for 1 hour. Each workflow fetches a fresh token at execution time.

## Target subreddits

| Subreddit | Focus | Post type |
|-----------|-------|-----------|
| r/cscareerquestions | Tech job seekers | Value posts, replies |
| r/jobs | General job search | Value posts, replies |
| r/resumes | Resume help | Value posts, replies |
| r/jobsearchhacks | Job search tips | Value posts |

## Rate limits

- 60 requests/minute authenticated
- Post karma requirements vary by subreddit — use an aged account
- Avoid posting more than once per subreddit per day

## Keywords monitored (workflow 02)

- "tailor resume"
- "resume not getting interviews"
- "ATS rejection"
- "cover letter help"
- "job application help"

## Account notes

| Field | Value |
|-------|-------|
| Account age required | 30+ days recommended |
| Subreddit karma | Build before automating |
| User-Agent | `JobFrankBot/1.0 by u/YOUR_USERNAME` |
