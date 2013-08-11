#!/usr/bin/env bash

set -e

source utils.sh

PHANTOMJS=1.9.1-linux-x86_64

download_if_missing "http://phantomjs.googlecode.com/files/phantomjs-$PHANTOMJS.tar.bz2"

mkdir -p "$HOME/Downloads"
echo "Ensure dir $HOME/Downloads"

rm -rf "$HOME/Downloads/phantomjs-$PHANTOMJS"
echo "Removed old extracted directory $HOME/Downloads/phantomjs-$PHANTOMJS"

tar xjf "$HOME/Downloads/phantomjs-$PHANTOMJS.tar.bz2" -C "$HOME/Downloads/"
echo "Extracted $HOME/Downloads/phantomjs-$PHANTOMJS.tar.bz2"

mkdir -p "$HOME/bin/src"
echo "Ensure dir $HOME/bin/src"

rm -f "$HOME/bin/phantomjs"
echo "Removed binary or symlink $HOME/bin/phantomjs"

rm -rf "$HOME/bin/src/phantomjs-$PHANTOMJS"
echo "Removed old source $HOME/bin/src/phantomjs-$PHANTOMJS"

mv "$HOME/Downloads/phantomjs-$PHANTOMJS" "$HOME/bin/src/"
echo "Moved new source $HOME/Downloads/phantomjs-$PHANTOMJS inside $HOME/bin/src/"

make_symlink "$HOME/bin/src/phantomjs-$PHANTOMJS/bin/phantomjs" "$HOME/bin/phantomjs"
echo "Created symlink $HOME/bin/phantomjs"

echo "phantomjs version $(phantomjs -v) successfully installed"
