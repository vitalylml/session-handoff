---
name: remove-session
description: Remove a handoff session folder and its line in INDEX.md. Without an argument, removes the session started or resumed in this conversation. Use when the user runs /remove-session.
argument-hint: [session-name | path-to-session-folder]
---

# Remove a handoff session

Arguments: `$ARGUMENTS`

## 1. Choose the session

- Argument given: locate the session as in step 1 of [resume-session](../resume-session/SKILL.md). If several match, list them and ask which one.
- No argument, and a session was started or resumed in this conversation: use that session.
- No argument and no current session: stop. Tell the user a session name is required and suggest `/list-sessions`.

## 2. Confirm

- Show the session name, folder path and the files it holds.
- Removal cannot be undone (unless the folder is tracked by Git). Ask the user to confirm, and wait for a clear yes.

## 3. Remove

- Delete the session folder and everything in it.
- Remove the session's line from `<root>/INDEX.md`.
- Never delete `INDEX.md`, `_shared/`, or other sessions.

## 4. Report

- Report the removed folder and the change to `INDEX.md`.
- If it was the current session, forget it, so `/save-session` does not recreate it.
- Do not commit unless the user asks.
