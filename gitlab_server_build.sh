#!/bin/bash

# ////// This script installs the LAMP Stack for your server to use.
# ////// Linux, Apache, MySQL, PHP, and opens the firewall so you can start using your server immediately.
# ////// Thanks and enjoy everyone! - Chase Hammock

echo -e "\n\nUpdating yum packages"
yum update -you

sudo yum install -y curl policycoreutils-python openssh-server perl
# Enable OpenSSH server daemon if not enabled: sudo systemctl status sshd
sudo systemctl enable sshd
sudo systemctl start sshd

# Check and see if firewalld is installed, if not install it...
if ! command -v firewalld &> /dev/null
then
    echo "Firewalld could not be found so let's install it"
    yum install firewalld -y
    systemctl start firewalld
    systemctl enable firewalld
    exit
fi

# Check if opening the firewall is needed with: sudo systemctl status firewalld
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo systemctl reload firewalld

# Next, install Postfix to send notification emails. 
# If you want to use another solution to send emails please skip this step and 
# configure an external SMTP server after GitLab has been installed.
sudo yum install postfix
sudo systemctl enable postfix
sudo systemctl start postfix

# Install GitLab package repo and install GitLab
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash
