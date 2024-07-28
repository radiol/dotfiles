# ---------------------------------------------------------
# Zoxide
# ---------------------------------------------------------
eval "$(zoxide init zsh)"

function zoxide-widget() {
  zi
  zle reset-prompt
}

zle -N zoxide-widget
bindkey '^z' zoxide-widget
