---
name: pr-description
description: Generate a PR description for the current branch. Use when the user asks to create, write, or generate a PR description.
argument-hint: [base-branch (default: develop)]
allowed-tools: Bash(git:*)
---

# PR Description Skill

Generate a pull request description for the current branch compared to a base branch.

The base branch defaults to `develop` unless specified via `$ARGUMENTS`.

## Steps

1. Determine the current branch name:
   ```
   git rev-parse --abbrev-ref HEAD
   ```

2. Extract the Jira ticket from the branch name. The ticket is the prefix before the first `/` (e.g., `ABC-123` from `ABC-123/some_feature`).

3. Get the diff and commit log against the base branch:
   ```
   git log --oneline <base>..HEAD
   git diff <base>...HEAD
   ```

4. Analyze the changes and generate the PR description following the template below.

5. Write the result to `/tmp/pr-description.md` so the user can easily copy it.

## Template

```markdown
# <TICKET>: <Short descriptive title>

## Summary

[<TICKET>](https://wiki-tucows.atlassian.net/browse/<TICKET>)

<1-2 sentence summary of what this PR does and why.>

## Changes

<Concise bullet list. Focus on the "what" and "why", not low-level details visible in the diff.>

```

## Guidelines

- Keep the title short (under 70 characters excluding the ticket prefix).
- The Summary should be concise and informative.
- Changes bullets should be high-level. Don't repeat details already visible in the diff (e.g., don't list specific permission names if the bullet says "add permissions").
