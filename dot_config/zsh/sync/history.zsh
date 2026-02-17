export HISTFILE="$XDG_STATE_HOME/zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_reduce_blanks
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt EXTENDED_HISTORY
zshaddhistory() {
    local line="${1%%$'\n'}"
    [[ ! "$line" =~ "^(cd|la|ll|ls|rmdir|exit)($| )" ]]
}
# enable substring search(up, down)
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
