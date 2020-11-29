#!/bin/bash
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
