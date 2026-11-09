---
name: resume-session
description: Resume a handoff session from its HANDOFF.md, PLAN.md, TASKS.md and QUESTIONS.md, from the current repository, the global sessions folder, or any path the files were copied to. Use when the user runs /resume-session.
argument-hint: <session-name | path-to-session-folder>
---

# Resume a handoff session

Arguments: `$ARGUMENTS`

## 1. Locate the session

Check in this order (see "Storage resolution" in [REFERENCE.md](../start-session/REFERENCE.md)):

1. The argument is a path to a folder containing `HANDOFF.md`: use it.
2. `<repo root>/.sessions/<name>/`.
3. `<sessions home>/<repo name>/<name>/`.
4. `<sessions home>/*/<name>/`.

- If several match, list them and ask which one.
- If none match or no argument is given, list the sessions from every `INDEX.md` found and ask.

## 2. Read

Read `HANDOFF.md`, `PLAN.md`, `TASKS.md`, `QUESTIONS.md`, `SECURITY.md`, and `../_shared/*` if present. Follow the rules in `SECURITY.md` for the rest of the session.

## 3. Verify

The files may have been copied from another location or machine. Treat recorded paths, branches and commits as hints:

- Check each recorded repository: does the path exist, is the branch the same, is the last commit the same, are the uncommitted files the same?
- Report every difference. Do not change branches or files to match the record.

## 4. Summarize

Tell the user:

- Goal and status.
- Current state, with the differences found.
- The next open tasks from `TASKS.md`.
- The open questions from `QUESTIONS.md`.

## 5. Continue

- Remember the session name and folder for later `/save-session` calls.
- Ask before starting work, unless the user said to continue.
