# LinkedIn API — Share + Advertising

Used for: organic posts to JobFrank company page (workflow 03), sponsored campaigns targeting job seekers (workflow 09).

## Status

| API | Approved | Date |
|-----|----------|------|
| Share on LinkedIn | Yes | 2026-07-07 |
| Advertising API | Yes | 2026-07-07 |

## Confirmed credentials

| Variable | Value |
|----------|-------|
| `LINKEDIN_AUTHOR_URN` | `urn:li:organization:135284820` (JobFrank company page) |
| `LINKEDIN_ACCESS_TOKEN` | Set in `.env` — expires after 2 months |
| `LINKEDIN_ACCOUNT_ID` | Run curl below to find |
| `LINKEDIN_CAMPAIGN_GROUP_ID` | Leave blank — workflow 09 auto-creates |
| `LINKEDIN_JOB_SEEKER_URN` | Run curl below to find |

## OAuth scopes granted

| Scope | Purpose |
|-------|---------|
| `w_member_social` | Post on personal profile |
| `w_organization_social` | Post as JobFrank company page (workflow 03) |
| `r_organization_social` | Read org posts and engagement |
| `r_ads` | Read ad accounts |
| `rw_ads` | Create and manage campaigns (workflow 09) |
| `r_ads_reporting` | Campaign performance data |
| `r_organization_admin` | Org page analytics |

## Find remaining IDs

**Ad Account ID** — paste your token:
```bash
curl -s -H "Authorization: Bearer YOUR_TOKEN" \
  -H "LinkedIn-Version: 202401" \
  "https://api.linkedin.com/v2/adAccountsV2?q=search" | python3 -m json.tool
```
Look for `"id"` → add to `.env` as `LINKEDIN_ACCOUNT_ID=`

**Job Seeker targeting URN:**
```bash
curl -s -H "Authorization: Bearer YOUR_TOKEN" \
  -H "LinkedIn-Version: 202401" \
  "https://api.linkedin.com/v2/adTargetingEntities?q=typeahead&query=job%20seeker&facet=urn:li:adTargetingFacet:memberBehaviors" | python3 -m json.tool
```
Find the "Job Seekers" entry → copy its `urn` field → add to `.env` as `LINKEDIN_JOB_SEEKER_URN=`

## Token refresh

Access tokens expire after **2 months**. Regenerate via LinkedIn Developer portal:
LinkedIn Developers → My apps → JobFrankMarketing → Auth → OAuth 2.0 tools → same scopes → Request access token.

Next renewal due: **2026-09-07**. Update `LINKEDIN_ACCESS_TOKEN` in `.env` and restart n8n.

## Budget reference (workflow 09)

LinkedIn API budget is in **cents** (USD):

| Daily budget | API value |
|---|---|
| $5/day | 500 |
| $10/day | 1000 |
| $20/day | 2000 |

Minimum: ~$10/day. Recommended start: $10/day for 7 days to test copy performance.
