#!/bin/bash

set -e

echo "🔄 Cập nhật APT..."
sudo apt update -y
sudo apt install -y curl zip unzip

echo "⬇️ Cài đặt SDKMAN..."
curl -s "https://get.sdkman.io" | bash

# Nạp SDKMAN vào shell hiện tại
export SDKMAN_DIR="$HOME/.sdkman"
source "$SDKMAN_DIR/bin/sdkman-init.sh"

echo "✅ SDKMAN đã được cài!"

echo "📦 Tìm phiên bản Java 11 phù hợp..."
JAVA_VERSION=$(sdk list java | grep -E "11.*-tem" | head -n 1 | awk '{print $NF}')

if [ -z "$JAVA_VERSION" ]; then
    echo "❌ Không tìm thấy phiên bản Java 11."
    exit 1
fi

echo "⬇️ Cài Java 11 ($JAVA_VERSION)..."
sdk install java "$JAVA_VERSION"

echo "🎯 Đặt Java 11 làm mặc định..."
sdk default java "$JAVA_VERSION"

echo "🧪 Kiểm tra phiên bản:"
java -version

echo "🎉 Hoàn tất! Java 11 đã được cài và thiết lập mặc định qua SDKMAN."
