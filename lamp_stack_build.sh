#!/bin/bash

# ////// This script installs the LAMP Stack for your server to use.
# ////// Linux, Apache, MySQL, PHP, and opens the firewall so you can start using your server immediately.
# ////// Thanks and enjoy everyone! - Chase Hammock

echo -e "\n\nUpdating yum packages"
yum update -y

echo -e "\n\nInstalling Apache2 Web Server"
yum install httpd -y

echo -e "\n\n Starting Apache2"
sudo systemctl start httpd.service

echo -e "\n\n Enabling Apache2 to Start with OS"
sudo systemctl enable httpd.service

echo -e "\n\n Apache Version Check"
httpd --version

echo -e "\n\nPermissions for /var/www\n"
sudo chown -R www-data:www-data /var/www
echo -e "\n\n Permissions have been set\n"

echo -e "\n\n Installing MariaDB Server"
sudo yum install mariadb-server mariadb -y

echo -e "\n\n Start MariaDB"
sudo systemctl start mariadb

echo -e "\n\n Initiate MySQL Secure Installation Steps"
sudo mysql_secure_installation

echo -e "\n\n Enable MariaDB to start with the OS"
sudo systemctl enable mariadb.service

echo -e "\n\n Install PHP framework"
sudo yum install php php-mysql

echo -e "\n\n Restart Apache WebServer to Enable PHP Interpretation"
sudo systemctl restart httpd.service

if ! command -v firewalld &> /dev/null
then
    echo "Firewalld could not be found so let's install it"
    yum install firewalld -y
    systemctl start firewalld
    systemctl enable firewalld
    exit
fi

echo -e "\n\n Open the Firewall for HTTP port 80"
sudo firewall-cmd --permanent --zone=public --add-service=http

echo -e "\n\n Open the Firewall for Port 443 SSL comms"
sudo firewall-cmd --permanent --zone=public --add-service=https

echo -e "\n\n Reload the firewall rules to allow new rules to take effect"
sudo firewall-cmd --reload



