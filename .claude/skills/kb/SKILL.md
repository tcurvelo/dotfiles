---
name: kb
description: Save distilled knowledge from an agent conversation into the user's Obsidian vault, or recall/search what's already in it. Use when asked to save, archive, or write conversation knowledge to notes/vault/Obsidian, or to look up, recall, or check existing notes on a topic.
allowed-tools: Bash(obsidian:*), Read, Write, Edit
---

# kb

Read and write access to the user's personal Obsidian vault. Structural lookups (folder taxonomy, search, delete) go through the `obsidian` CLI, which talks to the running Obsidian app over its local control socket. Note _content_ is read and written directly on disk with the Read/Write/Edit tools — the CLI's `create`/`append` round-trip through the app is noticeably slower for writes, and Obsidian picks up external file changes into its search index immediately, so there's no correctness cost to writing directly once you're pointed at the real vault path. Two workflows: **save** (distill this conversation into a note) and **recall** (search existing notes to answer a question).

## Preconditions

- Requires the Obsidian app to be running (the CLI connects to `~/.obsidian-cli.sock`). If a command fails because the app isn't running, tell the user to open Obsidian and retry.
- When running from Codex, Obsidian CLI commands must be executed outside the sandbox because the sandbox can see `~/.obsidian-cli.sock` but cannot connect to the running app through that local control socket. The failure mode is misleading: `obsidian` prints "The CLI is unable to find Obsidian" even when Obsidian is open. For read-only structural commands (`vault info=path`, `folders`, `search`, `search:context`, `files`), rerun with sandbox escalation and a narrowly scoped read-only `prefix_rule` such as `["obsidian", "vault"]`, `["obsidian", "folders"]`, `["obsidian", "search"]`, `["obsidian", "search:context"]`, or `["obsidian", "files"]`. Never request a broad `["obsidian"]` prefix because `obsidian delete` is destructive.
- Always resolve it fresh with `obsidian vault info=path` at the start of a save/recall, then build note paths by joining that root with the relative path (e.g. `<root>/knowledge/Foo.md`). If obsidian-cli isn't available, try falling back to `$OBSIDIAN_VAULT`. Missing intermediate folders are created automatically by the Write tool, so this is safe even for a brand-new subfolder.
- Run `obsidian --help` if a command's exact flags are unclear; don't guess at flags not seen in `--help`.

## Key commands

- `obsidian vault info=path` — resolve the live vault root. Run this once per save/recall, don't cache it across sessions.
- `obsidian folders` — list the full folder taxonomy (live, can change over time — don't hardcode it).
- `obsidian search query="<text>" limit=<n>` — full-text search, returns matching file paths.
- `obsidian search:context query="<text>"` — search with matching line context.
- `obsidian files folder=<path>` — list files in a folder.
- `obsidian delete path="<...>"` — moves to Obsidian's trash (recoverable). Keep deletions on the CLI even though writes bypass it — the trash safety net is worth the round-trip, and deletions aren't the slow/frequent operation writes are.

For reading and writing note _content_, use the Read/Write/Edit tools directly against `<vault_root>/<relative path>`:

- **New note**: Write directly to `<vault_root>/<folder>/<Title>.md`.
- **Append to an existing note**: Read the file in full, then Write the full content back with `\n\n## Heading\n<new content>` appended — this mirrors what the CLI's `append` did internally (leading blank line, new heading starts a clean section).

## Save workflow

Triggered by: "save this to my vault/notes", "archive this conversation", "add this to obsidian", `/kb save`, etc.

1. **Scope**: default to distilling the whole conversation so far, unless the user points at a specific portion or topic.
2. **Distill, don't transcribe**: extract decisions, facts, gotchas, learnings, useful code idioms. Skip tool-call noise, dead ends, and small talk. Match the vault's existing terse style — short bullets/paragraphs, no fluff, no YAML frontmatter (the vault doesn't use it).
3. **Classify destination** — run `obsidian vault info=path` and `obsidian folders` first to get the live root and current structure, then:
   - **Project-specific** knowledge (tied to a specific side project or work initiative) → the matching subfolder under `projects/`). Match against existing subfolder names. If it's ambiguous which project or subfolder, ask the user rather than guessing.
   - **General/reusable** knowledge (not tied to one project) → `knowledge/`, in a matching topic subfolder if one already exists (e.g. `knowledge/Go`, `knowledge/Python`), otherwise directly under `knowledge/`.
4. **Check for an existing note** on the same topic before creating a new file: `obsidian search query="<topic>"` and/or `obsidian files folder=<candidate folder>`. If a clear match exists, plan to append a new section to it instead of creating a duplicate. Otherwise plan a new file named `<Title Case Name>.md` following the naming style of sibling notes in that folder.
5. **Match language** to sibling notes in the target folder (this vault mixes Portuguese and English by topic — technical notes skew English, personal/career notes skew Portuguese).
6. **Preview before writing**: show the user the destination path and the drafted note content, and get a go-ahead (or edits) before writing. This is the user's personal vault outside the current project — don't write silently.
7. Write with the Read/Write/Edit tools against `<vault_root>/<relative path>` (see "Key commands" above for new-file vs. append mechanics).
8. Confirm the path written.

## Recall workflow

Triggered by: "what do I know about X", "check my notes on Y", "have I written about Z before", `/kb recall <topic>`, etc.

1. `obsidian search query="<topic>"` (add `search:context` if you need surrounding lines to judge relevance before reading full files).
2. Resolve the vault root (`obsidian vault info=path`) and Read the best-matching note(s) in full directly from `<vault_root>/<match>`.
3. Answer the user's question grounded in what the notes actually say, citing the file path(s) used.
4. If nothing relevant is found, say so directly — don't fabricate or fall back to general knowledge without flagging that it isn't from their vault.

## Safety

- Never delete or overwrite existing note content without explicit confirmation. Prefer appending a new section.
- This is a private personal vault — don't quote or forward its contents outside the conversation unless asked.
