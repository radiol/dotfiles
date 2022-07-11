export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
zshaddhistory() {
    local line="${1%%$'\n'}"
    [[ ! "$line" =~ "^(cd|jj?|lazygit|la|ll|ls|rm|rmdir|exit)($| )" ]]
}
# enable prefix match
bindkey ${key[Up]} history-beginning-search-backward
bindkey ${key[Down]} history-beginning-search-forward
