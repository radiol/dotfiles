# Change ls -> eza
alias ls="eza -F --group-directories-first --icons --git --time-style relative"

# Change rm -> trashy
if type trash > /dev/null;then
  alias rm=trash
fi

# Change cp -> xcp
if type xcp > /dev/null;then
  alias cp=xcp
fi

# Chage cd -> z
if type zoxide > /dev/null;then
  alias cd=z
fi

# clipboard
alias C=bp
