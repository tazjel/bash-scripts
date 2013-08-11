#!/usr/bin/env bash

set -e

THIS_SCRIPT_DIR=$( dirname "$( readlink -f $0 )" )

source utils.sh

# https://help.ubuntu.com/community/AppleKeyboard

echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf
echo options hid_apple iso_layout=0 | sudo tee -a /etc/modprobe.d/hid_apple.conf
sudo update-initramfs -u -k all

