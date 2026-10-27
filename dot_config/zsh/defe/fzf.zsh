# ---------------------------------------------------------
# fzf
# ---------------------------------------------------------
if (( $+commands[pbcopy] )); then
  fzf_copy_cmd="pbcopy"
else
  fzf_copy_cmd="xclip -selection clipboard"
fi

fzf_default_opts=(
  "--layout=reverse"
  "--info=inline"
  "--height=80%"
  "--multi"
  "--preview='cat {}'"
  "--preview-window=':hidden'"
  "--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'"
  "--prompt='∼ '"
  "--pointer='▶'"
  "--marker='✓'"
  "--bind '?:toggle-preview'"
  "--bind 'ctrl-a:select-all'"
  "--bind 'ctrl-e:execute(${EDITOR:-vim} {+} >/dev/tty)'"
  "--bind 'ctrl-v:execute(code {+})'"
  "--bind 'ctrl-y:execute-silent(echo {+} | ${fzf_copy_cmd})'"
)
export FZF_DEFAULT_OPTS="${(F)fzf_default_opts}"
unset fzf_default_opts fzf_copy_cmd

if (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"

  # Use fd for ** completion
  _fzf_compgen_path() {
    eval "$FZF_DEFAULT_COMMAND . \"$1\""
  }
  _fzf_compgen_dir() {
    eval "$FZF_ALT_C_COMMAND . \"$1\""
  }
fi

source <(fzf --zsh)
