# dotfiles
2022/07/07作成。
Ubuntu用のdotfile。chezmoi + sheldonで作成。

# Install
## 必要なソフト

```
sudo apt install zsh build-essential procps curl file git language-pack-ja -y
```
## homebrewのインストール

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### homebrewのパスを一時的に通す

```
if [[ -d '/home/linuxbrew/.linuxbrew' ]]; then
 HOMEBREW_HOME='/home/linuxbrew/.linuxbrew'
elif [[ -d '/opt/homebrew' ]]; then
 HOMEBREW_HOME='/opt/homebrew'
else
 HOMEBREW_HOME='/usr/local'
fi
eval "$($HOMEBREW_HOME/bin/brew shellenv)"
```

## chezmoi, sheldonなどのインストール

```
brew install chezmoi sheldon
```

## chezmoiを用いてdotfilesをcloneし適用

```
chezmoi init git@github.com:radiol/dotfiles.git && chezmoi apply -v
```
