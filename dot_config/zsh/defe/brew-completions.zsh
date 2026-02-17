if type brew &>/dev/null
then
  FPATH="$HOMEBREW_HOME/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi
