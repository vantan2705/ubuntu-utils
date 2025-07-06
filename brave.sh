#!/bin/bash

set -e  # Dừng script nếu có lỗi xảy ra

echo "🔧 Installing curl (if not already installed)..."
sudo apt update
sudo apt install -y curl

echo "🔐 Downloading Brave GPG key..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
  https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "📝 Adding Brave APT repository..."
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | \
  sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null

echo "🔄 Updating package list..."
sudo apt update

echo "🌐 Installing Brave Browser..."
sudo apt install -y brave-browser

echo "✅ Brave Browser installation complete!"
