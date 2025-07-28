# ---------------------------------------------------------
# cd with fzf
# ---------------------------------------------------------
function zd() {
  local dir
  dir=$(fd --hidden --type directory --exclude .git . ${1:-.} | fzf --reverse --height=50%)
  [ -n "$dir" ] && cd "$dir"
}
