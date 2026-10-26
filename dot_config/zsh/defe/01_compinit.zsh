# ---------------------------------------------------------
# Completion
# ---------------------------------------------------------
# Reuse the dump with -C for speed, but rebuild it once a day so that
# newly added completion functions are picked up
# Must run after 00_homebrew.zsh (adds fpath) and before files that call
# compdef (e.g. zoxide.zsh)
() {
  local dump="$ZDOTDIR/.zcompdump"
  local fresh=($dump(N.mh-24))

  autoload -Uz compinit
  if (( $#fresh )); then
    compinit -C -d "$dump"
  else
    compinit -d "$dump"
    # compinit leaves the dump untouched when nothing changed
    touch "$dump"
  fi
}
