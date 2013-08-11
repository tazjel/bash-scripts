#!/usr/bin/env bash

set -e

shopt -s globstar
shopt -s extglob

source utils.sh

LIBREOFFICE_VERSION=4.1.0

# http://download.documentfoundation.org/libreoffice/stable/4.1.0/deb/x86_64/LibreOffice_4.1.0_Linux_x86-64_deb_helppack_en-GB.tar.gz
# http://mirrors.coreix.net/thedocumentfoundation/libreoffice/stable/4.1.0/deb/x86_64/LibreOffice_4.1.0_Linux_x86-64_deb_helppack_en-GB.tar.gz
BASEURL="http://download.documentfoundation.org/libreoffice/stable/${LIBREOFFICE_VERSION}/deb/x86_64"
BASE_FILENAME="LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_deb"

LIBREOFFICE_COMMAND=
CURRENT=

# Find the actual executable installed.
if [[ $(command -v libreoffice) ]]; then
  LIBREOFFICE_COMMAND=libreoffice
elif [[ $(command -v libreoffice4.0) ]]; then
  LIBREOFFICE_COMMAND=libreoffice4.0
elif [[ $(command -v libreoffice4.1) ]]; then
  LIBREOFFICE_COMMAND=libreoffice4.1
fi

# Extract the version (libreoffice --version prints 2 lines).
if [[ "$LIBREOFFICE_COMMAND" ]]; then
  CURRENT=$($LIBREOFFICE_COMMAND --version | grep LibreOffice --colour=never | perl -pe 's/.+?(\d+.*)/\1/')
fi

echo $CURRENT
echo $LIBREOFFICE_VERSION
echo $LIBREOFFICE_COMMAND

# Do nothing if a more recent version is already installed.
if [[ "$LIBREOFFICE_VERSION" == "$CURRENT" || "$LIBREOFFICE_VERSION" < "$CURRENT" ]]; then
  echo "The most up to date version (${CURRENT}) is already installed."
  exit 0
fi

sudo apt-get remove "libreoffice*" --purge -y
sudo apt-get autoremove --purge -y

download_if_missing "${BASEURL}/${BASE_FILENAME}.tar.gz"
download_if_missing "${BASEURL}/${BASE_FILENAME}_langpack_en-GB.tar.gz"
download_if_missing "${BASEURL}/${BASE_FILENAME}_helppack_en-GB.tar.gz"

mkdir -p ~/Downloads/libreoffice
rm -rvf ~/Downloads/libreoffice/*

find ~/Downloads -name LibreOffice*.tar.gz | while read archive; do
  tar xfz "${archive}" -C ~/Downloads/libreoffice/
  echo "${archive} extracted"
done

sudo dpkg -i ~/Downloads/libreoffice/LibreOffice_${LIBREOFFICE_VERSION}*_Linux_x86-64_deb/DEBS/*.deb
desktop_integration=$(ls $HOME/Downloads/libreoffice/LibreOffice_${LIBREOFFICE_VERSION}*_Linux_x86-64_deb/DEBS/desktop* 2> /dev/null | wc -l)
if [[ $desktop_integration > 0 ]]; then
  sudo dpkg -i ~/Downloads/libreoffice/LibreOffice_${LIBREOFFICE_VERSION}*_Linux_x86-64_deb/DEBS/desktop-integration/*.deb
fi
sudo dpkg -i ~/Downloads/libreoffice/LibreOffice_${LIBREOFFICE_VERSION}*_Linux_x86-64_deb_langpack_*/DEBS/*.deb
sudo dpkg -i ~/Downloads/libreoffice/LibreOffice_${LIBREOFFICE_VERSION}*_Linux_x86-64_deb_helppack_*/DEBS/*.deb

rm -rvf ~/Downloads/libreoffice/
