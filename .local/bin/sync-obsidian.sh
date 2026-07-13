#!/bin/bash
set -euo pipefail

LOCAL="$HOME/notas"
REMOTE="notas:notas"

if pgrep -i obsidian > /dev/null; then
    echo "Obsidian is running — skipping sync."
    exit 0
fi

mkdir -p "$HOME/.local/state"

RESYNC_FLAG=()
if [ ! -d "$LOCAL" ]; then
    echo "First run on this host — doing an initial --resync."
    mkdir -p "$LOCAL"
    RESYNC_FLAG=(--resync)
fi

rclone bisync "$LOCAL" "$REMOTE" \
    "${RESYNC_FLAG[@]}" \
    --conflict-resolve newer \
    --conflict-suffix conflict \
    --max-delete 25 \
    --log-file "$HOME/.local/state/rclone-obsidian.log" \
    --log-level INFO
