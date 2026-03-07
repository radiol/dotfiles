#!/bin/bash -xeu
echo "::group::UDEV Gothic Font"
echo "Installing Udev Gothic Fonts"

USER_NAME="yuru7"
REPO_NAME="udev-gothic"

RELEASE_INFO=$(curl -s https://api.github.com/repos/"$USER_NAME/$REPO_NAME"/releases/latest)
ASSET_URL_HS=$(echo "$RELEASE_INFO" | jq -r '.assets[] | select(.name | contains("UDEVGothic_HS")).browser_download_url')
ASSET_URL_NF=$(echo "$RELEASE_INFO" | jq -r '.assets[] | select(.name | contains("UDEVGothic_NF")).browser_download_url')

# OS別フォントディレクトリ
if [[ "$(uname)" == "Darwin" ]]; then
  FONT_DIR="$HOME/Library/Fonts"
  mkdir -p "$FONT_DIR"
  SUDO=""
else
  FONT_DIR="/usr/share/fonts"
  SUDO="sudo"
fi

echo "Downloading UDEV Gothic HS"
curl -LJ "$ASSET_URL_HS" -o "UDEV_Gothic_HS.zip"
$SUDO unzip -o "UDEV_Gothic_HS.zip" -d "$FONT_DIR/"
rm "UDEV_Gothic_HS.zip"

echo "Downloading UDEV Gothic NF"
curl -LJ "$ASSET_URL_NF" -o "UDEV_Gothic_NF.zip"
$SUDO unzip -o "UDEV_Gothic_NF.zip" -d "$FONT_DIR/"
rm "UDEV_Gothic_NF.zip"

# フォントキャッシュ更新 (Linux only)
if [[ "$(uname)" != "Darwin" ]]; then
  fc-cache -fv
fi

echo "::endgroup::"