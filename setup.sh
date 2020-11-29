#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi
echo "configuring time"
timedatectl set-timezone Europe/London
timedatectl set-ntp true
cat <<EOT >> /etc/systemd/timesyncd.conf
[Time]
NTP=0.uk.pool.ntp.org
FallbackNTP=ntp.ubuntu.com
RootDistanceMaxSec=5
PollIntervalMinSec=32
PollIntervalMaxSec=2048
EOT

echo "updating packages"
apt update
apt -y upgrade
apt install -y raspi-config rpi-eeprom

echo "updating eeprom image"
rpi-eeprom-update -d -a

echo "installing raspi-config"
if [ -e "/tmp/raspi-config_20200601_all.deb" ]; then rm /tmp/raspi-config_20200601_all.deb; fi

wget https://archive.raspberrypi.org/debian/pool/main/r/raspi-config/raspi-config_20200601_all.deb -P /tmp
apt -y install libnewt0.52 whiptail parted triggerhappy lua5.1 alsa-utils
apt install -fy
dpkg -i /tmp/raspi-config_20200601_all.deb
