# Recolor the current Ghostty pane's background while SSH'd into a
# prod/uat/dev host (per ~/.ssh/config), restoring it on exit. No new
# tab or window: Ghostty (unlike Ptyxis) honors OSC 11 background
# changes live in-pane. Colors match the Prod/Uat/Dev Ptyxis palettes'
# dark-mode background: prod = red, uat = yellow, dev = light blue.
# Only active inside Ghostty (checks $GHOSTTY_RESOURCES_DIR); falls
# through to upstream ssh() everywhere else (plain ssh, or Ghostty's own
# ssh-env/ssh-terminfo wrapper if that's what upstream turns out to be).
typeset -gA GHOSTTY_ENV_BG=(
    prod '#3A0000'
    uat  '#4A3B00'
    dev  '#00293A'
)

_ghostty_configured_bg() {
    local bg
    bg=$(ghostty +show-config 2>/dev/null | awk -F' = ' '/^background = /{print $2; exit}')
    print -r -- "${bg:-#000000}"
}

# Ghostty's own zsh integration (ssh-env/ssh-terminfo features) doesn't
# define its ssh() synchronously in .zshenv — it defers that to a precmd
# hook that fires on the *first prompt*, which always runs after this file
# has already been sourced from .zshrc. So defining ssh() once here isn't
# enough: Ghostty's deferred hook would clobber it a moment later. Instead,
# (re)apply our wrapper both now and from our own precmd hook, positioned
# to run after Ghostty's so we always wrap whatever it ends up installing.
_ghostty_ssh_env_apply() {
    # $_ghostty_ssh_env_marker is an exact snapshot of the ssh() body we
    # last installed. If the live ssh() no longer matches it, something
    # else (Ghostty's deferred init) has replaced it since — capture that
    # as our new upstream. Comparing by snapshot instead of grepping for
    # an identifier keeps this correct even if the function body changes.
    if (( $+functions[ssh] )) && [[ "$functions[ssh]" != "$_ghostty_ssh_env_marker" ]]; then
        functions[_ghostty_ssh_env_upstream]=$functions[ssh]
    elif ! (( $+functions[_ghostty_ssh_env_upstream] )); then
        _ghostty_ssh_env_upstream() { command ssh "$@" }
    fi

    ssh() {
        emulate -L zsh
        setopt local_options no_glob_subst

        if [[ -z $GHOSTTY_RESOURCES_DIR ]]; then
            _ghostty_ssh_env_upstream "$@"
            return
        fi

        local ssh_config="$HOME/.ssh/config"
        local -A host_env
        if [[ -r "$ssh_config" ]]; then
            local line
            for line in "${(@f)$(awk '/^[Hh]ost / {for (i=2;i<=NF;i++) print $i}' "$ssh_config")}"; do
                if [[ $line == *prod* ]]; then
                    host_env[$line]=prod
                elif [[ $line == *uat* ]]; then
                    host_env[$line]=uat
                elif [[ $line == *dev* ]]; then
                    host_env[$line]=dev
                fi
            done
        fi

        local env="" arg
        for arg in "$@"; do
            if [[ -n ${host_env[$arg]} ]]; then
                env=${host_env[$arg]}
                break
            fi
        done

        if [[ -z $env ]]; then
            _ghostty_ssh_env_upstream "$@"
            return
        fi

        local orig_bg="$(_ghostty_configured_bg)"
        print -n "\e]11;${GHOSTTY_ENV_BG[$env]}\a"
        {
            _ghostty_ssh_env_upstream "$@"
        } always {
            print -n "\e]11;${orig_bg}\a"
        }
    }

    typeset -g _ghostty_ssh_env_marker=$functions[ssh]
}

_ghostty_ssh_env_apply

_ghostty_ssh_env_precmd_once() {
    _ghostty_ssh_env_apply
    precmd_functions=(${precmd_functions:#_ghostty_ssh_env_precmd_once})
}
typeset -ag precmd_functions
if (( ! ${precmd_functions[(Ie)_ghostty_ssh_env_precmd_once]} )); then
    precmd_functions+=(_ghostty_ssh_env_precmd_once)
fi
