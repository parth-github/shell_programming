#!/bin/bash
# nginx-install.sh
# This script is used to install Nginx on a Linux system.
# Update package lists
sudo apt update
# Install Nginx from the git repository: https://github.com/nginx/nginx.git using make on Ubuntu 24.04
# Ensure you have the necessary build tools and dependencies
sudo apt install -y build-essential libpcre3 libpcre3-dev zlib1-dev libssl-dev
# Clone the Nginx repository
git clone https://github.com/nginx/nginx.git
cd nginx
# Checkout the desired version (e.g., 1.24.0)
git checkout tags/release-1.24.0
# Compile and install Nginx
auto/configure
make
sudo make install
# Create a systemd service file for Nginx
sudo tee /etc/systemd/system/nginx.service > /dev/null <<EOL
[Unit]
Description=Nginx
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/nginx/sbin/nginx
ExecReload=/usr/local/nginx/sbin/nginx -s reload
ExecStop=/usr/local/nginx/sbin/nginx -s stop

[Install]
WantedBy=multi-user.target
EOL
# Reload systemd to recognize the new service
sudo systemctl daemon-reload
# Enable and start Nginx service
sudo systemctl enable nginx
sudo systemctl start nginx
# Check the status of Nginx
if systemctl is-active --quiet nginx; then
    echo "Nginx installed and running successfully."
else
    echo "Nginx installation failed or is not running."
    exit 1
fi
# End of nginx-install.sh
# This script can be executed to install Nginx from the git repository.
# Make sure to give it execute permissions:
# chmod +x nginx-install.sh
# You can run it using:
# ./nginx-install.sh
# Ensure you have the necessary permissions to install software, typically requires sudo.