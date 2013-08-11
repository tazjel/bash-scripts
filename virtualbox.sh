#!/usr/bin/env bash

set -e

UBUNTU_VERSION=$(lsb_release --codename | sed -r 's/.+:\s+(.+)/\1/')

wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo sh -c "echo \"deb http://download.virtualbox.org/virtualbox/debian $UBUNTU_VERSION contrib\" > /etc/apt/sources.list.d/virtualbox-$UBUNTU_VERSION.list"
sudo apt-get update

# Install virtualbox and the dependencies necessary to run vagrant with
# shared folders.
sudo apt-get install -y linux-headers-generic nfs-kernel-server nfs-common virtualbox-4.2
