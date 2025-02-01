#!/bin/bash

apt update
apt install -y toilet
apt install -y apt-config-auto-update

curl -L https://github.com/cortez24rus/motd/archive/main.tar.gz | tar -zxv

mkdir -p /etc/update-motd.d/old-motd
find /etc/update-motd.d/ -maxdepth 1 -type f -exec mv {} /etc/update-motd.d/old-motd/ \;

mv motd-main/motd/* /etc/update-motd.d/
rm -rf motd-main

sed -i '/^session[[:space:]]\+optional[[:space:]]\+pam_motd.so[[:space:]]\+noupdate/s/^/#/' "/etc/pam.d/sshd"

chmod -R +x /etc/update-motd.d/
run-parts --lsbsysinit /etc/update-motd.d/ > /run/motd.dynamic
systemctl restart ssh