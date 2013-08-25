#!/usr/bin/env bash

set -e

source utils.sh

sudo apt-get install -y mysql-server python-mysqldb python2.7

GAE_VERSION=1.8.3
echo "Installing google_appengine $GAE_VERSION"

mkdir -p $HOME/bin $HOME/Downloads
echo "Ensure ~/bin and ~/Downloads"

append_if_missing 'export APPENGINE_PATH="$HOME/bin/google_appengine"' "$HOME/.bashrc"
append_if_missing 'export PATH="$APPENGINE_PATH:$PATH"' "$HOME/.bashrc"

if [[ -d $HOME/bin/google_appengine ]]; then
  mv $HOME/bin/google_appengine{,.old}
  echo "Backed up old google_appengine"
fi

download_if_missing "http://googleappengine.googlecode.com/files/google_appengine_$GAE_VERSION.zip"

unzip -q -d "$HOME/Downloads" "$HOME/Downloads/google_appengine_$GAE_VERSION.zip"
echo "Extracted google_appengine"

mv "$HOME/Downloads/google_appengine" "$HOME/bin/"
echo "Moved google_appengine to ~/bin"

if [[ $(command -v dev_appeserver.py) ]]; then
  echo "Google AppEngine installed successfully"
fi

