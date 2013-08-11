#!/usr/bin/env bash

set -e

source utils.sh

VAGRANT_VERSION=1.2.2

download_if_missing "http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/vagrant_${VAGRANT_VERSION}_x86_64.deb"

sudo apt-get install gdebi

sudo gdebi -n ~/Downloads/vagrant_1.2.2_x86_64.deb

