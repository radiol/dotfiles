# Color config
export CLICOLOR=1
# Change dircolor blue -> cyan
# For Mac
export LSCOLORS=gxfxcxdxbxegedabagacad
# For Linux
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
## Enable LSCOLORS to completion
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
