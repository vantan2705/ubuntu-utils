#!/bin/bash

# Cập nhật hệ thống
echo "Updating package list..."
sudo apt update

# Cài đặt wget nếu chưa có
echo "Installing wget if not present..."
sudo apt install -y wget

# Tải Google Chrome bản mới nhất từ Google
echo "Downloading Google Chrome .deb package..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome.deb

# Cài đặt Chrome
echo "Installing Google Chrome..."
sudo apt install -y /tmp/google-chrome.deb

# Kiểm tra kết quả
if command -v google-chrome > /dev/null; then
    echo "✅ Google Chrome đã được cài đặt thành công!"
else
    echo "❌ Có lỗi xảy ra khi cài đặt Google Chrome."
fi
