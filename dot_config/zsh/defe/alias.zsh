# Change ls -> exa
alias ls="exa -F --group-directories-first --icons --git"

# Change rm -> trashy
# X11, Wayland, macOSの環境判定とそれぞれのalias設定
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    alias C='pbcopy'
    alias C_paste='pbpaste'
elif [[ -n $WAYLAND_DISPLAY ]]; then
    # Wayland
    alias C='wl-copy'
    alias C_paste='wl-paste'
elif [[ -n $DISPLAY ]]; then
    # X11
    alias C='xclip -selection clipboard'
    alias C_paste='xclip -selection clipboard -o'
else
    echo "Unsupported clipboard environment."
fi
