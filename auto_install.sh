#!/bin/bash

# Đường dẫn đến file script trên GitHub
REPO_URL="https://github.com/s2codetaem/auto_up_proxy/raw/main/setup_squid.sh"

# Tải file script setup_squid.sh từ GitHub
echo "🔄 Tải file setup_squid.sh từ GitHub..."
curl -s -o setup_squid.sh $REPO_URL

# Cấp quyền thực thi cho script
chmod +x setup_squid.sh

# Chạy script
echo "🚀 Đang chạy script cài đặt Squid..."
./setup_squid.sh
