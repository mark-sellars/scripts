#!/bin/bash

# Needed for killall
yum install psmisc -y

# Make Readme in skel
mkdir /etc/skel/Desktop
echo "it is strongly suggested to change the password for root, labuser, and any other accounts." > /etc/skel/Desktop/README.txt

# Remove zabbix
yum remove zabbix -y

# Remove Lab Repos
rm /etc/yum.repos.d/*

# Load Default Repo Files
curl -k -O https://repos.labs.example.com/repository/software_depot/repo_files/default_repo_files.tar.gz
tar -xvf default_repo_files.tar.gz
mv default_repo_files/* /etc/yum.repos.d/
chmod -R 644 /etc/yum.repos.d/
chown -R root:root /etc/yum.repos.d/

# Remove SMI CA Cert
rm /etc/pki/ca-trust/source/anchors/adserver-ca.cer
update-ca-trust

echo SMI CA Cert removed

# Clear IP address and set to DHCP
_repeat="Y"

while [ $_repeat = "Y" ]
do
        # Do whatever

        ifconfig
        read -p "which interface would you like to clear? eg. eno1 eth1: " int

        sed -i '/DNS/d' /etc/sysconfig/network-scripts/ifcfg-$int
        sed -i '/IPADDR/d' /etc/sysconfig/network-scripts/ifcfg-$int
        sed -i '/GATEWAY/d' /etc/sysconfig/network-scripts/ifcfg-$int
        sed -i '/PREFIX/d' /etc/sysconfig/network-scripts/ifcfg-$int
        sed -i '/PEERDNS/d' /etc/sysconfig/network-scripts/ifcfg-$int
        sed -i 's/BOOTPROTO=none/BOOTPROTO=dhcp/g' /etc/sysconfig/network-scripts/ifcfg-$int

        systemctl restart network

        # Prompt for repeat
        echo -n "Would you like to clear another interface? (Y/N)"
        read -n1 Input
        echo # Completes the line
        case $Input in
                [Nn]):
                _repeat="N"
                ;;
        esac
done

#Create customer user
while true
do
 read -r -p "Would you like to create a customer user? [Y/n] " input
 
 case $input in
     [yY][eE][sS]|[yY])
 read -p "Enter username for the customer user " user
 useradd -m $user
 passwd $user 
 break
 ;;
     [nN][oO]|[nN])
 echo "Skipping"
 break
        ;;
     *)
 echo "Invalid input..."
 ;;
 esac
done

#Change Root Password
passwd

#Change Labuser password
passwd labuser

# Remove UXADMIN
killall -9 -u uxadmin
userdel -rfZ uxadmin

# Cleanup
yum clean all -y
rm default_repo_files.tar.gz
rm -r default_repo_files
rm customer_prep.sh

echo Done!
