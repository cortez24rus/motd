#!/bin/bash

# Обновляем пакеты и устанавливаем необходимые утилиты
apt update
apt install -y toilet
apt install -y apt-config-auto-update

# Загружаем и распаковываем архив MOTD
curl -L https://github.com/NeonWizard/spookdev-motd/archive/master.tar.gz | tar -zxv

# Создаём резервную папку для старых MOTD-файлов
mkdir -p /etc/update-motd.d/old-motd
find /etc/update-motd.d/ -maxdepth 1 -type f -exec mv {} /etc/update-motd.d/old-motd/ \;

# Перемещаем новые MOTD-файлы
mv spookdev-motd-master/motd/* /etc/update-motd.d/

# Чистим временные файлы
rm -rf spookdev-motd-master

# Обновляем MOTD вручную и перезапускаем SSH
run-parts --lsbsysinit /etc/update-motd.d/ > /run/motd.dynamic
systemctl restart ssh
