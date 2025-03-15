#!/bin/bash

# =====================================================
# 🛠️ SCRIPT CẤU HÌNH SAU KHI CÀI ĐẶT LINUX MINT 🛠️
# Tác giả: ChatGPT
# =====================================================

echo "🔄 Cập nhật hệ thống..."
sudo apt update && sudo apt upgrade -y

echo "🖥️ Kiểm tra và cài đặt driver..."
sudo ubuntu-drivers autoinstall

echo "✅ Cài đặt phần mềm thiết yếu..."
sudo apt install -y curl wget

echo "🛡️ Bật tường lửa (Firewall)..."
sudo ufw enable
sudo ufw status

echo "⚡ Tối ưu hiệu suất hệ thống..."
gsettings set org.cinnamon.desktop.effects enabled false

echo "🚀 Xóa ứng dụng không cần thiết..."
sudo apt remove -y thunderbird libreoffice-* && sudo apt autoremove -y

echo "✅ Hoàn tất! Khởi động lại hệ thống để áp dụng thay đổi."

# =====================================================
# 🚀 HƯỚNG DẪN CHẠY SCRIPT 🚀
# =====================================================
cat <<EOF

=================================================
✅ HƯỚNG DẪN CHẠY SCRIPT ✅
=================================================

1️⃣ Mở Terminal và chuyển đến thư mục chứa file:
   cd /đường/dẫn/đến/file

2️⃣ Cấp quyền chạy cho script:
   chmod +x setting_ubuntu.sh

3️⃣ Chạy script với quyền sudo:
   sudo ./setting_ubuntu.sh

📌 Sau khi chạy xong, khởi động lại hệ thống để hoàn tất!

=================================================

EOF
