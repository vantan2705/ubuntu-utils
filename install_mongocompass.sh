#!/bin/bash
set -e

echo "📦 Bắt đầu cài đặt MongoDB Compass..."

# Chọn phiên bản Ubuntu tương ứng để lấy gói đúng
UBUNTU_CODENAME=$(lsb_release -cs)
DEB_URL="https://downloads.mongodb.com/compass/mongodb-compass_1.42.6_amd64.deb"

echo "⬇️ Tải MongoDB Compass (.deb)..."
wget -O mongodb-compass.deb "$DEB_URL"

echo "💾 Cài đặt gói MongoDB Compass..."
sudo apt install -y ./mongodb-compass.deb

echo "🧹 Xoá file tạm..."
rm mongodb-compass.deb

echo "✅ MongoDB Compass đã được cài đặt!"
echo "🚀 Bạn có thể mở bằng lệnh: mongodb-compass hoặc tìm trong menu ứng dụng."
