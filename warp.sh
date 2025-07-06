#!/bin/bash

set -e

VERSION="jammy"

# Giúp script chạy với quyền root
if [[ $EUID -ne 0 ]]; then
  echo "❌ Vui lòng chạy với sudo: sudo ./install-warp.sh"
  exit 1
fi

echo "=== CÀI ĐẶT CLOUDLARE WARP (1.1.1.1) ==="

# Bước 1: Cập nhật hệ thống & cài dependences
echo "[1/5] Cập nhật apt và cài curl, gnupg, apt-transport-https..."
apt update
apt install -y curl gnupg apt-transport-https lsb-release

# Bước 2: Thêm kho chính thức của Cloudflare
echo "[2/5] Thêm kho Cloudflare và import GPG key..."
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg \
  | gpg --dearmor -o /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg

#echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] \
#https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" \
#  | tee /etc/apt/sources.list.d/cloudflare-client.list

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] \
https://pkg.cloudflareclient.com/ $VERSION main" \
  | tee /etc/apt/sources.list.d/cloudflare-client.list

# Bước 3: Cài đặt cloudflare-warp
echo "[3/5] Cài đặt gói cloudflare-warp..."
apt update
apt install -y cloudflare-warp

# Bước 4: Kích hoạt service nếu cần
echo "[4/5] Bật auto-start dịch vụ warp..."
systemctl enable warp-svc
systemctl start warp-svc || true

# Bước 5: Đăng ký & kết nối
echo "[5/5] Đăng ký và kết nối WARP..."
warp-cli registration new
warp-cli connect

echo ""
echo "✅ CÀI ĐẶT HOÀN TẤT!"
echo "- Kiểm tra trạng thái: warp-cli status"
echo "- Xác nhận hoạt động: curl https://www.cloudflare.com/cdn-cgi/trace/ | grep warp"
echo ""
echo "🎯 Nếu output là 'warp=on' thì bạn đã kết nối thành công!"
echo "Bạn cũng có thể điều chỉnh chế độ DNS-only, gia đình, chọn giao thức, v.v. sử dụng warp-cli --help"
