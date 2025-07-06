#!/bin/bash

set -e

# === Bạn có thể chỉnh tên/email ở đây ===
GIT_NAME="Nguyen Tan"
GIT_EMAIL="vantan2759@gmail.com"

echo "🔄 Cập nhật APT..."
sudo apt update -y

echo "⬇️ Cài đặt Git..."
sudo apt install -y git

echo "✅ Git version:"
git --version

echo "🧾 Cấu hình tên và email Git..."
git config --global credential.helper store
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

echo "🔐 Kiểm tra SSH key hiện tại..."
SSH_KEY_PATH="$HOME/.ssh/id_ed25519"

if [ -f "$SSH_KEY_PATH" ]; then
  echo "✅ SSH key đã tồn tại tại: $SSH_KEY_PATH"
else
  echo "🔐 Tạo SSH key mới với email $GIT_EMAIL"
  ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$SSH_KEY_PATH" -N ""
fi

echo "📎 Thêm SSH key vào ssh-agent..."
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY_PATH"

echo "📋 Public key của bạn là:"
echo "-----------------------------------------"
cat "${SSH_KEY_PATH}.pub"
echo "-----------------------------------------"
echo "📌 Hãy copy key này và thêm vào GitHub: https://github.com/settings/keys"

echo "✅ Đã hoàn tất cài đặt Git + SSH!"
