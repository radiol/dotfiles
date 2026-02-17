# Change ls -> eza
alias ls="eza -F --group-directories-first --icons --git --time-style relative"

# Change rm -> gomi
if type gomi &>/dev/null;then
  alias rm=gomi
fi

# Change cp -> xcp
if type xcp &>/dev/null;then
  alias cp=xcp
fi

# Change cd -> z
if type zoxide &>/dev/null;then
  alias cd=z
fi

# clipboard
alias C=bp

# Aliases for warp
# edit alias
alias ae="chezmoi edit $XDG_CONFIG_HOME/zsh/defe/alias.zsh"
# edit abbr
alias abe="chezmoi edit $XDG_CONFIG_HOME/zsh/abbreviations"
#edit sheldon plugins.toml
alias se="chezmoi edit $XDG_CONFIG_HOME/sheldon/plugins.toml"

# base command
# ls is replaced by eza
alias la="ls -a"
alias ll="ls -alh"
alias lt="ls -a -T -L 3 -I '.git'"
alias llt="ls -alh -T -L 3 -I '.git'"

# grep set color
alias grep="grep --color=auto"

# chezmoi
alias cup="chezmoi update -v"
alias ca="chezmoi apply -v"
alias ce="chezmoi edit"
alias ccd="cd $(chezmoi source-path)"
alias cga="chezmoi git -- add -A"
alias cgd="chezmoi git diff -v HEAD"
alias cgc="chezmoi git -- commit"
alias cgp="chezmoi git -- push origin main"
alias cpush="chezmoi git -- add -A && chezmoi git -- commit -v && chezmoi git -- push origin main"

# git
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gc="git commit -v"
alias gco="git checkout"
alias gcm="git checkout main"
alias gd="git diff"
alias gf="git fetch"
alias gp="git push"
alias gpl="git pull"
alias gpo="git pull origin"
alias gpom="git pull origin main"
alias gpu="git pull upstream"
alias gpum="git pull upstream main"
alias gs="git status"

# lazygit
alias lg="lazygit"

# Docker
alias dcl="docker container ls"
alias dcp="docker container prune"
alias ds="docker stop"
alias dsall="docker stop $(docker ps -q)"
alias drm="docker rm"
alias drmall="docker rm $(docker ps -a -q)"
alias di="docker images"
alias dip="docker images prune"
alias drmi="docker rmi"
alias drmiall="docker rmi $(docker images -q)"
alias dcu="docker compose up"
alias dcud="docker compose up -d"
alias dcd="docker compose down"
alias dcr="docker compose restart"
alias dlog="docker compose logs"

# Homebrew
alias brewu="brew update && brew upgrade && brew cleanup && brew doctor"

# Atcoder-cli
alias accs="acc s main.py -- --guess-python-interpreter pypy"
alias acct="uv run oj t -c 'python3 main.py' -d ./tests/"
alias accft="uv run black main.py && uv run ruff --fix main.py && uv run oj t -c 'python3 main.py' -d ./tests/"
# alias accn="(){acc new $1 && cd $1}"
accn() {
  acc new "$1" &&
  cd "$1"
}

# Cargo-compete
# alias ccn="(){cargo compete new $1 && cargo member i $1 && cd $1}"
ccn() {
  cargo compete new "$1" &&
  cargo member i "$1" &&
  git add -A &&
  git commit -m "Add $1" &&
  cd "$1"
}
alias cct="cargo compete test"
# alias ccs="cargo compete submit"
ccs() {
  cargo compete test "$1" &&
  cat "src/bin/$1.rs" | C &&
  echo "Copied $1.rs to clipboard"
}

# Neovim
alias v="nvim"
alias lv="NVIM_APPNAME=lazyvim nvim"

# Wezterm
alias wc="wezterm connect"
