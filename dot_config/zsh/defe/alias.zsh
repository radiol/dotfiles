# Change ls -> exa
alias ls="exa -F --group-directories-first --icons --git"
# Change rm -> trashy
if type trash > /dev/null;then
  alias rm=trash
fi

