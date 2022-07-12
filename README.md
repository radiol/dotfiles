# dotfiles
2022/07/07作成。
Mac, Ubuntu共用のdotfile。chezmoi + sheldonで作成。
homebrewを利用。

# Install
Linuxでzshやja_JP.UTF-8が入っていない場合、インストールする
```
sudo apt install zsh language-pack-ja -y
```

```
/bin/bash -c "$(curl -fsSL HEAD/install.sh)"
```
git@github.com:radiol/dotfiles.gitは各自のリポジトリに変更
```
chezmoi init git@github.com:radiol/dotfiles.git && chezmoi apply -v
```

## install.shで行なっていること
### homebrewのインストール

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

### chezmoi, sheldonなどのインストール

```
brew install chezmoi sheldon
```

### chezmoiを用いてdotfilesをcloneし適用

```
chezmoi init git@github.com:radiol/dotfiles.git && chezmoi apply -v
```

# Update
## dotfilesの設定変更

### dotfilesの編集(.zshrcの場合)
編集だけでは設定に反映されない

```
chezmoi edit .zshrc
```

### 変更の反映

```
chezmoi apply -v
```

## remote(GitHub)の変更をlocalに適用

```
chezmoi update -v
```

## localの変更をGitHubへpush

```
chezmoi git -- add -A
chezmoi git -- commit
chezmoi git -- push origin main
``
