#!/bin/bash

# Cập nhật danh sách gói
echo "🌀 Đang cập nhật hệ thống..."
sudo apt update

# Cài đặt các gói hỗ trợ HTTPS
echo "🔧 Cài đặt các gói hỗ trợ HTTPS và curl..."
sudo apt install -y wget gpg apt-transport-https software-properties-common

# Thêm kho của Microsoft và import GPG key
echo "🔑 Thêm GPG key của Microsoft..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/

echo "📦 Thêm kho VS Code vào danh sách APT..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | \
  sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

# Xóa file key sau khi thêm
rm -f packages.microsoft.gpg

# Cập nhật lại APT và cài VS Code
echo "⬇️ Tải và cài đặt Visual Studio Code..."
sudo apt update
sudo apt install -y code

# Kiểm tra kết quả
if command -v code > /dev/null; then
    echo "✅ VS Code đã được cài đặt thành công!"
    echo "👉 Chạy bằng lệnh: code"
else
    echo "❌ Cài đặt VS Code thất bại."
fi
