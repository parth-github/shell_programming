#!/bin/bash
# nginx-starter.sh
# This script is used to start the Nginx server with a specific configuration.
# Check if Nginx is installed
if ! command -v nginx &> /dev/null; then
    echo "Nginx is not installed. Please install Nginx first."
    exit 1
fi
# Start Nginx with the specified configuration file
if [ -f /etc/nginx/nginx.conf ]; then
    echo "Starting Nginx..."
    sudo nginx -c /etc/nginx/nginx.conf
    if [ $? -eq 0 ]; then
        echo "Nginx started successfully."
    else
        echo "Failed to start Nginx."
        exit 1
    fi
else
    echo "Nginx configuration file not found at /etc/nginx/nginx.conf."
    exit 1
fi
# Check the status of Nginx
if systemctl is-active --quiet nginx; then
    echo "Nginx is running."
else
    echo "Nginx is not running. Please check the logs for more details."
    exit 1
fi
# End of nginx-starter.sh
# This script can be executed to start Nginx with the specified configuration.
# Make sure to give it execute permissions:
# chmod +x nginx-starter.sh
# You can run it using:
# ./nginx-starter.sh
# Ensure you have the necessary permissions to start Nginx, typically requires sudo.