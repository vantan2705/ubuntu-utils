#!/usr/bin/env bash

set -e

APP_NAME="tiktok-bulk-downloader"
VERSION="1.0.11"
APP_DIR="$HOME/AppImages"
APPIMAGE_NAME="tiktok-bulk-downloader-${VERSION}.AppImage"
APPIMAGE_PATH="$APP_DIR/$APPIMAGE_NAME"
DOWNLOAD_URL="https://github.com/minhchi1509/tiktok-bulk-downloader-desktop-app/releases/download/v${VERSION}/${APPIMAGE_NAME}"
DESKTOP_FILE="$HOME/.local/share/applications/tiktok-bulk-downloader.desktop"
ICON_PATH="$APP_DIR/tiktok-bulk-downloader.png"

echo "🚀 Installing TikTok Bulk Downloader $VERSION (AppImage)..."

# 1) Create AppImages directory
mkdir -p "$APP_DIR"

# 2) Download AppImage
if [ ! -f "$APPIMAGE_PATH" ]; then
  echo "⬇️  Downloading AppImage..."
  wget -O "$APPIMAGE_PATH" "$DOWNLOAD_URL"
else
  echo "✔ AppImage already exists"
fi

# 3) Make executable
chmod +x "$APPIMAGE_PATH"

# 4) Extract icon
echo "🎨 Extracting icon..."
cd "$APP_DIR"
./"$APPIMAGE_NAME" --appimage-extract > /dev/null || true

ICON_FOUND=false
for ICON_SOURCE in \
  squashfs-root/tiktok-bulk-downloader.png \
  squashfs-root/usr/share/icons/hicolor/256x256/apps/*.png \
  squashfs-root/usr/share/pixmaps/*.png
do
  if ls $ICON_SOURCE 1> /dev/null 2>&1; then
    cp $(ls $ICON_SOURCE | head -n1) "$ICON_PATH"
    ICON_FOUND=true
    break
  fi
done

if [ "$ICON_FOUND" = false ]; then
  echo "⚠️ Icon not found, using AppImage as fallback"
  ICON_PATH="$APPIMAGE_PATH"
fi

rm -rf squashfs-root

# 5) Detect WM_CLASS
echo "🔎 Detecting WM_CLASS (click on the app window)..."
"$APPIMAGE_PATH" &
sleep 3

WM_CLASS=$(xprop WM_CLASS | awk -F\" '{print $4}' | head -n1 || true)
echo "➡ Detected WM_CLASS: $WM_CLASS"

# 6) Create desktop shortcut
echo "🧩 Creating desktop shortcut..."
mkdir -p "$(dirname "$DESKTOP_FILE")"

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=TikTok Bulk Downloader
Comment=Bulk TikTok Video Downloader
Exec=$APPIMAGE_PATH
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Network;Utility;
StartupWMClass=$WM_CLASS
EOF

chmod +x "$DESKTOP_FILE"

echo "✅ Installation complete!"
echo "➡ TikTok Bulk Downloader is now available in your application menu."
