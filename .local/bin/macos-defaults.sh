#!/usr/bin/env bash
#
# macos-defaults.sh — apply/export macOS preferences (cfprefsd, no ~/.config here)
# Usage: ./macos-defaults.sh {apply|export}

set -euo pipefail

HOTKEYS_PLIST="${HOME}/.macos-defaults/com.apple.symbolichotkeys.plist"

apply() {
    echo "==> Dock autohide"
    defaults write com.apple.dock autohide -bool true

    echo "==> Importing symbolichotkeys"
    if [[ -f "${HOTKEYS_PLIST}" ]]; then
        defaults import com.apple.symbolichotkeys "${HOTKEYS_PLIST}"  # full replace of the domain
    else
        echo "    Skipped: ${HOTKEYS_PLIST} not found"
    fi

    killall Dock || true
    killall SystemUIServer || true
    echo "Done."
}

export_settings() {
    defaults export com.apple.symbolichotkeys "${HOTKEYS_PLIST}"  # writes binary plist
    plutil -convert xml1 "${HOTKEYS_PLIST}"                       # convert to XML for readable diffs
    echo "Exported to ${HOTKEYS_PLIST}"
}

case "${1:-}" in
    apply)
        apply
        ;;
    export)
        export_settings
        ;;
    *)
        echo "Usage: $0 {apply|export}"
        exit 1
        ;;
esac