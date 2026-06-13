# Skill: Resolve Customer and Repository

**Purpose**: Given a Jira project code (the prefix before the hyphen in a ticket ID), look up the customer entry in `customers.md` and return the customer name, repository list, BC version, and app prefix. Call this skill immediately after fetching the Jira ticket.

---

## Instructions

### 1. Read `customers.md`

Read the file `customers.md` from the workspace root. It contains one entry per customer. Each entry has at minimum:
- A project code (e.g. `VIT`, `TEST`)
- One or more GitHub repository URLs or `owner/repo` references
- Optionally: BC version, app prefix, notes

If the file is missing, stop and tell the user:
> "customers.md not found in the workspace root. Please create it before running Jira Hero."

---

### 2. Match the Project Code

Extract the project code from the ticket ID (everything before the first `-`). Search `customers.md` for an entry whose project code matches (case-insensitive).

**If no match is found**, stop and ask the user:
> "No entry for project code `<CODE>` found in customers.md. Which customer and GitHub repository should I use?"

---

### 3. Extract Repository References

From the matched entry, collect all GitHub repository references. Normalise each to `owner/repo` format:
- `https://github.com/owner/repo` → `owner/repo`
- `https://github.com/owner/repo/tree/branch/path` → `owner/repo` (strip branch/path)

If the entry lists multiple repos, treat the **first** as the primary extension repo and any others as reference repos (e.g. MS base app forks or upstream sources).

---

### 4. Return the Resolved Customer Object

Produce a block in this format and pass it back to the calling workflow:

```
## Resolved Customer for <PROJECT-CODE>

**Customer Name**: <name>
**Primary Repository**: `<owner/repo>`
**Additional Repos**: <list or "(none)">
**BC Version**: <version or "(not specified — use copilot-instructions-ote.md default)">
**App Prefix**: <prefix or "(not specified — use copilot-instructions-ote.md default)">
**Notes**: <any extra notes from customers.md>
```

Then return control to the calling agent/workflow.
