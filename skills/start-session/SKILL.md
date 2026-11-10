---
name: start-session
description: Start tracking the current work as a handoff session (HANDOFF.md, PLAN.md, TASKS.md, QUESTIONS.md) that any agent can resume later. Use when the user runs /start-session.
argument-hint: <session-name> [local|global[:group]]
---

# Start a handoff session

Arguments: `$ARGUMENTS`

- First argument: session name. Convert it to kebab-case. If it is missing, propose a name from the conversation and use it.
- Second argument: storage mode. Default `local`.

## 1. Resolve the session folder

Follow "Storage resolution" in [REFERENCE.md](REFERENCE.md).

## 2. Refuse to overwrite

If `<session folder>/HANDOFF.md` already exists, stop. Tell the user the session exists and suggest `/resume-session <name>` or `/save-session`.

## 3. Create the files

- Create the root `INDEX.md` and `_shared/` from [templates](templates/) if they are missing. Never overwrite existing ones.
- Create the session folder with `HANDOFF.md`, `PLAN.md`, `TASKS.md`, `QUESTIONS.md` and `SECURITY.md` from [templates/session](templates/session/).
- Replace the placeholders: `{{name}}`, `{{date}}` (today, ISO), `{{mode}}`, `{{repos}}`.
- `{{repos}}`: one row for the repository the agent was started in, if it is a Git repository; otherwise leave the table empty. Do not add other repositories; the user adds them with `/add-repository`. The agent already loaded this repository's agent files at startup.

## 4. Fill from the conversation

If the conversation already contains work, fill the files now, following "Content rules" in [REFERENCE.md](REFERENCE.md). Do not invent facts; leave a section with "None yet" when there is nothing to record.

## 5. Register and report

- Add one line for this session to the root `INDEX.md`.
- Remember the session name, mode and folder for the rest of the conversation, so `/save-session` can reuse them.
- Report the folder path and the files written. Suggest `/add-repository <path>` for other repositories the work needs. Do not commit.
