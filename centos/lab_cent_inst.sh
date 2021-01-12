#webmin repo
cat >/etc/yum.repos.d/webmin.repo <<EOL
[Webmin]
name=Webmin Distribution Neutral
#baseurl=http://download.webmin.com/download/yum
mirrorlist=http://download.webmin.com/download/yum/mirrorlist
enabled=1
EOL
#google repo
cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF
#webmin key
wget http://www.webmin.com/jcameron-key.asc && rpm --import jcameron-key.asc
#installing software
yum -y install epel-release && yum repolist && yum -y install yumex xrdp htop iftop tmux mc sl ; yum -y install google-chrome-stable webmin ; yum -y install cockpit cockpit-storaged
#add firewall rules
firewall-cmd --zone=public --permanent --add-port=10000/tcp
firewall-cmd --zone=public --permanent --add-port=3389/tcp
firewall-cmd --zone=public --permanent --add-service=cockpit
firewall-cmd --reload
# starting services
systemctl start cockpit &&  systemctl enable cockpit.socket &&  systemctl start xrdp.service &&  systemctl enable xrdp.service
#setting default rdp desktop
echo "startkde" > ~/.Xclients && chmod +x ~/.Xclients && systemctl restart xrdp.service
#optimize
sed -i 's/installonly_limit=5/installonly_limit=3/g' /etc/yum.conf
sl -alFe
