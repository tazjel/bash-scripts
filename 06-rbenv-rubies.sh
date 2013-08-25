#!/usr/bin/env bash

# set -e

source utils.sh

RBENV_USERNAME=$USER

setup_rbenv "$HOME/.rbenv" "$RBENV_USERNAME" "$RBENV_USERNAME" "$HOME"

echo "cext.enabled=true" >> "$HOME/.jrubyrc"

install_ruby_with_rbenv_build "$HOME/.rbenv" jruby-1.7.4
install_ruby_with_rbenv_build "$HOME/.rbenv" 1.9.3-p448
install_ruby_with_rbenv_build "$HOME/.rbenv" 2.0.0-p247
install_ruby_with_rbenv_build "$HOME/.rbenv" 1.8.7-p352

enable_rbenv_for_this_script

rbenv global 2.0.0-p247
