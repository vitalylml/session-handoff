---
name: add-repository
description: Add a repository to the current handoff session (Current state table in HANDOFF.md) and read its agent instruction files. Use when the user runs /add-repository.
argument-hint: <repository-path> [session-name]
---

# Add a repository to a handoff session

Arguments: `$ARGUMENTS`

- First argument: path to the repository. Required. If it is missing, ask for it.
- Second argument: session name. Default: the session started or resumed in this conversation. If there is none, stop and ask for the name, or suggest `/resume-session` first.

## 1. Locate the session

Use the current session, or locate the named one as in step 1 of [resume-session](../resume-session/SKILL.md).

## 2. Check the repository

- Resolve the path to the repository root with `git -C <path> rev-parse --show-toplevel`. If the path does not exist or is not a Git repository, stop and tell the user.
- If the repository is already in the Current state table of `HANDOFF.md`, tell the user and go to step 4 only.

## 3. Add it to HANDOFF.md

Collect the state of the repository:

- `git -C <repo> branch --show-current`
- `git -C <repo> log -1 --format="%h %s"`
- `git -C <repo> status --short`

Add one row to the Current state table: repository name, path, branch, last commit, uncommitted files. Update Last update. Do not change other rows.

## 4. Read its agent files

Follow "Agent files" in [REFERENCE.md](../start-session/REFERENCE.md). Follow the instructions found for work in that repository for the rest of the conversation.

## 5. Report

- Report the row added and the agent files read.
- Remind the user that these files are read as text only: the repository's settings, permissions and hooks do not apply. See "Known issues" in the README.
- Do not commit.
