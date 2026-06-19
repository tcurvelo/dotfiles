---
name: jira-ticket
description: Use when asked to fetch, inspect, summarize, evaluate, or work from a Jira issue key or Atlassian browse URL. Retrieves compact read-only ticket context through a local jira-ticket-digest command or a narrow Atlassian CLI fallback before doing repository work.
---

# Jira Ticket

Use this skill for Jira ticket retrieval and ticket-driven work.

## Contract

The preferred local command is:

```bash
jira-ticket-digest ISSUE-KEY
```

It should print Markdown with YAML front matter, followed by a heading whose text is the issue title. The digest should include the issue key, title, type, status, priority, assignee, reporter, labels, dates, description, comments, subtasks, and links when available.

## Workflow

1. Extract the issue key from the request. For browse URLs, use the issue key after `/browse/`.
2. Run `jira-ticket-digest ISSUE-KEY`.
3. Treat the Markdown digest as the primary context for reasoning.
4. If the user asks for implementation, review, or code analysis, read the ticket digest before inspecting repository files.
5. Keep Jira access read-only by default.

## Retrieval Rules

- Prefer `jira-ticket-digest ISSUE-KEY` over raw Jira JSON.
- Do not request every field unless debugging field names or explicitly asked for raw Jira data.
- If extra fields are needed, set `JIRA_TICKET_DIGEST_FIELDS` with a narrow comma-separated allowlist.
- If `jira-ticket-digest` is unavailable, use a narrow Atlassian CLI fallback:

  ```bash
  acli jira workitem view ISSUE-KEY --fields key,issuetype,summary,status,assignee,reporter,priority,labels,created,updated,description,comment,parent,subtasks,issuelinks --json
  ```

  Convert the result into a compact digest before reasoning over it.

## Writing rich text (ADF)

Only when explicitly asked to edit a description or add a comment.

`acli` accepts the body as **plain text or Atlassian Document Format (ADF)** — it
does **not** interpret Jira wiki markup (`h2.`, `||`, `{{}}`) or Markdown. Pasting
those leaves literal characters in the field. To render rich text (headings, tables,
code, lists), supply an ADF JSON document via the `--*-file` flag.

1. Build an ADF `doc` and write it to a temp JSON file. Skeleton:

   ```json
   {
     "version": 1,
     "type": "doc",
     "content": [
       { "type": "heading", "attrs": { "level": 3 }, "content": [ { "type": "text", "text": "Title" } ] },
       { "type": "paragraph", "content": [
         { "type": "text", "text": "Bold lead: ", "marks": [{ "type": "strong" }] },
         { "type": "text", "text": "and " },
         { "type": "text", "text": "inline-code", "marks": [{ "type": "code" }] }
       ] }
     ]
   }
   ```

   Common nodes: `heading` (`attrs.level` 1–6), `paragraph`, `bulletList`/`orderedList`
   → `listItem` → `paragraph`, `codeBlock` (`attrs.language`), and tables
   (`table` → `tableRow` → `tableHeader`/`tableCell` → `paragraph`). Inline `marks`:
   `strong`, `em`, `code`, `link` (`attrs.href`).

2. Validate the JSON before sending: `python3 -m json.tool file.json >/dev/null`.

3. Apply it:

   ```bash
   # Description (replaces existing — read it first if you might clobber content)
   acli jira workitem edit --key ISSUE-KEY --description-file file.json --yes

   # Comment (appends; does not touch the description)
   acli jira workitem comment create --key ISSUE-KEY --body-file file.json
   ```

4. Delete the temp file afterward.

`acli ... view` flattens ADF to plain text in the terminal, so it is not a reliable
render check — confirm formatting in the Jira web UI.

## Safety

- Do not assign, transition, edit, comment, archive, delete, or otherwise mutate Jira issues unless explicitly asked.
- If authentication fails, ask the user to authenticate the local Jira CLI and verify that the token belongs to the same account email used for login.
- Never ask the user to paste API tokens or secrets into chat.
- Do not print raw Jira JSON unless it is directly relevant to debugging.
