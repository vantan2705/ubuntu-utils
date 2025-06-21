#!/bin/bash

# Script for macOS-like appearance on Linux Mint Cinnamon

set -e

echo "=============================="
echo " CÀI GIAO DIỆN MAC OS CHO LINUX MINT"
echo "=============================="
sleep 2

# Cập nhật hệ thống
echo "[1/7] Đang cập nhật hệ thống..."
sudo apt update && sudo apt upgrade -y

# Cài Plank (Dock giống macOS)
#echo "[2/7] Cài đặt Plank..."
#sudo apt install plank -y

# Tải theme macOS GTK và icon
echo "[3/7] Tải và cài đặt theme macOS..."
mkdir -p ~/.themes ~/.icons ~/macos-setup
cd ~/macos-setup

# GTK theme (WhiteSur)
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme
./install.sh -t all

cd ..

# Icon theme
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
cd WhiteSur-icon-theme
./install.sh -t all
cd ..

# Cài font San Francisco
#echo "[4/7] Cài đặt font San Francisco..."
#git clone https://github.com/supermarin/YosemiteSanFranciscoFont.git
#mkdir -p ~/.fonts
#cp YosemiteSanFranciscoFont/*.ttf ~/.fonts/
#fc-cache -fv

# Tùy chỉnh Plank
#echo "[5/7] Tùy chỉnh Plank..."
#mkdir -p ~/.config/plank/dock1/launchers
#cat <<EOF > ~/.config/autostart/plank.desktop
#[Desktop Entry]
#Type=Application
#Exec=plank
#Hidden=false
#NoDisplay=false
#X-GNOME-Autostart-enabled=true
#Name=Plank
#EOF

# Tùy chỉnh Cinnamon Theme (sẽ cần người dùng chỉnh tay phần này sau)
echo "[6/7] Gợi ý cấu hình thủ công:"
echo "- Vào Cài đặt hệ thống > Giao diện:"
echo "  * Giao diện: WhiteSur-dark"
echo "  * Biểu tượng: WhiteSur"
#echo "  * Phông chữ: San Francisco"
echo "- Khởi động Plank từ menu hoặc khởi động lại máy."

# Hoàn tất
echo "[7/7] Hoàn tất cài đặt! Hệ thống sẵn sàng với giao diện giống macOS!"

