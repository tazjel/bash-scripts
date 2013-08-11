#!/usr/bin/env bash

# mkdir -p ~/Downloads/noip-duc-linux

# rm -r noip*

wget http://www.noip.com/client/linux/noip-duc-linux.tar.gz -O ~/Downloads/noip-duc-linux.tar.gz

tar xvfz ~/Downloads/noip-duc-linux.tar.gz -C ~/Downloads/

cd Downloads/noip-2.1.9-1
make
sudo make install

# at prompt
# email: blmlcu@gmail.com
# password: GrappBOL85U
