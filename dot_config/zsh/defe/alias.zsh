# Change ls -> eza
alias ls="eza -F --group-directories-first --icons --git --time-style relative"

# Change rm -> gomi
if type gomi &>/dev/null; then
  alias rm=gomi
fi

# Change cp -> xcp
if type xcp &>/dev/null; then
  alias cp=xcp
fi

# Change cd -> z
if type zoxide &>/dev/null; then
  alias cd=z
fi

# clipboard
alias C=bp

# gopass
if type gopass &>/dev/null; then
  if type aicommit2 &>/dev/null; then
    alias ac2='OPENAI_API_KEY=$(gopass show -o api/openai/api_key) ANTHROPIC_API_KEY=$(gopass show -o api/anthropic/api_key) aicommit2'
  fi
fi
