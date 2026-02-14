#!/bin/bash
set -e

echo "🔐 Installing Cloudflare WARP (1.1.1.1) for Linux Mint..."

KEYRING="/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg"
LIST_FILE="/etc/apt/sources.list.d/cloudflare-client.list"

# 1. Dependencies
sudo apt update
sudo apt install -y curl gnupg lsb-release ca-certificates

# 2. Import GPG key (idempotent)
if [ ! -f "$KEYRING" ]; then
  echo "🔑 Importing Cloudflare GPG key..."
  curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | \
    sudo gpg --dearmor -o "$KEYRING"
else
  echo "🔑 GPG key already exists, skipping."
fi

# 3. Detect Ubuntu codename (Mint compatibility)
UBUNTU_CODENAME=$(grep UBUNTU_CODENAME /etc/os-release | cut -d= -f2)

echo "📦 Using Ubuntu codename: $UBUNTU_CODENAME"

echo "deb [signed-by=$KEYRING] https://pkg.cloudflareclient.com/ $UBUNTU_CODENAME main" | \
sudo tee "$LIST_FILE" > /dev/null

# 4. Install WARP
sudo apt update
sudo apt install -y cloudflare-warp

echo "✅ Cloudflare WARP installed successfully!"
echo
echo "👉 Next steps:"
echo "   warp-cli registration new"
echo "   warp-cli connect        # WARP VPN"
echo "   warp-cli set-mode dns   # DNS only"
