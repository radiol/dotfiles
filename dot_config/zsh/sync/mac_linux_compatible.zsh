# For macOS <-> Ubuntu compatibility

# Get operating system
platform="unknown"
unamestr=$(uname)
if [[ $unamestr == "Linux" ]]; then
    platform="linux"
elif [[ $unamestr == "Darwin" ]]; then
    platform="darwin"
fi

# dircolors(Ubuntu) <-> gdircolors(macOS)
if [[ $platform == "darwin" ]]; then
    alias dircolors="gdircolors"
fi

