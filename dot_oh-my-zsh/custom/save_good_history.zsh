zshaddhistory() {
  emulate -L zsh
  # Check if the first word of the command exists as a valid executable, alias, or builtin
  whence ${${(z)1}[1]} >/dev/null 2>&1 || return 2
}
