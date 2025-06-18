#!/bin/bash

set -e

echo "🔄 Đang cập nhật APT..."
sudo apt update -y

echo "🔧 Cài đặt các gói cần thiết để biên dịch Python..."
sudo apt install -y \
    make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
    libffi-dev liblzma-dev git

echo "⬇️ Tải pyenv về ~/.pyenv..."
if [ -d "$HOME/.pyenv" ]; then
    echo "📁 ~/.pyenv đã tồn tại, bỏ qua bước clone."
else
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

echo "🔗 Thiết lập cấu hình shell cho pyenv..."

SHELL_RC=""
if [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_RC="$HOME/.bashrc"
else
    SHELL_RC="$HOME/.profile"
fi

# Thêm cấu hình nếu chưa có
if ! grep -q 'pyenv init' "$SHELL_RC"; then
    cat << 'EOF' >> "$SHELL_RC"

# >>> pyenv setup >>>
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
# <<< pyenv setup <<<
EOF
    echo "✅ Đã thêm cấu hình vào $SHELL_RC"
else
    echo "ℹ️ Đã có cấu hình pyenv trong $SHELL_RC"
fi

# Load pyenv vào shell hiện tại
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

echo "🐍 Cài đặt Python 3.13.2 thông qua pyenv..."
pyenv install 3.13.2

echo "🎯 Đặt Python 3.13.2 làm mặc định (global)..."
pyenv global 3.13.2

echo "🧪 Kiểm tra phiên bản Python hiện tại:"
python --version
which python

echo "🎉 Hoàn tất! Pyenv + Python 3.13.2 đã sẵn sàng."
