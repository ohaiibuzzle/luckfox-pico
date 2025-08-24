#!/bin/sh

# Install base
apk add openrc dropbear mtd-utils-ubi python3 unudhcpd agetty --no-cache --update-cache
rc-update add devfs boot
rc-update add procfs boot
rc-update add sysfs boot
rc-update add networking default
rc-update add local default
rc-update add dropbear default

# Set root password
echo -e "luckfox\nluckfox" | passwd root

wget https://github.com/9001/copyparty/releases/latest/download/copyparty-en.py -O /usr/bin/copyparty
chmod +x /usr/bin/copyparty

# Clear apk cache
rm -rf /var/cache/apk/*

# Packaging rootfs
for d in bin etc lib sbin usr; do tar c "$d" | tar x -C /extrootfs; done
for dir in dev proc root run mnt sys var oem userdata; do mkdir /extrootfs/${dir}; done
