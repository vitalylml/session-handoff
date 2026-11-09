# Session handoff reference

Shared rules for `/start-session`, `/save-session`, `/resume-session`, `/list-sessions` and `/remove-session`.

## Storage resolution

Storage mode argument:

| Value | Root | Session folder |
|---|---|---|
| `local` (default) | `<repo root>/.sessions/` | `<root>/<session>/` |
| `global` | `<sessions home>/<repo name>/` | `<root>/<session>/` |
| `global:<group>` | `<sessions home>/<group>/` | `<root>/<session>/` |

- `<repo root>`: output of `git rev-parse --show-toplevel` in the current directory.
- `<repo name>`: the last folder name of `<repo root>`.
- `<sessions home>`: the `SESSIONS_HOME` environment variable if set, otherwise `~/.sessions` (`C:\Users\<user>\.sessions` on Windows).
- Outside a Git repository:
  - `local` falls back to `global`. Warn the user.
  - `global` without a group needs a group name. Ask for it.
- Work across several repositories: prefer `global:<group>`, and list every repository in `HANDOFF.md`.

## Files

| File | Holds |
|---|---|
| `HANDOFF.md` | Status, goal, context, decisions with reasons, current state, key files, constraints |
| `PLAN.md` | Work items with status (todo, in progress, done, dropped) and dependencies |
| `TASKS.md` | Open tasks only |
| `QUESTIONS.md` | Open questions only |
| `SECURITY.md` | Security rules and permissions, such as which repositories the agent may access |
| `<root>/INDEX.md` | One line per session: name, status, last update, summary |
| `<root>/_shared/` | Facts used by several sessions, such as constraints and a glossary |

## Content rules

- Record state and decisions, not a transcript. Keep each file short enough to read in a minute.
- Every decision has a reason. Every open task names what "done" looks like.
- When a task is finished: remove it from `TASKS.md` and mark the item done in `PLAN.md`.
- When a question is answered: remove it from `QUESTIONS.md` and add the answer to Decisions in `HANDOFF.md`.
- Current state lists, for each repository: path, branch, last commit (short hash and subject), and uncommitted files.
- Put facts that apply to several sessions in `_shared/` and link to them instead of copying.
- Never write secrets, tokens, passwords or personal data.
- Use absolute paths only where needed; the files may be copied to another machine.
- Never commit or push unless the user asks.
