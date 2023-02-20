# For macOS <-> Ubuntu compatibility

# Get operating system
platform="unknown"
mac="darwin"
linux="linux"
unamestr=$(uname)
if [[ $unamestr == "Darwin" ]]; then
  platform=mac
elif [[ $unamestr == "Linux" ]]; then
  platform=linux
fi

# dircolors(Ubuntu) <-> gdircolors(macOS)
if [[ $platform == mac ]]; then
  alias dircolors="gdircolors"
fi

