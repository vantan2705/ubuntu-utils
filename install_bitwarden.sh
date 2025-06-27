#!/bin/bash
set -e

APP_NAME="Bitwarden"
APP_DIR="/opt/bitwarden"
APPIMAGE_NAME="Bitwarden.AppImage"
APPIMAGE_URL="https://vault.bitwarden.com/download/?app=desktop&platform=linux"
ICON_URL="https://raw.githubusercontent.com/bitwarden/brand/main/icons/icon.svg"
ICON_PATH="$APP_DIR/bitwarden.svg"
APPIMAGE_PATH="$APP_DIR/$APPIMAGE_NAME"
DESKTOP_FILE="/usr/share/applications/bitwarden.desktop"

echo "📦 Đang cài đặt $APP_NAME vào $APP_DIR..."

# Tạo thư mục cài đặt
sudo mkdir -p "$APP_DIR"

# Tải AppImage
echo "⬇️ Đang tải AppImage..."
sudo wget -qO "$APPIMAGE_PATH" "$APPIMAGE_URL"
sudo chmod +x "$APPIMAGE_PATH"

# Tải icon SVG
echo "🎨 Đang tải icon SVG..."
sudo wget -qO "$ICON_PATH" "$ICON_URL"

# Tạo shortcut ứng dụng
echo "🖥️ Tạo file .desktop..."
sudo tee "$DESKTOP_FILE" > /dev/null <<EOF
[Desktop Entry]
Name=Bitwarden
Comment=Secure and free password manager for all of your devices
Exec=$APPIMAGE_PATH
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Utility;Security;
EOF

# Cập nhật cache icon nếu cần
sudo update-desktop-database

echo "✅ Bitwarden đã được cài đặt! Tìm trong menu hoặc chạy: $APPIMAGE_PATH"
