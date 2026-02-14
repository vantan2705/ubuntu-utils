#!/bin/bash
set -e

echo "🎵 Installing Spotify via Flatpak (Flathub)..."

# 1. Install flatpak if missing
if ! command -v flatpak &> /dev/null; then
  echo "📦 Installing Flatpak..."
  sudo apt update
  sudo apt install -y flatpak
fi

# 2. Add Flathub remote if not exists
if ! flatpak remote-list | grep -q flathub; then
  echo "🌐 Adding Flathub remote..."
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# 3. Install Spotify
echo "⬇️ Installing Spotify..."
flatpak install -y flathub com.spotify.Client

echo "✅ Spotify installed successfully!"
echo
echo "▶️ Run Spotify:"
echo "   flatpak run com.spotify.Client"
