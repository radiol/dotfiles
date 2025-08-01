# ---------------------------------------------------------
# cd ghq repo with fzf
# ---------------------------------------------------------
function _fzf_cd_ghq() {
    FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --reverse --height=50%"
    local root="$(ghq root)"
    local repo="$(ghq list | fzf --preview="ls -AF --color=always ${root}/{1}")"
    local dir="${root}/${repo}"
    [ -n "${repo}" ] && [ -n "${dir}" ] && cd "${dir}"
    zle reset-prompt
}

zle -N _fzf_cd_ghq
# keubind: Ctrl+]
bindkey "^]" _fzf_cd_ghq
