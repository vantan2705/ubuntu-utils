#!/bin/bash
set -e

echo "🎬 Bắt đầu cài đặt FFmpeg..."

echo "🔄 Cập nhật hệ thống..."
sudo apt update -y

echo "⬇️ Cài đặt FFmpeg..."
sudo apt install -y ffmpeg

echo "🎥 Kiểm tra phiên bản FFmpeg:"
ffmpeg -version | head -n 1

echo "✅ Cài đặt FFmpeg hoàn tất!"
