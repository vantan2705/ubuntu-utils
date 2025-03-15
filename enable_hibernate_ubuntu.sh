#!/bin/bash

# ========================================================
# Script này sẽ bật tính năng Hibernate trên Linux Mint
# Tác giả: ChatGPT
# ========================================================

echo "🔍 Kiểm tra hệ thống có hỗ trợ Hibernate không..."
if [ ! -f /sys/power/state ] || ! grep -q "disk" /sys/power/state; then
    echo "❌ Hệ thống của bạn không hỗ trợ Hibernate!"
    exit 1
fi

echo "✅ Hệ thống hỗ trợ Hibernate!"

# Kiểm tra swap
SWAP_SIZE=$(swapon --summary | awk 'NR==2 {print $3}')
MEM_SIZE=$(awk '/MemTotal/ {print $2}' /proc/meminfo)

if [ -z "$SWAP_SIZE" ]; then
    echo "❌ Không tìm thấy swap! Vui lòng tạo một phân vùng swap lớn hơn RAM."
    exit 1
fi

if (( SWAP_SIZE < MEM_SIZE )); then
    echo "⚠️ Cảnh báo: Swap nhỏ hơn RAM, Hibernate có thể không hoạt động đúng!"
fi

# Lấy UUID của phân vùng swap
SWAP_UUID=$(blkid -o value -s UUID $(awk '$1=="swap" {print $1}' /etc/fstab))

if [ -z "$SWAP_UUID" ]; then
    echo "❌ Không tìm thấy UUID của swap!"
    exit 1
fi

echo "🔧 Đang cấu hình Hibernate..."

# Thêm boot parameter cho GRUB
GRUB_FILE="/etc/default/grub"
if ! grep -q "resume=UUID=$SWAP_UUID" $GRUB_FILE; then
    sudo sed -i "s|GRUB_CMDLINE_LINUX_DEFAULT=\"|GRUB_CMDLINE_LINUX_DEFAULT=\"resume=UUID=$SWAP_UUID |" $GRUB_FILE
fi

# Cập nhật GRUB
echo "🔄 Cập nhật GRUB..."
sudo update-grub

# Cấu hình systemd
RESUME_CONF="/etc/initramfs-tools/conf.d/resume"
echo "RESUME=UUID=$SWAP_UUID" | sudo tee $RESUME_CONF

# Cập nhật initramfs
echo "🔄 Cập nhật initramfs..."
sudo update-initramfs -u

echo "✅ Hibernate đã được kích hoạt thành công!"

# Hướng dẫn sử dụng Hibernate
cat <<EOF

=================================================
✅ HƯỚNG DẪN SỬ DỤNG HIBERNATE ✅
=================================================
1️⃣ Kiểm tra Hibernate có hoạt động không:
   sudo systemctl hibernate

2️⃣ Nếu hệ thống không Hibernate, hãy kiểm tra nhật ký:
   journalctl -xe | grep hibernate

3️⃣ Nếu muốn bật Hibernate trên menu nguồn:
   - Mở file policykit:
     sudo nano /etc/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkla
   - Thêm nội dung sau:
     [Enable Hibernate]
     Identity=unix-user:*
     Action=org.freedesktop.upower.hibernate
     ResultActive=yes
   - Lưu và khởi động lại máy.

4️⃣ Nếu gặp lỗi, kiểm tra kernel logs:
   dmesg | grep -i hibernate

=================================================
🚀 CÁCH CHẠY SCRIPT 🚀
=================================================
1️⃣ Mở terminal và chuyển đến thư mục chứa script:
   cd /đường/dẫn/đến/script

2️⃣ Cấp quyền chạy cho script:
   chmod +x enable-hibernate.sh

3️⃣ Chạy script với quyền root:
   sudo ./enable-hibernate.sh

📌 Nếu có vấn đề, hãy kiểm tra swap và kernel logs!
=================================================

EOF
