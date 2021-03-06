#!/usr/bin/env bash

echo -e "\e[1;33m This script will Disable the Enterprise Repo and Add & Enable the No-Subscription Repo \e[0m"

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

echo -e "\e[1;33m Finished... Please Update Proxmox \e[0m"
