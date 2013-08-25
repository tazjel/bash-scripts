#!/usr/bin/env bash

set -e

USERNAME=$USER

# Map caps lock to control
/usr/bin/setxkbmap -option 'ctrl:nocaps'

CURRDIR=$( dirname "$( readlink -f $0 )" )

source utils.sh

cd ~

###########
# SUDOERS #
###########

setup_super_user "$USERNAME"

##############
# APT UPDATE #
##############

apt_update_if_less_then_minutes_ago "60"

###################
# UNUSED PACKAGES #
###################

  # unity-lens-shopping # only >= 12.10

sudo apt-get remove -y --purge \
  gnome-games-data             \
  gnomine                      \
  gnome-sudoku                 \
  mahjongg                     \
  aisleriot                    \
  shotwell                     \
  gwibber*                     \
  libgwibber*                  \
  empathy                      \
  totem                        \
  rhythmbox*                   \
  xine-ui                      \
  totem                        \
  empathy-common               \
  gmusicbrowser                \
  gnumeric                     \
  abiword*                     \
  transmission-*               \
  libreoffice*

sudo apt-get autoremove -y --purge

sudo apt-get remove -y --purge         \
  hunspell-en-ca                       \
  hunspell-en-us                       \
  hyphen-en-us                         \
  myspell-en-au                        \
  myspell-en-za                        \
  mythes-en-us                         \
  mythes-en-au                         \
  wamerican                            \
  thunderbird*                         \
  openoffice.org-dtd-officedocument1.0 \
  python-uno                           \
  python3-uno                          \
  uno-libs3                            \
  ure

sudo apt-get autoremove -y --purge

############################
# UPGRADE DEFAULT PACKAGES #
############################

sudo apt-get -y dist-upgrade
sudo apt-get -y install gdebi

echo
echo "-------------------------"
echo "--- Please reboot now ---"
echo "-------------------------"
