#!/usr/bin/env bash

set -e

FLUTTER_VERSION="3.32.8"
FLUTTER_CHANNEL="stable"
INSTALL_DIR="$HOME/flutter"
TMP_DIR="/tmp/flutter-install"
FLUTTER_TARBALL="flutter_linux_${FLUTTER_VERSION}-${FLUTTER_CHANNEL}.tar.xz"
DOWNLOAD_URL="https://storage.googleapis.com/flutter_infra_release/releases/${FLUTTER_CHANNEL}/linux/${FLUTTER_TARBALL}"

echo "🚀 Installing Flutter $FLUTTER_VERSION ($FLUTTER_CHANNEL)..."

# 1) Clean old temp
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

# 2) Download Flutter
echo "⬇️  Downloading Flutter SDK..."
wget -O "$FLUTTER_TARBALL" "$DOWNLOAD_URL"

# 3) Remove old Flutter (if exists)
if [ -d "$INSTALL_DIR" ]; then
  echo "⚠️  Existing Flutter found at $INSTALL_DIR"
  read -p "Do you want to remove it? (y/N): " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    rm -rf "$INSTALL_DIR"
  else
    echo "❌ Installation cancelled"
    exit 1
  fi
fi

# 4) Extract
echo "📦 Extracting Flutter..."
tar -xf "$FLUTTER_TARBALL"
mv flutter "$INSTALL_DIR"

# 5) Add PATH
echo "🔧 Configuring PATH..."

add_path() {
  local file="$1"
  if [ -f "$file" ] && ! grep -q 'flutter/bin' "$file"; then
    echo '' >> "$file"
    echo '# Flutter SDK' >> "$file"
    echo 'export PATH="$HOME/flutter/bin:$PATH"' >> "$file"
    echo "✔ Added Flutter PATH to $file"
  fi
}

add_path "$HOME/.bashrc"

source ~/.bashrc

# 6) Cleanup
rm -rf "$TMP_DIR"

# 7) Verify
echo "✅ Flutter installed successfully!"
echo "➡ Reload your shell or run:"
echo "   source ~/.bashrc"
echo "🔎 Flutter version:"
flutter --version
