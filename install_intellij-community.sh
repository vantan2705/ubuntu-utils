#!/bin/bash
set -e

VERSION="2024.1.1"
INSTALL_DIR="/opt/intellij-idea-community"

echo "📦 Cài đặt các gói cần thiết..."
sudo apt update
sudo apt install -y curl tar openjdk-17-jdk

echo "🌐 Tải IntelliJ IDEA Community $VERSION..."
cd /tmp
curl -L -o idea.tar.gz "https://download.jetbrains.com/idea/ideaIC-$VERSION.tar.gz"

echo "📂 Giải nén vào $INSTALL_DIR..."
sudo mkdir -p "$INSTALL_DIR"
sudo tar -xzf idea.tar.gz --strip-components=1 -C "$INSTALL_DIR"

echo "🔗 Tạo symlink để chạy IntelliJ từ terminal..."
sudo ln -sf "$INSTALL_DIR/bin/idea.sh" /usr/local/bin/intellij

echo "🖥️ Tạo shortcut trên desktop..."
cat <<EOF | sudo tee /usr/share/applications/intellij-idea-community.desktop > /dev/null
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA Community
Icon=$INSTALL_DIR/bin/idea.png
Exec="$INSTALL_DIR/bin/idea.sh" %f
Comment=JetBrains IntelliJ IDEA Community Edition
Categories=Development;IDE;
Terminal=false
StartupNotify=true
EOF

echo "✅ Hoàn tất! Bạn có thể chạy bằng lệnh 'intellij' hoặc tìm trong menu ứng dụng."
