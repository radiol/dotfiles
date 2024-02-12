# Change ls -> exa
alias ls="eza -F --group-directories-first --icons --git --time-style relative"

# Change rm -> trashy
if type trash > /dev/null;then
  alias rm=trash
fi

# clipboard
alias C=bp
