#!/bin/bash
set -e

echo "🔄 Cập nhật danh sách gói..."
sudo apt update

echo "⬇️ Cài đặt FileZilla Client..."
sudo apt install -y filezilla

echo "✅ FileZilla đã được cài đặt thành công!"
echo "🚀 Gõ 'filezilla' hoặc mở từ menu ứng dụng để sử dụng."
