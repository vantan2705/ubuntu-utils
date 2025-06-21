#!/bin/bash

set -e

APP_NAME="X-Getter"
APP_VERSION="1.4.8"
APPIMAGE_URL="https://github.com/xgetter-team/xgetter/releases/download/${APP_VERSION}/x-getter_${APP_VERSION}_amd64.AppImage"
INSTALL_DIR="$HOME/.local/apps/x-getter"
DESKTOP_FILE="$HOME/.local/share/applications/x-getter.desktop"
ICON_URL="https://xgetter.com/images/logo.png"
ICON_PATH="$INSTALL_DIR/icon.png"

echo "========== CÀI ĐẶT $APP_NAME =========="

# Bước 1: Tạo thư mục cài đặt
echo "[1/4] Tạo thư mục: $INSTALL_DIR"
mkdir -p "$INSTALL_DIR"

# Bước 2: Tải AppImage
echo "[2/4] Tải file AppImage từ GitHub..."
wget -O "$INSTALL_DIR/x-getter.AppImage" "$APPIMAGE_URL"
chmod +x "$INSTALL_DIR/x-getter.AppImage"

# Bước 3: Tải icon
echo "[3/4] Tải icon ứng dụng..."
wget -O "$ICON_PATH" "$ICON_URL"

# Bước 4: Tạo shortcut trên desktop và menu
echo "[4/4] Tạo file desktop shortcut..."
cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Name=X-Getter
Exec=$INSTALL_DIR/x-getter.AppImage
Icon=$ICON_PATH
Type=Application
Categories=Network;Video;
Comment=Download videos from the web easily
Terminal=false
EOF

chmod +x "$DESKTOP_FILE"

# Tùy chọn: Copy shortcut ra Desktop
cp "$DESKTOP_FILE" "$HOME/Desktop/"
chmod +x "$HOME/Desktop/x-getter.desktop"

echo "✅ Cài đặt hoàn tất! Bạn có thể mở '$APP_NAME' từ Menu hoặc Desktop."

