#!/bin/bash

# Cập nhật hệ thống và cài đặt Squid
echo "Cập nhật và cài đặt Squid..."
sudo apt update -y
sudo apt upgrade -y
sudo apt install squid -y
sudo apt install vim -y
sudo apt install apache2-utils -y

# Xóa file cấu hình cũ và tạo lại
echo "Xóa file cấu hình Squid cũ và tạo mới..."
sudo rm /etc/squid/squid.conf
echo "Tạo cấu hình Squid mới..."

# Đoạn cấu hình Squid mặc định
cat <<EOF | sudo tee /etc/squid/squid.conf
auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwords
auth_param basic realm proxy
acl authenticated proxy_auth REQUIRED
http_access allow authenticated
http_port 6969
EOF

# Hỏi người dùng nhập port
read -p "Nhập port bạn muốn cấu hình cho Squid (ví dụ: 6969): " port
sudo sed -i "s/http_port 6969/http_port $port/" /etc/squid/squid.conf

# Restart Squid service
echo "Khởi động lại dịch vụ Squid..."
sudo systemctl restart squid.service

# Tạo tài khoản proxy
read -p "Nhập tên người dùng cho proxy: " username
sudo htpasswd -c /etc/squid/passwords $username

# Yêu cầu nhập mật khẩu 2 lần
echo "Nhập mật khẩu cho người dùng $username..."
sudo htpasswd /etc/squid/passwords $username

# Hiển thị proxy IP sau khi thiết lập
echo "Đang lấy thông tin IP proxy của bạn..."
curl ipinfo.io

echo "Cài đặt proxy Squid đã hoàn tất!"
echo "Proxy của bạn đã sẵn sàng tại: $port"
