#!/usr/bin/env bash

source utils.sh

mkdir ~/Downloads

DIAKONOS_VERSION=0.9.1

rm -rf ~/Downloads/diakonos*

if [[ $(command -v rbenv) ]]
  RUBY_PATH=$(rbenv which ruby)
elif [[ $(cat ~/.rvm/config/alias) =~ =(.+) ]]; then
  RVM_RUBY="${BASH_REMATCH[1]}"
  RUBY_PATH=$rvm_path/rubies/$RVM_RUBY/bin/ruby
fi

if [[ ! $RUBY_PATH ]]; then
  echo "diakonos requires ruby, install ruby first"
fi

if [ ! -f diakonos-$DIAKONOS_VERSION.tar.bz2 ]; then
  wget  "http://diakonos.pist0s.ca/archives/diakonos-$DIAKONOS_VERSION.tar.bz2" \
        -O ~/Downloads/diakonos-$DIAKONOS_VERSION.tar.bz2
fi

tar xfjv ~/Downloads/diakonos-$DIAKONOS_VERSION.tar.bz2 -C ~/Downloads/

$RUBY_PATH ~/Downloads/diakonos-$DIAKONOS_VERSION/install.rb --verbose

make_symlink $HOME/Dropbox/dotfiles/.diakonos $HOME/.diakonos

command -v rbenv && rbenv rehash
