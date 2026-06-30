#!/usr/bin/env bash
set -euo pipefail

ZSHRC="$HOME/.zshrc"

if grep -q 'alias zshconfig=' "$ZSHRC"; then
  echo "Aliases already present in $ZSHRC, skipping."
  exit 0
fi

cat >> "$ZSHRC" << 'EOF'

# --- custom aliases ---
alias zshconfig="vim $HOME/.zshrc"
alias rl="source $HOME/.zshrc"
alias git-prune-untracked='git fetch --prune && git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -D'
alias git-tag-date='git log --tags --simplify-by-decoration --pretty="format:%ci %d"'
alias copy="xsel -ib"
alias rsync="rsync -auh --info=progress2 --exclude '.venv' --exclude '__pycache__'"
alias cc="claude --continue"
EOF

echo "Appended aliases to $ZSHRC"
