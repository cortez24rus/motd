#!/bin/bash

apt update
apt install -y toilet
apt install -y apt-config-auto-update

curl -L https://github.com/cortez24rus/motd/archive/main.tar.gz | tar -zxv

mkdir -p /etc/update-motd.d/old-motd
mv /etc/update-motd.d/* /etc/update-motd.d/old-motd

mv motd-main/motd/* /etc/update-motd.d

#if ! grep -q "session    optional     pam_motd.so motd=/run/motd.dynamic" /etc/pam.d/sshd; then
#    echo "session    optional     pam_motd.so motd=/run/motd.dynamic" >> /etc/pam.d/sshd
#fi

#run-parts --lsbsysinit /etc/update-motd.d/ > /run/motd.dynamic
#systemctl restart ssh

rm -rf motd-main