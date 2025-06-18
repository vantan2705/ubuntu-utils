#!/bin/bash
set -e

echo "📦 Cài đặt RedisInsight (GUI quản lý Redis) cho Ubuntu..."

echo "🔄 Tạo thư mục tạm..."
TMP_DIR="/tmp/redisinsight"
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

echo "⬇️ Tải RedisInsight AppImage..."
wget -O redisinsight.AppImage https://downloads.redisinsight.redis.com/latest/RedisInsight-x86_64.AppImage

echo "🔧 Cấp quyền thực thi..."
chmod +x redisinsight.AppImage

echo "📂 Di chuyển vào /opt và tạo shortcut..."
sudo mkdir -p /opt/redisinsight
sudo mv redisinsight.AppImage /opt/redisinsight/redisinsight.AppImage

echo "🖥️ Tạo file .desktop để hiển thị trong menu..."
cat <<EOF | sudo tee /usr/share/applications/redisinsight.desktop > /dev/null
[Desktop Entry]
Name=RedisInsight
Exec=/opt/redisinsight/redisinsight.AppImage
Icon=redis
Type=Application
Categories=Development;Database;
Comment=Redis GUI Client
Terminal=false
EOF

echo "✅ RedisInsight đã được cài đặt!"
echo "👉 Bạn có thể tìm 'RedisInsight' trong menu hoặc chạy:"
echo "   /opt/redisinsight/redisinsight.AppImage"
