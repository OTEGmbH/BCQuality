# Skill: Investigate Codebase

**Purpose**: Systematically explore the customer's GitHub repository to find all objects relevant to a Jira ticket. Returns a verified list of file paths, object names, existing implementations, and the object ID range. Call this skill after resolving the customer repo (Step 3 of Jira Hero).

---

## Inputs

- `repo`: The primary repository in `owner/repo` format.
- `ticket-id`: The Jira ticket ID (used to find existing work tagged with that ID in comments).
- `keywords`: Key terms from the ticket summary and description (object names, field names, business concepts).

---

## Instructions

### Phase 1 — Find Existing Work for This Ticket

Search for code already committed for this ticket:

```
github_text_search(scope=repo, query="<TICKET-ID>")
```

If results are found, read those files first — they establish the baseline for the spec. Note the file paths, procedure names, and the exact code block boundaries (`START`/`STOP` comment markers if OTE convention is used).

---

### Phase 2 — Find the App ID Range

Search for `app.json`:

```
github_text_search(scope=repo, query="idRanges path:app.json")
```

If that returns empty, try:

```
github_text_search(scope=repo, query="\"idRanges\"")
```

Extract:
- The `from` and `to` of the ID range in use.
- The app `name`, `publisher`, and `version`.

Record these for use in the specification's Metadata and Affected Objects sections.

---

### Phase 3 — Find Objects Mentioned in the Ticket

For each keyword extracted from the ticket summary/description, run targeted searches. Use **single-concept queries** — GitHub code search fails with long OR chains.

Useful search patterns:
- `github_text_search(scope=repo, query="<TableName>")` — find where a table is used
- `github_text_search(scope=repo, query="<FieldName>")` — find field references
- `github_text_search(scope=repo, query="<BusinessConcept>")` — e.g. `payment method`, `zahlungsmethode`

> **Important**: If a search returns `ERROR: Code search lexical search failed`, the query is too complex. Simplify to a single term and retry. Do not use `OR`, `AND`, or special characters in the query string.

For each result, note:
- File path
- Object type and name (inferred from the file name or surrounding code)
- Relevance to the ticket

---

### Phase 4 — Read the Key Files

**Preferred approach — GitHub MCP** (`get_file_contents`):
If the GitHub MCP server is running (check: MCP tools with prefix `mcp_github_` or similar are available), use `get_file_contents` to read full files by path. This is far more reliable than search excerpts.

```
get_file_contents(owner=<owner>, repo=<repo>, path=<file-path>)
```

**Fallback — GitKraken MCP** (`mcp_gitkraken_cli_repository_get_file_content`):
If available, use this to read a file by path from a known repo.

**Fallback — VS Code extension search** (`github_text_search`):
If neither MCP is available, search for distinctive procedure or variable names unique to the file to retrieve excerpts. Combine multiple searches to reconstruct the relevant sections.

> **Note**: The VS Code `github_text_search` / `github_repo` tools are extension-based and do **not** provide full file reads. They also fail with complex queries (OR chains, special characters). Use single-term queries only when falling back to these tools.

Focus on reading:
1. The file containing existing ticket work (Phase 1 results).
2. The codeunit or page most directly affected by the change.
3. Any subscriber/event pattern files that hook into the same flow.

Do **not** read every file — stop when you have enough to describe the affected objects and their current behaviour.

---

### Phase 5 — Return the Codebase Investigation Summary

Produce a block in this format:

```
## Codebase Investigation: <REPO>

### App Info
- ID Range: <from>–<to>
- Version: <version>

### Existing Work for <TICKET-ID>
- File: `<path>`
- Procedure/Block: <name or description>
- Status: <partial / complete / broken — based on what was found>

### Affected Objects
| File Path | Object Type | Object Name | Notes |
|---|---|---|---|
| `<path>` | Codeunit | `<name>` | <what it does relevant to ticket> |

### Key Patterns Observed
- <Pattern 1 — e.g. "OTE uses START/STOP comment markers with ticket ID and date">
- <Pattern 2 — e.g. "Payment method is set via SalesHeader.Validate() inside an event subscriber">
- <Pattern 3 — e.g. "Tags are queried from Shpfy Tag table filtered by Parent Table No. + Parent Id">

### Search Dead-Ends (for future reference)
- <Query that failed and why — helps avoid repeating them>
```

Then return control to the calling agent/workflow.
