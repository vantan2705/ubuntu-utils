#!/bin/bash
set -e

echo "📦 Cài đặt MongoDB Command Line Database Tools..."

# Thêm key chính thức của MongoDB
wget -qO - https://pgp.mongodb.com/server-6.0.asc | \
  gpg --dearmor | \
  sudo tee /usr/share/keyrings/mongodb-server-6.0.gpg > /dev/null

# Thêm MongoDB Tools repository (chỉ cần cho tools, không phải server)
echo "deb [signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | \
  sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
#echo "deb [signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/6.0 multiverse" | \
#  sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

# Cập nhật danh sách gói
sudo apt update

# Cài đặt chỉ MongoDB Tools (không cài mongod)
sudo apt install -y mongodb-database-tools

echo "✅ MongoDB Tools đã được cài đặt!"
echo "📂 Các lệnh như 'mongodump', 'mongoimport', 'bsondump' đã sẵn sàng."