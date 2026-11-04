export HISTFILE="$XDG_STATE_HOME/zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_reduce_blanks
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt EXTENDED_HISTORY
zshaddhistory() {
    local line="${1%%$'\n'}"
    [[ "$line" =~ "^(cd|la|ll|ls|rmdir|exit)($| )" ]] && return 1
    # Keep it in memory only for now and save it in precmd unless the
    # command was not found, so typos do not pile up in HISTFILE
    _last_history_line="$line"
    return 2
}

_save_history_unless_not_found() {
    local exit_status=$?
    if [[ -n "$_last_history_line" && $exit_status -ne 127 ]]; then
        print -sr -- "$_last_history_line"
    fi
    _last_history_line=
}
# Put it first so that $? is still the exit status of the command
precmd_functions=(_save_history_unless_not_found $precmd_functions)
# Search history by prefix up to the cursor (up, down)
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
