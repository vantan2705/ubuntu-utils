#!/bin/bash
set -e

FLUTTER_VERSION="3.13.9"
INSTALL_DIR="$HOME/flutter"
PROFILE_FILE="$HOME/.bashrc"  # Đổi thành ~/.zshrc nếu bạn dùng zsh

echo "📦 Cài đặt các gói phụ thuộc..."
sudo apt update
sudo apt install -y curl git unzip xz-utils libglu1-mesa

echo "🌐 Tải Flutter $FLUTTER_VERSION..."
cd /tmp
curl -LO "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

echo "📂 Giải nén Flutter vào $INSTALL_DIR..."
rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
tar -xf "flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" -C "$HOME"

echo "🔧 Thêm Flutter vào PATH trong $PROFILE_FILE..."
if ! grep -q 'export PATH="$HOME/flutter/bin:$PATH"' "$PROFILE_FILE"; then
  echo 'export PATH="$HOME/flutter/bin:$PATH"' >> "$PROFILE_FILE"
  echo "✅ Đã thêm Flutter vào PATH."
else
  echo "⚠️ PATH đã tồn tại trong $PROFILE_FILE."
fi

echo "🔄 Tải thông tin các công cụ Flutter..."
export PATH="$HOME/flutter/bin:$PATH"
flutter doctor

echo "✅ Cài đặt Flutter $FLUTTER_VERSION hoàn tất. Hãy mở terminal mới hoặc chạy: source $PROFILE_FILE"
