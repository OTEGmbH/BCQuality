# Skill: Verify MCP Connectivity

**Purpose**: Confirm that all MCP servers required by Jira Hero are reachable and authenticated before any work begins. Call this skill at the very start of any session.

---

## Instructions

### 1. Check Atlassian / Jira MCP

Call `atlassian-rovo-mcp/atlassianUserInfo` with no arguments.

**If the call succeeds**: Note the display name and account ID returned. Continue to step 2.

**If the call fails or returns an error**:
> Stop immediately and tell the user:
> "The Atlassian/Jira MCP server is not running or not authenticated. Please start the MCP server and ensure your Atlassian credentials are configured, then try again."

Do **not** proceed further.

---

### 2. Check GitHub MCP

Call `github-pull-request_doSearch` with a minimal, harmless query (e.g. `repo:microsoft/AL is:issue state:open`).

**If the call succeeds** (even zero results): Continue to step 3.

**If the call fails or returns an error**:
> Stop immediately and tell the user:
> "The GitHub MCP server is not running or not authenticated. Please start the MCP server and ensure your GitHub credentials are configured, then try again."

Do **not** proceed further.

---

### 3. Report Status

When both checks pass, briefly confirm to the user:

> "MCP connectivity verified: Atlassian ✓ · GitHub ✓. Proceeding…"

Then return control to the calling agent/workflow.

---

## Error Reference

| Symptom | Likely Cause | Suggested Fix |
|---|---|---|
| `atlassianUserInfo` times out | MCP server not started | Run the Atlassian Rovo MCP server locally or via Docker |
| `atlassianUserInfo` returns 401 | Token expired or missing | Re-authenticate via `atlassian-rovo-mcp` configuration |
| `github-pull-request_doSearch` times out | GitHub MCP extension not loaded | Reload VS Code window; ensure the GitHub Pull Requests extension is active |
| `github-pull-request_doSearch` returns 403 | GitHub token lacks permissions | Generate a new PAT with `repo` and `read:org` scopes |
