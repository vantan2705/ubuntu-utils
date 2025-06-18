#!/bin/bash
set -e

echo "🔄 Cập nhật danh sách gói..."
sudo apt update

echo "⬇️ Cài đặt qBittorrent..."
sudo apt install -y qbittorrent

echo "✅ Đã cài đặt xong qBittorrent!"
echo "🚀 Bạn có thể mở nó bằng lệnh: qbittorrent hoặc tìm trong menu."
