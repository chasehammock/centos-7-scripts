#!/bin/bash

# ////// This script installs the speedtest-cli in order to test your Internet speed
# ////// This tools is good for testing the network upload and download speeds to solve certain problems.
# ////// To do this, first, we installed Python, wget, and Speedtest tool.
# ////// Thanks and enjoy everyone! - Chase Hammock

echo -e "\n\nUpdating yum packages"
yum update -y

# Install Python
yum install -y python

# Is wget installed on your machine - if not this will install it...
if ! command -v wget &> /dev/null
then
    echo "wget could not be found so let's install it"
    yum install wget -y
    exit
fi

# Install speedtest-cli on your machine
wget -O speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py

# Set permissions correctly on the executable
chmod +x speedtest.cli

# run it
./speedtest-cli

echo "Enjoy Everyone!"

