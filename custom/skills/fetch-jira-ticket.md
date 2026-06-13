# Skill: Fetch Jira Ticket

**Purpose**: Retrieve a Jira ticket by ID and normalise its data into a structured object that the rest of the Jira Hero workflow can use without re-fetching or re-parsing.

---

## Instructions

### 1. Accept the Ticket ID

The caller supplies a Jira ticket ID (e.g. `TEST-123`). Validate the format: it must match `[A-Z]+-[0-9]+`. If the format is invalid, tell the user:

> "That doesn't look like a valid Jira ticket ID. Please provide an ID in the format `PROJECT-123`."

Then stop.

---

### 2. Fetch the Issue

Call `atlassian-rovo-mcp/getJiraIssue` with the supplied ticket ID.

If the call returns a 404 or "issue not found" error, stop and tell the user:

> "Ticket `<ID>` was not found. Please check the ID and try again."

---

### 3. Extract and Normalise Fields

From the response, extract the following. Where a field is absent, record it as `(not set)`.

| Field | Where to look |
|---|---|
| **Summary** | `fields.summary` |
| **Description** | `fields.description` (plain text or Atlassian Document Format — flatten to plain text) |
| **Acceptance Criteria** | Look in: description sections labelled "Acceptance Criteria", `customfield_*` fields, or child sub-tasks of type "Acceptance Criterion" |
| **Status** | `fields.status.name` |
| **Priority** | `fields.priority.name` |
| **Labels** | `fields.labels` (array) |
| **Components** | `fields.components[].name` |
| **Fix Version** | `fields.fixVersions[].name` |
| **Reporter** | `fields.reporter.displayName` |
| **Assignee** | `fields.assignee.displayName` (or "Unassigned") |
| **Linked Issues** | `fields.issuelinks` — list each link type and linked key |
| **Sub-tasks** | `fields.subtasks` — list each key and summary |

---

### 4. Fetch Linked Issues (if any)

If `fields.issuelinks` is non-empty, also call `atlassian-rovo-mcp/getJiraIssueRemoteIssueLinks` to capture any remote (external) links.

For each linked Jira issue that appears to be a **parent epic**, **blocker**, or **dependency**, fetch its summary too (single additional `getJiraIssue` call per linked issue, maximum 5 linked issues to avoid runaway calls).

---

### 5. Assess Acceptance Criteria Completeness

Apply the following rules:

- **Complete**: At least 2 numbered, testable statements are present and each contains a clear condition + expected outcome.
- **Partial**: Some criteria exist but are vague, non-testable, or incomplete (e.g. "should work correctly").
- **Missing**: No acceptance criteria found anywhere.

Return the assessment as one of: `complete` | `partial` | `missing`.

---

### 6. Return the Normalised Ticket Object

Produce a summary block in this format and pass it back to the calling workflow:

```
## Fetched Ticket: <TICKET-ID>

**Summary**: <summary>
**Status**: <status> | **Priority**: <priority>
**Reporter**: <reporter> | **Assignee**: <assignee>
**Labels**: <labels> | **Components**: <components> | **Fix Version**: <fix-version>

### Description
<description text, truncated to ~500 words if very long — note if truncated>

### Acceptance Criteria
<acceptance criteria text, or "(not set)">
**AC Assessment**: <complete | partial | missing>

### Linked Issues
<list of linked issue keys, summaries, and link types — or "(none)">

### Sub-tasks
<list of sub-task keys and summaries — or "(none)">
```

Then return control to the calling agent/workflow, passing the AC assessment so Step 4 (Grill Me) can be triggered if needed.
