#!/bin/bash
set -e

echo "📦 Thêm PPA chính thức của Remmina..."
sudo add-apt-repository ppa:remmina-ppa-team/remmina-next -y
sudo apt update

echo "⬇️ Cài Remmina và plugin..."
sudo apt install -y remmina remmina-plugin-rdp remmina-plugin-secret remmina-plugin-exec

echo "✅ Remmina đã được cài thành công! SSH support đã tích hợp sẵn."
