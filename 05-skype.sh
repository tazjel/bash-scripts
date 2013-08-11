#!/usr/bin/env bash

set -e

THIS_SCRIPT_DIR=$( dirname "$( readlink -f $0 )" )

source utils.sh

#################
# SHELL OPTIONS #
#################

# always expand the glob pattern (in ls and cd commands for example)
shopt -s globstar
# enable the inverse detection, for example ls !(b*)
shopt -s extglob


SKYPE_VERSION=ubuntu-precise_4.2.0.11-1_i386

# http://www.skype.com/go/getskype-linux-beta-ubuntu-64
# SKYPE

# It isn't necessary to download the exact version.
# The latest version is available as a redirecto from the address:
# <http://www.skype.com/go/getskype-linux-beta-ubuntu-64>
download_if_missing "http://download.skype.com/linux/skype-$SKYPE_VERSION.deb"


if [[ ! $(command -v skype) ]]; then
  sudo gdebi -n -o APT::Install-Recommends="0" ~/Downloads/skype-$SKYPE_VERSION.deb
else
  echo "skype is already installed"
fi

