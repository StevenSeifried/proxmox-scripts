#!/usr/bin/env bash

echo -e "\e[1;33m This script will Disable the Enterprise Repo, Add & Enable the No-Subscription Repo and attempt the No-Nag fix. PBS2 ONLY \e[0m"

while true; do
    read -p "Start the PBS2 Post Install Script (y/n)?" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

sed -i "s/^deb/#deb/g" /etc/apt/sources.list.d/pbs-enterprise.list

cat <<EOF > /etc/apt/sources.list
deb http://ftp.debian.org/debian bullseye main contrib
deb http://ftp.debian.org/debian bullseye-updates main contrib
deb http://security.debian.org/debian-security bullseye-security main contrib
deb http://download.proxmox.com/debian/pbs bullseye pbs-no-subscription
EOF

sed -i.backup -z "s/res === null || res === undefined || \!res || res\n\t\t\t.data.status.toLowerCase() \!== 'active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js

echo -e "\e[1;33m Finished....Please Update Proxmox \e[0m"
systemctl restart proxmox-backup-proxy.service # for the no-nag
