# Reddit API

Used for: monitoring job-search threads (workflow 02), daily value posts (workflow 04).

## API access status (as of 2026-07-07)

Reddit ended self-service API key creation in late 2025 ("Responsible Builder Policy"). Attempting to create a script app directly at `reddit.com/prefs/apps` without prior registration now returns a 500. New applicants must submit a manual Developer Support request first:

1. Go to https://old.reddit.com/wiki/api#wiki_read_the_full_api_terms_and_sign_up_for_usage
2. Click "submit a request" → select **"I'm a Developer"** and **"I want to register to use the Reddit API"**
3. Fill out the form (see "Developer Support application" below for the text submitted)
4. Wait for manual review — approval is not guaranteed; Reddit favors established/commercial use cases with narrow scope and reportedly rejects small/marketing-flavored requests
5. Only after approval, proceed to app creation below

**Status: submitted, awaiting Reddit review.**

## Bot account

- Username: **u/JobFrank** (new dedicated account — confirm exact registered handle once created, in case of availability collision)
- Disclosure: account bio discloses JobFrank affiliation (e.g. "Hi, I'm from JobFrank — here to help with resume/ATS questions"). Decided to disclose rather than run unaffiliated, per Reddit self-promotion rules and to reduce ban/API-rejection risk.

## Developer Support application (submitted 2026-07-07)

**Purpose/benefit to Redditors:** Helps surface and answer resume/job-application questions in job-search communities. Monitors a small set of subreddits for people explicitly asking for help and drafts a specific, useful reply. Every reply and post is reviewed and approved by a human before it's ever published.

**Behavior description:** Monitor & reply (every 2 hours) searches fixed keyword list across target subreddits, drafts one reply per matched thread, held for human approval. Daily value post (once/day) generates one original tips post, held for approval, max one post per subreddit per day. No mass-replying, no link-only comments, no repeat posting to the same thread.

**Why not Devvit:** Devvit apps run inside a single subreddit's sandbox for communities the developer manages. This needs cross-subreddit monitoring (subs we don't moderate), an external LLM call (Anthropic API) to draft replies, and an external human-approval queue — not supported by Devvit's single-subreddit app model.

**Source code:** https://github.com/triple8labs/jobfrank-marketing

**Subreddits:** r/cscareerquestions, r/jobs, r/resumes, r/jobsearchhacks

**Username:** u/JobFrank

## App setup (after Developer Support approval)

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
