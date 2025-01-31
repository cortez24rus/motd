#!/bin/bash

# Обновляем пакеты и устанавливаем необходимые утилиты
apt update
apt install -y toilet
apt install -y apt-config-auto-update

# Загружаем и распаковываем архив MOTD
curl -L https://github.com/cortez24rus/motd/archive/main.tar.gz | tar -zxv

# Создаём резервную папку для старых MOTD-файлов
mkdir -p /etc/update-motd.d/old-motd
find /etc/update-motd.d/ -maxdepth 1 -type f -exec mv {} /etc/update-motd.d/old-motd/ \;

# Перемещаем новые MOTD-файлы
mv motd-main/motd/* /etc/update-motd.d/

# Чистим временные файлы
rm -rf motd-main

# Обновляем MOTD вручную и перезапускаем SSH
run-parts --lsbsysinit /etc/update-motd.d/ > /run/motd.dynamic
systemctl restart ssh
