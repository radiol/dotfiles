#!/bin/bash -xeu

# ---------------------------------------------------------
# Install Udev Gothic Font
# ---------------------------------------------------------
echo "Installing Udev Gothic Font"
# GitHub リポジトリのユーザー名、リポジトリ名、およびリリースタグを指定
USER_NAME="yuru7"
REPO_NAME="udev-gothic"
ZIP_FILE="font.zip"

# リリース情報を取得
RELEASE_INFO=$(curl -s https://api.github.com/repos/"$USER_NAME/$REPO_NAME"/releases/latest)

# 最新のリリースアセットのURL
ASSET_URL=$(echo "$RELEASE_INFO" | jq -r '.assets[0].browser_download_url')

# curl を使用してリリースアセットをダウンロード
curl -LJ "$ASSET_URL" -o "$ZIP_FILE"

# Extract to /usr/share/fonts/
sudo unzip -o "$ZIP_FILE" -d /usr/share/fonts/

# Delete zip file
rm "$ZIP_FILE"
