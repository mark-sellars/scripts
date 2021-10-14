## SMI lab setup for smi internal repos ##

# Make temp folder and CD to it
mkdir /tmp/lab_setup
cd /tmp/lab_setup/

# Download CA root trust certificate
curl -k -O https://repos.labs.example.com/repository/certs-keys/ca/adserver-ca.cer

# Move the CA cert to the right folder, update owner permissions, and update the CA trusts of the host
mv adserver-ca.cer /etc/pki/ca-trust/source/anchors/
chmod 644 /etc/pki/ca-trust/source/anchors/adserver-ca.cer
chown root:root /etc/pki/ca-trust/source/anchors/adserver-ca.cer
update-ca-trust

# Clear out all repo files
rm /etc/yum.repos.d/*

# Download new repo files, put them in the right folder and set permissions and owner
curl -O https://repos.labs.example.com/repository/software_depot/repo_files/lab_repo_files.tar.gz
tar -xvf lab_repo_files.tar.gz
mv lab_repo_files/* /etc/yum.repos.d/
chmod -R 644 /etc/yum.repos.d/
chown -R root:root /etc/yum.repos.d/

# Update yum to help read the new repofiles better
yum clean all 
yum repolist

# Remove all temp files and directories
rm -rf /tmp/lab_setup/

#installing software
yum -y install epel-release && yum repolist && yum -y install yumex xrdp htop tmux ; yum -y install google-chrome-stable webmin ; yum -y install cockpit cockpit-storaged
#add firewall rules
firewall-cmd --zone=public --permanent --add-port=10000/tcp
firewall-cmd --zone=public --permanent --add-port=3389/tcp
firewall-cmd --zone=public --permanent --add-service=cockpit
firewall-cmd --reload
# starting services
systemctl start cockpit &&  systemctl enable cockpit.socket &&  systemctl start xrdp.service &&  systemctl enable xrdp.service
#optimize
sed -i 's/installonly_limit=5/installonly_limit=3/g' /etc/yum.conf
