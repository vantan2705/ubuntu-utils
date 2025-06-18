#!/bin/bash
set -e

echo "🌐 Bắt đầu cài đặt Opera Browser (có tích hợp VPN)..."

# Cài gói hỗ trợ APT HTTPS nếu cần
sudo apt update
sudo apt install -y wget gnupg apt-transport-https software-properties-common

# Thêm khóa GPG chính thức của Opera
wget -qO- https://deb.opera.com/archive.key | sudo gpg --dearmor -o /usr/share/keyrings/opera.gpg

# Thêm repository Opera vào danh sách APT
echo "deb [signed-by=/usr/share/keyrings/opera.gpg] https://deb.opera.com/opera-stable/ stable non-free" | \
  sudo tee /etc/apt/sources.list.d/opera-stable.list

# Cập nhật lại danh sách gói
sudo apt update

# Cài đặt Opera Stable
sudo apt install -y opera-stable

echo "✅ Opera đã được cài đặt thành công!"
echo "🚀 Bạn có thể mở trình duyệt Opera từ menu hoặc gõ: opera"
echo "🔐 VPN: Vào Cài đặt (Settings) → Privacy & Security → Bật VPN."
