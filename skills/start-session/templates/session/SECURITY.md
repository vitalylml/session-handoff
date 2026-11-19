# Security and permissions

Rules for any agent or person working on this session.

## Session files

- The agent may always read and write the files of this session: the folder that holds this file, and `INDEX.md` and `_shared/` in its parent storage root.
- This applies wherever the session is stored (local `.sessions/`, the global sessions folder, or a copied path). The session folder is never listed in the Current state table and is never added with `/add-repository`.

## Repository access

- The agent working on this session may read, write and execute files in every repository listed in the Current state table of [HANDOFF.md](HANDOFF.md).
- This access covers only those repositories. Do not read, change or run anything in other repositories without asking the user.
- To work in a new repository, ask the user first, then add it with `/add-repository` (or add a row to the Current state table).

## Limits

- Access to a repository does not allow commits, pushes, branch changes or other changes to remote systems. Ask the user first.
- Never write secrets, tokens, passwords or personal data to the session files.
