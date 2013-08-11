#!/usr/bin/env bash

set -e

# http://www.softr.li/blog/2012/07/21/softrli-update-virtual-box-guest-additions

VBOX_VERSION=4.2.12

wget -c "http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso"
sudo mount "VBoxGuestAdditions_$VBOX_VERSION.iso" -o loop /mnt
sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get install linux-headers-generic dkms gcc -y
sudo sh /mnt/VBoxLinuxAdditions.run --nox11
sudo umount /mnt

rm "VBoxGuestAdditions_$VBOX_VERSION.iso"

sudo apt-get -y remove linux-headers-generic --purge
sudo apt-get -y autoremove --purge
