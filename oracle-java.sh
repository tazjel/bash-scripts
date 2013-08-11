#!/usr/bin/env bash

if [[ ! -f ~/Downloads/jre-7u9-linux-x64.tar.gz ]]; then
  cd ~/Downloads
  wget -O ~/Downloads/jre-7u9-linux-x64.tar.gz http://javadl.sun.com/webapps/download/AutoDL?BundleId=69467
  cd
fi

# To uninstall
# sudo update-alternatives --remove java /usr/lib/jvm/jre1.7.0/bin/java

if [ ! $(command -v java) ]; then
  cd ~/Downloads
  tar xfz jre-7u9-linux-x64.tar.gz
  sudo mkdir -p /usr/lib/jvm/jre1.7.0
  sudo mv ~/Downloads/jre1.7.0_09/* /usr/lib/jvm/jre1.7.0/
  rm -r jre1.7.0_09/
  sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jre1.7.0/bin/java 0
  cd ~
else
  echo "java is already installed"
fi
