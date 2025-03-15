#!/bin/bash

# Cập nhật hệ thống
sudo apt update && sudo apt upgrade -y

# Cài đặt KMP Player (không có gói chính thức, có thể thay bằng VLC)
sudo apt install -y vlc

# Cài đặt Google Chrome
wget -O google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome.deb
sudo apt install -f -y
rm google-chrome.deb

# Cài đặt Microsoft Edge
wget -O microsoft-edge.deb https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_*.deb
sudo dpkg -i microsoft-edge.deb
sudo apt install -f -y
rm microsoft-edge.deb

# Cài đặt Visual Studio Code
wget -O vscode.deb https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
sudo dpkg -i vscode.deb
sudo apt install -f -y
rm vscode.deb

# Cài đặt pyenv
curl https://pyenv.run | bash
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# Cài đặt Python 3.8 với pyenv
pyenv install 3.8.18
pyenv global 3.8.18

# Cài đặt nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Cài đặt Node.js 20
nvm install 20
nvm use 20
nvm alias default 20

# Cài đặt Notepad++ (dùng snap)
sudo snap install notepad-plus-plus

# Cài đặt Grub Customizer
sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y
sudo apt update
sudo apt install -y grub-customizer

# Cài đặt ibus-unikey
sudo apt install -y ibus-unikey
ibus restart

# Cài đặt các công cụ phát triển chung
sudo apt install -y build-essential git docker.io vim

# Cài đặt MongoDB Compass
wget -O mongodb-compass.deb https://downloads.mongodb.com/compass/mongodb-compass_1.36.4_amd64.deb
sudo dpkg -i mongodb-compass.deb
sudo apt install -f -y
rm mongodb-compass.deb

# Cài đặt 1Remote và Medis
sudo snap install 1remote medis

# Cài đặt Cursor
wget -O cursor.deb https://github.com/getcursor/cursor/releases/latest/download/cursor.deb
sudo dpkg -i cursor.deb
sudo apt install -f -y
rm cursor.deb

# Các ứng dụng tùy chọn
read -p "Bạn có muốn cài đặt Android Studio? (y/n): " install_android
if [ "$install_android" == "y" ]; then
    sudo snap install android-studio --classic
fi

read -p "Bạn có muốn cài đặt Java 11? (y/n): " install_java
if [ "$install_java" == "y" ]; then
    sudo apt install -y openjdk-11-jdk
fi

read -p "Bạn có muốn cài đặt Flutter 3.13.9? (y/n): " install_flutter
if [ "$install_flutter" == "y" ]; then
    wget -O flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.9-stable.tar.xz
    sudo tar -xf flutter.tar.xz -C /opt
    sudo ln -s /opt/flutter/bin/flutter /usr/local/bin/flutter
    rm flutter.tar.xz
fi

read -p "Bạn có muốn cài đặt Gradle 6.7.1? (y/n): " install_gradle
if [ "$install_gradle" == "y" ]; then
    wget -O gradle.zip https://services.gradle.org/distributions/gradle-6.7.1-bin.zip
    sudo unzip gradle.zip -d /opt/gradle
    sudo ln -s /opt/gradle/gradle-6.7.1/bin/gradle /usr/local/bin/gradle
    rm gradle.zip
fi

# Thông báo hoàn thành
echo "\nCài đặt hoàn tất! Vui lòng khởi động lại hệ thống."

# Hướng dẫn sử dụng script
echo "\nHướng dẫn chạy script:"
echo "1. Mở Terminal và điều hướng đến thư mục chứa script."
echo "2. Chạy lệnh sau để cấp quyền thực thi:"
echo "   chmod +x install_apps_ubuntu.sh"
echo "3. Chạy script bằng lệnh:"
echo "   ./install_apps_ubuntu.sh"

# echo "\nGiải thích từng dòng lệnh:"
# echo "- sudo apt update && sudo apt upgrade -y: Cập nhật danh sách gói và nâng cấp hệ thống."
# echo "- sudo apt install -y <package>: Cài đặt một gói phần mềm mà không cần xác nhận thủ công."
# echo "- wget -O <file>.deb <URL>: Tải về tệp .deb từ Internet."
# echo "- sudo dpkg -i <file>.deb: Cài đặt một tệp .deb."
# echo "- sudo apt install -f -y: Sửa lỗi phụ thuộc nếu có khi cài đặt gói."
# echo "- rm <file>.deb: Xóa tệp cài đặt sau khi hoàn tất."
# echo "- pyenv install <version>: Cài đặt một phiên bản Python qua pyenv."
# echo "- nvm install <version>: Cài đặt một phiên bản Node.js qua NVM."
# echo "- nvm use <version>: Sử dụng phiên bản Node.js đã cài."
# echo "- sudo snap install <package>: Cài đặt phần mềm qua Snap."
# echo "- add-apt-repository: Thêm kho lưu trữ PPA mới."
# echo "- ibus restart: Khởi động lại ibus để áp dụng cấu hình bàn phím Unikey."
# echo "- read -p: Cho phép người dùng chọn cài đặt ứng dụng tùy chọn."
# echo "- tar -xf <file>: Giải nén tập tin tar.xz."
# echo "- ln -s: Tạo liên kết mềm để dễ dàng sử dụng các công cụ."
