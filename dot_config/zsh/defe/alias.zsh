# Change ls -> exa
alias ls="exa -F --group-directories-first --icons --git"

# Change rm -> trashy
if type trash > /dev/null;then
  alias rm=trash
fi

# clipboard
if ! (type "pbcopy" > /dev/null 2>&1); then
  alias C="pbcopy"
  alias V="pbpaste"
elif ! (type "xsel" > /dev/null 2>&1); then
  alias C="xsel -bi"
  alias V="xsel -b"
fi


