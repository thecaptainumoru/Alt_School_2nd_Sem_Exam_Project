#!/bin/bash

# Define variables (I will modify as needed)
GIT_REPO_URL="https://github.com/laravel/laravel"
APP_DIR="/var/www/html"  # Directory for application files
MYSQL_ROOT_PASSWORD="your_mysql_password"  # Set a strong password

# Update package lists
apt-get update

# Install LAMP Stack packages
apt-get install -y apache2 mysql-server php php-mysqli

# Create application directory (if it doesn't exist)
if [ ! -d "$APP_DIR" ]; then
  mkdir -p "$APP_DIR"
  chown www-data:www-data "$APP_DIR"
fi

# Clone PHP application from GitHub
cd "$APP_DIR"
git clone "$GIT_REPO_URL" .

# Grant permissions for web server access
chmod -R 755 "$APP_DIR"

# Configure Apache virtual host (replace with your domain name)
a2ensite alt-school-project.local.conf

# Restart Apache
systemctl restart apache2

# Secure MySQL installation
mysql_secure_installation << EOF
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
y
y
y
EOF

# (Optional) Create a basic database (replace with your database name)
mysql -u root -p$MYSQL_ROOT_PASSWORD << EOF
CREATE DATABASE your_database;
EOF

echo "LAMP stack deployment complete!"
