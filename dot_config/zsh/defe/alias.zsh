# Change ls -> exa
alias ls="eza -F --group-directories-first --icons --git --time-style relative"

# Change rm -> trashy
if type trash > /dev/null;then
  alias rm=trash
fi

# clipboard
# X11, Wayland, macOSの環境判定とそれぞれのalias設定
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    alias C='pbcopy'
    alias V='pbpaste'
elif [[ -n $WAYLAND_DISPLAY ]]; then
    # Wayland
    alias C='wl-copy'
    alias V='wl-paste'
elif [[ -n $DISPLAY ]]; then
    # X11
    alias C='xclip -selection clipboard'
    alias V='xclip -selection clipboard -o'
else
    echo "Unsupported clipboard environment."
fi
