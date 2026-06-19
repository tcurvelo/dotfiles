#!/bin/bash
set -euo pipefail

LOCAL="$HOME/notas"
REMOTE="notas:notas"

# Skip sync if Obsidian is running (avoids conflicts mid-write)
if pgrep -fi obsidian > /dev/null; then
    echo "Obsidian is running — skipping sync."
    exit 0
fi

mkdir -p "$HOME/.local/state"

rclone bisync "$LOCAL" "$REMOTE" \
    --conflict-resolve newer \
    --conflict-suffix conflict \
    --max-delete 25 \
    --log-file "$HOME/.local/state/rclone-obsidian.log" \
    --log-level INFO