#!/bin/bash
set -e

VERSION="2025.3.2"
INSTALL_DIR="/opt/intellij"
TAR_NAME="idea-$VERSION.tar.gz"
DOWNLOAD_URL="https://download.jetbrains.com/idea/$TAR_NAME"
BIN_LINK="/usr/local/bin/idea"
DESKTOP_FILE="$HOME/.local/share/applications/intellij-idea.desktop"

echo "⬇️ Downloading IntelliJ IDEA $VERSION..."
wget -q $DOWNLOAD_URL

echo "📦 Extracting..."
sudo mkdir -p $INSTALL_DIR
sudo tar -xzf $TAR_NAME -C $INSTALL_DIR

echo "🧹 Cleaning up..."
rm $TAR_NAME

IDEA_DIR=$(ls -d $INSTALL_DIR/idea-* | head -n 1)

echo "🔗 Creating symlink..."
sudo ln -sf "$IDEA_DIR/bin/idea.sh" $BIN_LINK

echo "🖥️ Creating desktop entry..."
sudo tee $DESKTOP_FILE > /dev/null <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA
Comment=Java IDE
Exec=$BIN_LINK
Icon=$IDEA_DIR/bin/idea.svg
Terminal=false
Categories=Development;IDE;
StartupWMClass=jetbrains-idea
EOF

echo "🔄 Updating desktop database..."
sudo update-desktop-database >/dev/null 2>&1 || true

echo "✅ Installation completed!"
echo "👉 Run from terminal: idea"
echo "👉 Or search 'IntelliJ IDEA' in Applications menu"
