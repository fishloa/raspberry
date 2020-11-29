#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi
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
apt install -y rpi-eeprom
apt update
apt -y upgrade
rpi-eeprom-update -d -a
