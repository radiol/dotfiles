#!/bin/bash -xeu

# ---------------------------------------------------------
# Install Udev Gothic Font
# ---------------------------------------------------------
echo "::group::UDEV Gothic Font"

echo "Installing Udev Gothic Fonts"
USER_NAME="yuru7"
REPO_NAME="udev-gothic"

# リリース情報を取得し、必要なアセットのURLを取得
RELEASE_INFO=$(curl -s https://api.github.com/repos/"$USER_NAME/$REPO_NAME"/releases/latest)

# UDEV Gothic HSとUDEV Gothic NFのアセットURLを取得
ASSET_URL_HS=$(echo "$RELEASE_INFO" | jq -r '.assets[] | select(.name | contains("UDEVGothic_HS")).browser_download_url')
ASSET_URL_NF=$(echo "$RELEASE_INFO" | jq -r '.assets[] | select(.name | contains("UDEVGothic_NF")).browser_download_url')

# UDEV Gothic HSをダウンロードしてインストール
echo "Downloading UDEV Gothic HS"
curl -LJ "$ASSET_URL_HS" -o "UDEV_Gothic_HS.zip"
sudo unzip -o "UDEV_Gothic_HS.zip" -d /usr/share/fonts/
rm "UDEV_Gothic_HS.zip"

# UDEV Gothic NFをダウンロードしてインストール
echo "Downloading UDEV Gothic NF"
curl -LJ "$ASSET_URL_NF" -o "UDEV_Gothic_NF.zip"
sudo unzip -o "UDEV_Gothic_NF.zip" -d /usr/share/fonts/
rm "UDEV_Gothic_NF.zip"

echo "::endgroup::"
