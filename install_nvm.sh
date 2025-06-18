#!/bin/bash

set -e

echo "🔄 Cập nhật APT..."
sudo apt update -y

echo "💡 Kiểm tra curl..."
sudo apt install -y curl

echo "⬇️ Tải và cài đặt NVM..."
export NVM_VERSION="v0.40.3"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash

# Load NVM vào current shell (cả với bash hoặc zsh)
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "✅ NVM đã được cài đặt!"

echo "⬇️ Cài đặt Node.js 22.x..."
nvm install 22

echo "✅ Node.js 22 đã được cài!"

echo "🎯 Đặt Node.js 22 làm mặc định..."
nvm alias default 22

echo "🧪 Kiểm tra phiên bản Node và NPM:"
node -v
npm -v

echo "🎉 Hoàn tất! Node.js 22 đã được thiết lập làm mặc định!"
