zmodload zsh/datetime

function preexec() {
  _cmd_start=$EPOCHREALTIME
}

function precmd() {
  if [[ -n $_cmd_start ]]; then
    local elapsed=$(( EPOCHREALTIME - _cmd_start ))
    local -i s=$(( elapsed ))
    local -i ms=$(( elapsed * 1000 % 1000 ))
    # ${(l:3::0:)ms} zero-pads in-shell; printf would fork on every prompt.
    RPROMPT="%F{cyan}${s}.${(l:3::0:)ms}s%f"
    unset _cmd_start
  else
    # No command ran (empty Enter, Ctrl-C) -- don't leave a stale duration pinned.
    RPROMPT=''
  fi
}
