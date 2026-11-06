---
name: list-sessions
description: List handoff sessions stored in the current repository and in the global sessions folder. Use when the user runs /list-sessions.
argument-hint: [local|global]
---

# List handoff sessions

Arguments: `$ARGUMENTS` (optional: `local` or `global`; default both).

1. Resolve the roots as in "Storage resolution" in [REFERENCE.md](../start-session/REFERENCE.md):
   - local: `<repo root>/.sessions/`
   - global: every folder under `<sessions home>/`, except `_templates`
2. Read each `INDEX.md`. Also list session folders that contain `HANDOFF.md` but are missing from the index, and mark them "not indexed".
3. Show one table per root: session, status, last update, summary.
4. Suggest `/resume-session <name>` for active sessions. Change nothing.
