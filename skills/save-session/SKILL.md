---
name: save-session
description: Save the current state of a handoff session into its HANDOFF.md, PLAN.md, TASKS.md and QUESTIONS.md. Use when the user runs /save-session.
argument-hint: [session-name] [local|global[:group]]
---

# Save a handoff session

Arguments: `$ARGUMENTS`

- Session name: the argument if given; otherwise the session started or resumed earlier in this conversation. If neither exists, propose a name and ask for confirmation.
- Storage mode: `local` (default), `global` or `global:<group>`. If the session was started or resumed in this conversation and no mode is given, keep its location.

## 1. Resolve the session folder

Follow "Storage resolution" in [REFERENCE.md](../start-session/REFERENCE.md).

If the folder does not exist, create it as `/start-session` does, using the templates in [../start-session/templates](../start-session/templates/).

## 2. Read before writing

Read the existing `HANDOFF.md`, `PLAN.md`, `TASKS.md` and `QUESTIONS.md`. Update them; never rewrite earlier decisions away.

## 3. Collect the current state

For each repository involved, run:

- `git rev-parse --show-toplevel`
- `git branch --show-current`
- `git log -1 --format="%h %s"`
- `git status --short`

## 4. Update the files

Follow "Content rules" in [REFERENCE.md](../start-session/REFERENCE.md):

- `HANDOFF.md`: Last update, Context, Decisions, Current state, Key files.
- `PLAN.md`: statuses; add new items.
- `TASKS.md`: remove finished tasks; add new ones.
- `QUESTIONS.md`: remove answered questions (their answers go to Decisions); add new ones.
- Move facts that apply to other sessions into `<root>/_shared/`.
- Update this session's line in `<root>/INDEX.md`.

## 5. Report

List the files changed and the main changes. Do not commit unless the user asks.
