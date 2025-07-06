#!/bin/bash
set -e

echo "📦 Bắt đầu cài đặt MongoDB Compass..."

# Chọn phiên bản tương thích
VERSION="1.46.3"
DEB_URL="https://downloads.mongodb.com/compass/mongodb-compass_${VERSION}_amd64.deb"

echo "⬇️ Tải MongoDB Compass v${VERSION} (.deb)..."
wget -O mongodb-compass.deb "$DEB_URL"

echo "💾 Cài đặt gói MongoDB Compass..."
sudo apt install -y ./mongodb-compass.deb

echo "🧹 Xoá file tạm..."
rm mongodb-compass.deb

echo "✅ MongoDB Compass ${VERSION} đã được cài đặt!"
echo "🚀 Bạn có thể mở bằng lệnh: mongodb-compass hoặc tìm trong menu ứng dụng."
