setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS

zshaddhistory() {
  emulate -L zsh
  # Check if the first word of the command exists as a valid executable, alias, or builtin
  whence ${${(z)1}[1]} >/dev/null 2>&1 || return 2
}
