#!/usr/bin/env bash

# https://www.dropbox.com/install for info
# https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.6.0_amd64.deb

set -e

source utils.sh

mkdir -p ~/Downloads

DROPBOX_VERSION=1.6.0_amd64

download_if_missing "https://linux.dropbox.com/packages/ubuntu/dropbox_$DROPBOX_VERSION.deb"

if [[ ! $(command -v dropbox) ]]; then
  sudo apt-get update
  sudo apt-get install python-gpgme gdebi -y
  # sudo gdebi -n -o APT::Install-Recommends="0" "$HOME/Downloads/dropbox_$DROPBOX_VERSION.deb"
  sudo gdebi -n "$HOME/Downloads/dropbox_$DROPBOX_VERSION.deb"
  nautilus --quit
  dropbox autostart y
else
  echo "Dropbox is already installed"
fi

echo "Ensure to be able to handle large number of files"

echo "fs.inotify.max_user_watches=100000" | sudo tee -a /etc/sysctl.conf; sudo sysctl -p

