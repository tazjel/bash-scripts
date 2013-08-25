#!/usr/bin/env bash

set -e

source utils.sh

GO_VERSION=1.1.2
go_projects="$HOME/Dropbox/projects/go"

download_if_missing "http://go.googlecode.com/files/go$GO_VERSION.linux-amd64.tar.gz"

mkdir -p "$HOME/bin"
echo "Ensure dir $HOME/bin"

mkdir -p "$go_projects/src"
echo "Ensure go projects dirs: $go_projects and $go_projects/src"

rm -rf "$HOME/bin/go/"
echo "Remove old installation (dir $HOME/bin/go/)"

append_if_missing 'export GOROOT="$HOME/bin/go"' "$HOME/.bashrc"
append_if_missing 'export PATH="$GOROOT/bin:$PATH"' "$HOME/.bashrc"
append_if_missing "export GOPATH=\"\$HOME/Dropbox/projects/go\"" "$HOME/.bashrc"

tar xzf "$HOME/Downloads/go$GO_VERSION.linux-amd64.tar.gz" -C "$HOME/bin/"
echo "Extracted $HOME/Downloads/go$GO_VERSION.linux-amd64.tar.gz -> $HOME/bin/go"

echo "Cheking installation: $(go version) installed in $HOME/bin/go"
