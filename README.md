# Session handoff

A small framework that keeps the state of agent work in Markdown files, so that any agent, on any machine, can resume it later.

It provides four Claude Code commands and a set of templates. Other agents can use the same files by following [AGENTS.md.snippet](AGENTS.md.snippet).

## Commands

| Command | What it does |
|---|---|
| `/start-session <name> [local\|global[:group]]` | Creates a session from the templates and fills it from the conversation so far. Never overwrites an existing session. |
| `/save-session [name] [local\|global[:group]]` | Updates the session files with the current state. The default storage is `local`. |
| `/resume-session <name\|path>` | Finds a session (path, local, then global), checks the recorded state against the repositories, and summarizes it. |
| `/list-sessions [local\|global]` | Lists local and global sessions. |
| `/remove-session [name]` | Removes a session after confirmation. Without a name, removes the current session. |

## Storage

| Mode | Session folder |
|---|---|
| `local` (default) | `<repo root>/.sessions/<session>/` |
| `global` | `<sessions home>/<repo name>/<session>/` |
| `global:<group>` | `<sessions home>/<group>/<session>/` |

- `<sessions home>` is `SESSIONS_HOME` if set, otherwise `~/.sessions` (`C:\Users\<user>\.sessions` on Windows).
- Use `global:<group>` for work that spans several repositories.
- For local sessions, either commit `.sessions/` to share them, or add it to `.gitignore` to keep them private.

Each storage root holds:

```text
INDEX.md                 one line per session
_shared/
  CONSTRAINTS.md         rules common to all sessions
  GLOSSARY.md            shared terms
<session>/
  HANDOFF.md             status, goal, context, decisions, current state, key files
  PLAN.md                work items with status and dependencies
  TASKS.md               open tasks only
  QUESTIONS.md           open questions only
  SECURITY.md            security rules and permissions
```

Rules are in [skills/start-session/REFERENCE.md](skills/start-session/REFERENCE.md).

## Install

### Option 1: clone and install

Windows:

```bash
git clone <repo-url> session-handoff
powershell -NoProfile -ExecutionPolicy Bypass -File session-handoff/install.ps1
```

macOS and Linux:

```bash
git clone <repo-url> session-handoff
sh session-handoff/install.sh
```

- The script copies the skills to `~/.claude/skills/` and creates the global sessions folder.
- Run it again after `git pull` to update. Use `-Uninstall` or `--uninstall` to remove the skills; sessions are kept.
- Start a new Claude Code session afterwards.

### Option 2: Claude Code plugin

This repository is also a plugin marketplace. In Claude Code:

```text
/plugin marketplace add <owner>/session-handoff
/plugin install session-handoff@session-handoff
```

Plugin commands may be shown with a namespace, for example `/session-handoff:save-session`.

### Other agents

Copy [AGENTS.md.snippet](AGENTS.md.snippet) into the repository's `AGENTS.md` or `CLAUDE.md`.

## Typical use

```text
/start-session eve-evaluation global:eve
... work ...
/save-session
```

Later, in any repository or on another machine where the files were copied:

```text
/resume-session eve-evaluation
/resume-session D:/backup/sessions/eve/eve-evaluation
```

## Layout of this repository

```text
skills/
  start-session/
    SKILL.md
    REFERENCE.md         shared rules used by all commands
    templates/           INDEX.md, _shared/, session/
  save-session/SKILL.md
  resume-session/SKILL.md
  list-sessions/SKILL.md
  remove-session/SKILL.md
.claude-plugin/          plugin and marketplace manifests
install.ps1, install.sh
AGENTS.md.snippet
```

The skills refer to each other through `../start-session/`, so install all five together.
