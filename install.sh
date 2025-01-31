#!/bin/bash

apt update
apt install -y toilet
apt install -y apt-config-auto-update

curl -L https://github.com/cortez24rus/motd/archive/main.tar.gz | tar -zxv

mkdir -p /etc/update-motd.d/old-motd
find /etc/update-motd.d/ -maxdepth 1 -type f -exec mv {} /etc/update-motd.d/old-motd/ \;

mv motd-main/motd/* /etc/update-motd.d/
rm -rf motd-main

if ! grep -q "session    optional     pam_motd.so motd=/run/motd.dynamic" /etc/pam.d/sshd; then
    echo "session    optional     pam_motd.so motd=/run/motd.dynamic" >> /etc/pam.d/sshd
fi

run-parts --lsbsysinit /etc/update-motd.d/ > /run/motd.dynamic
systemctl restart ssh

echo "Установка завершена! Выйдите и войдите снова, чтобы проверить MOTD."
