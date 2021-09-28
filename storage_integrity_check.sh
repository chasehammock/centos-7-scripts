#!/bin/bash

# ////// This script installs smartmontools for CentOS and then checks the disk for integrity.
# ////// If it detects failures it sends email to sysadmin.
# ////// Thanks and enjoy everyone! - Chase Hammock

echo -e "\n\nUpdating yum packages"
yum update -you

# Check and see if smartmontools is installed, if not install it...
if ! command -v smartctl &> /dev/null
then
    echo "smartmontools could not be found so let's install it"
    yum install smartmontools -y
    systemctl start smartd ; systemctl enable smartd
    exit
fi

# Is smart capability enabled for the disk??
smartctl -i /dev/sda

# Begin smart checking of disk script
EMAIL=sysadmin@email.com
HOST=$(hostname)
SEND_EMAIL=/root/disk_check
DETECT_PROBLEM=0

echo "Disk checks on $HOST" > $SEND_EMAIL
echo >> $SEND_EMAIL

# CHECK PHYSICAL DISKS
for i in /dev/sd[a-z];
do
STATUS=$(/usr/sbin/smartctl -H $i | grep result)
if [ $(echo $STATUS | /bin/gawk '{print $NF}') != PASSED ]; then
# echo $i FAILED
echo >> $SEND_EMAIL
echo >> $i
echo >> $SEND_EMAIL
/usr/sbin/smartctl -a $i >> $SEND_EMAIL
echo >> $SEND_EMAIL
PROBLEMDETECTED=1
else
echo $i: $STATUS >> $SEND_EMAIL
fi
done

# End of disk checking sequence.