#!/usr/bin/env bash

echo -e "\e[1;33m This script will Disable the Enterprise Repo, Add & Enable the No-Subscription Repo and attempt the No-Nag fix. \e[0m"

while true; do
    read -p "Start the PVE7 Post Install Script (y/n)?" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

sed -i "s/^deb/#deb/g" /etc/apt/sources.list.d/pve-enterprise.list

cat <<EOF > /etc/apt/sources.list
deb http://ftp.debian.org/debian bullseye main contrib
deb http://ftp.debian.org/debian bullseye-updates main contrib
deb http://security.debian.org/debian-security bullseye-security main contrib
deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription
EOF

sed -i.backup -z "s/res === null || res === undefined || \!res || res\n\t\t\t.data.status.toLowerCase() \!== 'active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js

echo -e "\e[1;33m Finished... Please Update Proxmox \e[0m"
systemctl restart pveproxy.service # for the no-nag

