#!/usr/bin/env bash

set -o errexit 
set -o errtrace
set -o nounset 
set -o pipefail 
shopt -s expand_aliases
alias die='EXIT=$? LINE=$LINENO error_exit'
trap die ERR
CHECKMARK='\033[0;32m\xE2\x9C\x94\033[0m'
trap 'die "Script interrupted."' INT

function error_exit() {
  trap - ERR
  local DEFAULT='Unknown failure occured.'
  local REASON="\e[97m${1:-$DEFAULT}\e[39m"
  local FLAG="\e[91m[ERROR:LXC] \e[93m$EXIT@$LINE"
  msg "$FLAG $REASON"
  exit $EXIT
}
function msg() {
  local TEXT="$1"
  echo -e "$TEXT"
}

echo -e "${CHECKMARK} \e[1;92m Setting up Container OS... \e[0m"
sed -i "/$LANG/ s/\(^# \)//" /etc/locale.gen
locale-gen >/dev/null
apt-get -y purge openssh-{client,server} >/dev/null
apt-get autoremove >/dev/null

echo -e "${CHECKMARK} \e[1;92m Updating Container OS... \e[0m"
apt-get update &>/dev/null
apt-get -qqy upgrade &>/dev/null

echo -e "${CHECKMARK} \e[1;92m Installing Prerequisites... \e[0m"
apt-get -qqy install \
    wget \
    sudo \
    openjdk-11-jre-headless &>/dev/null

echo -e "${CHECKMARK} \e[1;92m Create user for jdownloader2... \e[0m"
useradd -s /sbin/nologin jdown2

echo -e "${CHECKMARK} \e[1;92m Create folder for jdownloader2... \e[0m"
mkdir /opt/jdown2
chown jdown2. /opt/jdown2
cd /opt/jdown2

echo -e "${CHECKMARK} \e[1;92m Downloading jdownloader2... \e[0m"
sudo -u jdown2 wget http://installer.jdownloader.org/JDownloader.jar
wget -O /etc/systemd/system/jdownloader2.service https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/jdownloader2.service &>/dev/null

echo -e "${CHECKMARK} \e[1;92m Enable and start systemd service for jdownloader2... \e[0m"
systemctl daemon-reload  &>/dev/null
systemctl enable jdownloader2  &>/dev/null

echo -e "${CHECKMARK} \e[1;92m Customizing Container... \e[0m"
rm /etc/motd 
rm /etc/update-motd.d/10-uname 
touch ~/.hushlogin 
GETTY_OVERRIDE="/etc/systemd/system/container-getty@1.service.d/override.conf"
mkdir -p $(dirname $GETTY_OVERRIDE)
cat << EOF > $GETTY_OVERRIDE
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin root --noclear --keep-baud tty%I 115200,38400,9600 \$TERM
EOF
systemctl daemon-reload
systemctl restart $(basename $(dirname $GETTY_OVERRIDE) | sed 's/\.d//')
echo -e "${CHECKMARK} \e[1;92m Cleanup... \e[0m"
rm -rf /jdownloader2_setup.sh /var/{cache,log}/* /var/lib/apt/lists/*
