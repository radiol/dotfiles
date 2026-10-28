# ---------------------------------------------------------
# Carapace
# ---------------------------------------------------------
# Must run after 01_compinit.zsh because carapace registers completers
# with compdef
if (( $+commands[carapace] )); then
  # Fall back to existing zsh completion functions (e.g. _mise) for
  # commands carapace does not know
  export CARAPACE_BRIDGES='zsh'
  zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
  source <(carapace _carapace zsh)
fi
