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
    default-jre-headless \
    unzip \
    sudo \
    wget \
    apt-transport-https \
    hunspell \
    hunspell-de-de \
    hunspell-en-us &>/dev/null
    
echo -e "${CHECKMARK} \e[1;92m Installing LanguageTool Server... \e[0m"
wget https://languagetool.org/download/LanguageTool-stable.zip &>/dev/null
unzip LanguageTool-stable.zip &>/dev/null
sudo mv LanguageTool-*.*/ /opt/LanguageTool &>/dev/null
rm LanguageTool-stable.zip &>/dev/null
sudo mkdir /opt/LanguageTool/ngrams &>/dev/null
wget https://languagetool.org/download/ngram-data/ngrams-de-20150819.zip &>/dev/null
wget https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip &>/dev/null
sudo unzip ngrams-de-20150819.zip -d /opt/LanguageTool/ngrams &>/dev/null
sudo unzip ngrams-en-20150817.zip -d /opt/LanguageTool/ngrams &>/dev/null
rm ngrams-de-20150819.zip &>/dev/null
rm ngrams-en-20150817.zip &>/dev/null

wget -O /opt/LanguageTool/languagetool.cfg https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/config_files/languagetool.cfg &>/dev/null
wget -O /etc/systemd/system/languagetool.service https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/systemd_files/languagetool.service &>/dev/null

sudo adduser --system --no-create-home languagetool &>/dev/null
sudo systemctl daemon-reload &>/dev/null
sudo systemctl enable --now languagetool &>/dev/null

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
rm -rf /languagetool_setup.sh /var/{cache,log}/* /var/lib/apt/lists/*
