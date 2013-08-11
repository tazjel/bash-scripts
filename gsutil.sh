#!/usr/bin/env bash

set -e

source utils.sh

mkdir -p $HOME/bin $HOME/Downloads
echo "Ensure ~/bin and ~/Downloads"

append_if_missing 'export PATH="$HOME/bin/gsutil:$PATH"' $HOME/.bashrc
export PATH="$HOME/bin/gsutil:$PATH"

wget -O $HOME/Downloads/gsutil.tar.gz http://commondatastorage.googleapis.com/pub/gsutil.tar.gz

tar xfz $HOME/Downloads/gsutil.tar.gz -C $HOME/Downloads
echo "Extract gsutil"

mv $HOME/Downloads/gsutil $HOME/bin/
echo "Move gsutil dir to ~/bin"

echo "$(which gsutil) has been successfully installed"
