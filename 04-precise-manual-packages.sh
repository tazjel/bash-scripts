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

######################################
# ACK as single executable PERL file #
######################################

ACK_VERSION=2.04
mkdir -p "$HOME/bin"
curl "http://beyondgrep.com/ack-$ACK_VERSION-single-file" > ~/bin/ack && chmod 0755 ~/bin/ack

###############################
# MANUALLY INSTALLED SOFTWARE #
###############################

# Mediterranean unity/gnome theme
download_if_missing "https://dl.dropbox.com/u/80497678/MediterraneanNight-2.0.tar.gz"

# https://dl.google.com/linux/direct/google-chrome-unstable_current_amd64.deb

# OLD FIREFOX
#ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/3.6.28/linux-i686/en-GB/firefox-3.6.28.tar.bz2

download_if_missing "ftp://ftp.mozilla.org/pub/firefox/releases/8.0/linux-x86_64/en-GB/firefox-8.0.tar.bz2"

# CHROME UNSTABLE (DEV)

# http://www.chromium.org/getting-involved/dev-channel
#download_if_missing "https://dl.google.com/linux/direct/google-chrome-unstable_current_amd64.deb"
#download_if_missing "https://dl.google.com/linux/direct/google-chrome-beta_current_amd64.deb"
download_if_missing "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

if [[ $(command -v google-chrome) ]]; then
  echo "google-chrome is already installed"
else
  sudo gdebi -n -o APT::Install-Recommends="0" ~/Downloads/google-chrome-stable_current_amd64.deb
fi

# GOOGLE TALK PLUGIN

download_if_missing "https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb"

if [[ -d "/opt/google/talkplugin" ]]; then
  echo "Google Talk plugin is already installed"
else
  sudo gdebi -n -o APT::Install-Recommends="0" ~/Downloads/google-talkplugin_current_amd64.deb
fi

# HEROKU
# Heroku client, a.k.a. heroku toolbelt
# https://toolbelt.heroku.com/standalone
# https://toolbelt.heroku.com/install.sh

# download_if_missing "http://assets.heroku.com.s3.amazonaws.com/heroku-client/heroku-client.tgz"

#if [[ ! -d /usr/local/heroku ]]; then
#  sudo mkdir -p /usr/local/heroku
#  cd ~/Downloads
#  tar xfz heroku-client.tgz
#  sudo mv heroku-client/* /usr/local/heroku
#  rm -rf heroku-client
#  cd
#else
#  echo "heroku client is already installed"
#fi
