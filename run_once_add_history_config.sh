#!/usr/bin/env bash
set -euo pipefail

FILE="${1:-$HOME/.zshrc}"
MARKER="# HISTORY CONFIG"

if [[ ! -f "$FILE" ]]; then
    echo "Error: file not found: $FILE" >&2
    exit 1
fi

if ! grep -qF "$MARKER" "$FILE"; then
    echo "Error: marker '$MARKER' not found in $FILE" >&2
    exit 1
fi

# Avoid duplicating if the options are already there right after the marker
if grep -A4 -F "$MARKER" "$FILE" | grep -q "HIST_IGNORE_ALL_DUPS"; then
    echo "Options already present after marker, skipping."
    exit 0
fi

# Backup before modifying
cp "$FILE" "${FILE}.bak.beforeHist"

# Insert the four lines right after the marker line
TMP="$(mktemp)"
awk -v marker="$MARKER" '
    { print }
    $0 ~ marker {
        print "setopt HIST_IGNORE_ALL_DUPS"
        print "setopt HIST_IGNORE_SPACE"
        print "setopt HIST_REDUCE_BLANKS"
        print "setopt HIST_SAVE_NO_DUPS"
    }
' "$FILE" > "$TMP"

mv "$TMP" "$FILE"
echo "Inserted history options after '$MARKER' in $FILE"
