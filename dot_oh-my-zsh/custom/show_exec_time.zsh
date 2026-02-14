zmodload zsh/datetime

function preexec() {
  _cmd_start=$EPOCHREALTIME
}

function precmd() {
  if [[ -n $_cmd_start ]]; then
    local elapsed=$(( EPOCHREALTIME - _cmd_start ))
    local -i s=$(( elapsed ))
    local -i ms=$(( elapsed * 1000 % 1000 ))
    RPROMPT="%F{cyan}${s}.$(printf '%03d' $ms)s%f"
    unset _cmd_start
  fi
}
