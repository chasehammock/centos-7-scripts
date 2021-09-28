#!/bin/bash

echo -e "\n\nUpdating yum packages"
yum update -y

echo -e "\n\nInstalling Apache2 Web Server"
yum install httpd -y

echo -e "\n\n Starting Apache2"
sudo systemctl start httpd.service

echo -e "\n\n Apache Version Check"
httpd --version

echo -e "\n\nPermissions for /var/www\n"
sudo chown -R www-data:www-data /var/www
echo -e "\n\n Permissions have been set\n"

echo -e "\n\n Installing MariaDB Server"
sudo yum install mariadb-server mariadb -y

echo -e "\n\n
sudo systemctl start mariadb

echo -e "\n\n
sudo mysql_secure_installation

echo -e "\n\n
sudo systemctl enable mariadb.service

echo -e "\n\n
sudo yum install php php-mysql

echo -e "\n\n
sudo systemctl restart httpd.service

echo -e "\n\n
sudo firewall-cmd --permanent --zone=public --add-service=http

echo -e "\n\n
sudo firewall-cmd --permanent --zone=public --add-service=https

echo -e "\n\n
sudo firewall-cmd --reload



