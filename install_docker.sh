#!/bin/bash

set -e

echo "🔄 Cập nhật APT và cài gói phụ thuộc..."
sudo apt update -y
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "🔑 Thêm GPG key Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "📦 Tạo Docker repo dùng codename jammy..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu jammy stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Cập nhật lại APT sau khi thêm Docker repo..."
sudo apt update -y

echo "⬇️ Cài Docker Engine, CLI và plugins..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "🔁 Kích hoạt và khởi động Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "👤 Thêm người dùng hiện tại vào group docker..."
sudo usermod -aG docker "$USER"

echo "🎯 Docker đã cài xong. Phiên bản:"
docker --version

echo
echo "✅ Hoàn tất cài Docker!"
echo "👉 Chạy lệnh sau hoặc đăng xuất + đăng nhập lại để dùng Docker không cần sudo:"
echo ""
echo "   newgrp docker"
echo ""
echo "🧪 Test nhanh: docker run hello-world"
