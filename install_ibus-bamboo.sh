#!/bin/bash
set -e

echo "🇻🇳 Thêm PPA chính thức của IBus Bamboo..."
sudo add-apt-repository -y ppa:bamboo-engine/ibus-bamboo

echo "🔄 Cập nhật danh sách gói..."
sudo apt-get update

echo "⬇️ Cài đặt IBus Bamboo và ibus..."
sudo apt-get install -y ibus ibus-bamboo --install-recommends

echo "🔁 Khởi động lại ibus..."
# ibus restart

echo "⚙️ Đặt Bamboo làm bộ gõ mặc định..."
env DCONF_PROFILE=ibus dconf write /desktop/ibus/general/preload-engines "['BambooUs', 'Bamboo']"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo')]"

echo "✅ Đã hoàn tất cài đặt và cấu hình IBus Bamboo!"
echo "📌 Mở Settings > Region & Language để kiểm tra input method nếu cần."
