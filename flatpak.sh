#!/bin/bash

# Cập nhật hệ thống
echo "==> Cập nhật danh sách gói..."
sudo apt update -y

# Cài đặt Flatpak
echo "==> Cài đặt Flatpak..."
sudo apt install -y flatpak

# Cài đặt plugin GNOME Software (nếu dùng GNOME, Ubuntu mặc định có)
echo "==> Cài đặt plugin GNOME cho Flatpak (nếu dùng GNOME)..."
sudo apt install -y gnome-software-plugin-flatpak

# Thêm Flathub repository
echo "==> Thêm Flathub vào danh sách Flatpak repo..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Thông báo hoàn tất
echo "✅ Cài đặt Flatpak và Flathub thành công!"
echo "👉 Bạn có thể cài app ví dụ: flatpak install flathub org.mozilla.Firefox"
