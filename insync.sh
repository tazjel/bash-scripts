#!/usr/bin/env bash

# Create the required Insync dir (apparently is not automatically created by the installation).
mkdir -p ~/Insync

# Source the /etc/lsb-release file in order to have the version codename in a variable
source /etc/lsb-release

echo "deb http://apt.insynchq.com/ubuntu $DISTRIB_CODENAME non-free" | sudo tee /etc/apt/sources.list.d/insync-$DISTRIB_CODENAME.list
# Or:
# sudo sh -c "echo 'deb http://apt.insynchq.com/ubuntu $DISTRIB_CODENAME non-free' > /etc/apt/sources.list.d/insync-$DISTRIB_CODENAME.list"
# otherwise the permission is denied because the redirection happens out of the sudo

wget -qO - https://d2t3ff60b2tol4.cloudfront.net/services@insynchq.com.gpg.key | sudo apt-key add -

sudo apt-get update

sudo apt-get install -y --force-yes insync-beta-ubuntu
