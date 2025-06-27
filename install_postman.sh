#!/bin/bash
set -e

# 1. Tải gói Postman
wget https://dl.pstmn.io/download/latest/linux64 -O /tmp/postman.tar.gz

# 2. Giải nén vào /opt
sudo tar -xzf /tmp/postman.tar.gz -C /opt

# 3. Tạo symlink để chạy bằng lệnh 'postman'
sudo ln -sfn /opt/Postman/Postman /usr/local/bin/postman

# 4. Tạo file .desktop để hiển thị trong menu ứng dụng
cat <<EOF | sudo tee /usr/share/applications/postman.desktop > /dev/null
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;Utilities;
EOF

# 5. Dọn file tạm (tuỳ chọn)
rm /tmp/postman.tar.gz

echo "✅ Đã cài đặt Postman! Gõ 'postman' để khởi chạy."
