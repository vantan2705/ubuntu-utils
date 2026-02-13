#!/usr/bin/env bash

set -e

APP_NAME="tinyRDM"
VERSION="1.2.6"
APP_DIR="$HOME/AppImages"
APPIMAGE_NAME="tiny-rdm_${VERSION}_linux_amd64.AppImage"
APPIMAGE_PATH="$APP_DIR/$APPIMAGE_NAME"
DOWNLOAD_URL="https://github.com/tiny-craft/tiny-rdm/releases/download/v${VERSION}/${APPIMAGE_NAME}"
DESKTOP_FILE="$HOME/.local/share/applications/tinyrdm.desktop"
ICON_PATH="$APP_DIR/tinyrdm.png"

echo "🚀 Installing $APP_NAME $VERSION..."

# 1. Create AppImages directory
mkdir -p "$APP_DIR"

# 2. Download AppImage
if [ ! -f "$APPIMAGE_PATH" ]; then
  echo "⬇️  Downloading AppImage..."
  wget -O "$APPIMAGE_PATH" "$DOWNLOAD_URL"
else
  echo "✔ AppImage already exists"
fi

# 3. Make executable
chmod +x "$APPIMAGE_PATH"

# 4. Extract icon
echo "🎨 Extracting icon..."
cd "$APP_DIR"
./"$APPIMAGE_NAME" --appimage-extract > /dev/null

ICON_SOURCE="squashfs-root/tiny-rdm.png"
if [ -f "$ICON_SOURCE" ]; then
  cp "$ICON_SOURCE" "$ICON_PATH"
else
  echo "⚠️ Icon not found, using AppImage icon fallback"
  ICON_PATH="$APPIMAGE_PATH"
fi

rm -rf squashfs-root

# 5. Create desktop shortcut
echo "🧩 Creating desktop shortcut..."
mkdir -p "$(dirname "$DESKTOP_FILE")"

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=Tiny Redis Desktop Manager
Comment=Redis GUI Client
Exec=$APPIMAGE_PATH
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Development;Database;
StartupWMClass=Tiny-rdm
EOF

chmod +x "$DESKTOP_FILE"

echo "✅ Installation complete!"
echo "➡ TinyRDM is now available in your application menu."
