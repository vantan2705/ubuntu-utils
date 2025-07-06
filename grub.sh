#!/bin/bash

# Cập nhật gói & cài đặt grub-customizer từ PPA

set -e  # Thoát nếu có lỗi

echo "👉 Thêm PPA grub-customizer..."
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer

echo "🔄 Cập nhật danh sách gói..."
sudo apt-get update

echo "⬇️ Cài đặt grub-customizer..."
sudo apt-get install -y grub-customizer

echo "✅ Hoàn tất! Bạn có thể mở grub-customizer từ menu hoặc bằng lệnh 'grub-customizer'"
