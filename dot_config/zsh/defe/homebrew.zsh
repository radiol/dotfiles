# Check OS and set brew path
if [[ -d '/home/linuxbrew/.linuxbrew' ]]; then
    # Linux/WSL
    HOMEBREW_HOME='/home/linuxbrew/.linuxbrew'
elif [[ -d '/opt/homebrew' ]]; then
    # M1 Mac
    HOMEBREW_HOME='/opt/homebrew'
else
    # Intel Mac
    HOMEBREW_HOME='/usr/local'
fi

if type $HOMEBREW_HOME/bin/brew >/dev/null; then
    eval "$($HOMEBREW_HOME/bin/brew shellenv)"
fi

# Completion
FPATH="$HOMEBREW_HOME/share/zsh/site-functions:${FPATH}"
