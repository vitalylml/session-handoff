#!/usr/bin/env sh
# Installs the session handoff skills for Claude Code (user level) and creates the global sessions folder.
# Usage: sh install.sh [--uninstall]
set -eu

skills="start-session save-session resume-session list-sessions"
source_dir="$(cd "$(dirname "$0")" && pwd)/skills"
target="$HOME/.claude/skills"
sessions_home="${SESSIONS_HOME:-$HOME/.sessions}"

if [ "${1:-}" = "--uninstall" ]; then
    for s in $skills; do
        if [ -d "$target/$s" ]; then rm -rf "$target/$s"; echo "Removed $target/$s"; fi
    done
    echo "Sessions in $sessions_home were kept."
    exit 0
fi

mkdir -p "$target"
for s in $skills; do
    rm -rf "$target/$s"
    cp -R "$source_dir/$s" "$target/$s"
    echo "Installed $target/$s"
done

mkdir -p "$sessions_home"
echo "Global sessions folder: $sessions_home"
echo "Start a new Claude Code session to use /start-session, /save-session, /resume-session and /list-sessions."
