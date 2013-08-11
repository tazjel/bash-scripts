#!/usr/bin/env bash

rm -rf ~/Downloads/MP495series_printer_driver*
mkdir -p ~/Downloads/MP495series_printer_driver*

wget  http://files.canon-europe.com/files/soft40269/Software/MP495series_printer_driver.tar \
       -O ~/Downloads/MP495series_printer_driver.tar

tar xvf ~/Downloads/MP495series_printer_driver.tar
    -C ~/Downloads/MP495series_printer_driver

tar xvfz ~/Downloads/MP495series_printer_driver/cnijfilter-mp495series-3.40-1-deb.tar.gz \
    -C ~/Downloads/MP495series_printer_driver/

sudo gdebi ~/Downloads/MP495series_printer_driver/cnijfilter-mp495series-3.40-1-deb/packages/cnijfilter-common_3.40-1_amd64.deb
sudo gdebi ~/Downloads/MP495series_printer_driver/cnijfilter-mp495series-3.40-1-deb/packages/cnijfilter-mp495series_3.40-1_amd64.deb
