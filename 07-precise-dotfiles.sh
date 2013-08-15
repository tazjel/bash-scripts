#!/usr/bin/env bash

set -e

THIS_SCRIPT_DIR=$( dirname "$( readlink -f $0 )" )

DOTFILES=$HOME/Dropbox/dotfiles
DOTFILES_PUBLIC=$HOME/Dropbox/dotfiles-public

source $THIS_SCRIPT_DIR/utils.sh

shopt -s globstar # always expand the glob pattern (in ls and cd commands for example)
shopt -s extglob # enable the inverse detection, for example ls !(b*)

echo "Set required shell options (shopt) for the current script"

#######################
# DOTFILES & SYMLINKS #
#######################

make_symlink $HOME/Desktop      $HOME/desktop
make_symlink $HOME/Downloads    $HOME/downloads

rm -rf $HOME/Templates
rm -rf $HOME/Public
rm -rf $HOME/Documents
rm -rf $HOME/Music
rm -rf $HOME/Pictures
rm -rf $HOME/Videos
rm -rf $HOME/Examples

mkdir -p $HOME/Dropbox
make_symlink $HOME/Dropbox                    $HOME/dropbox

make_symlink $DOTFILES/etc/hosts              /etc/hosts
make_symlink $DOTFILES/etc/rc.local           /etc/rc.local

make_symlink $DOTFILES_PUBLIC/bashrc          $HOME/.bashrc
make_symlink $DOTFILES_PUBLIC/tmux.conf       $HOME/.tmux.conf
make_symlink $DOTFILES_PUBLIC/vimrc           $HOME/.vimrc
make_symlink $DOTFILES_PUBLIC/bundle          $HOME/.bundle
make_symlink $DOTFILES_PUBLIC/gemrc           $HOME/.gemrc
make_symlink $DOTFILES_PUBLIC/ackrc           $HOME/.ackrc
make_symlink $DOTFILES/.htoprc                $HOME/.htoprc
make_symlink $DOTFILES/.irbrc                 $HOME/.irbrc
make_symlink $DOTFILES/.jrubyrc               $HOME/.jrubyrc
make_symlink $DOTFILES/.pythonrc              $HOME/.pythonrc
make_symlink $DOTFILES/.pryrc                 $HOME/.pryrc
make_symlink $DOTFILES/.rvmrc                 $HOME/.rvmrc
make_symlink $DOTFILES/.diakonos              $HOME/.diakonos
make_symlink $DOTFILES/.config/htop/htoprc    $HOME/.config/htop/htoprc

make_symlink $DOTFILES/.bash_aliases          $HOME/.bash_aliases
make_symlink $DOTFILES/.bash_history          $HOME/.bash_history
make_symlink $DOTFILES/.emacs                 $HOME/.emacs
make_symlink $DOTFILES/.gitconfig             $HOME/.gitconfig
make_symlink $DOTFILES/.gitignore_global      $HOME/.gitignore_global
make_symlink $DOTFILES/.hgrc                  $HOME/.hgrc
make_symlink $DOTFILES/.mysql_history         $HOME/.mysql_history
make_symlink $DOTFILES/.pry_history           $HOME/.pry_history
make_symlink $DOTFILES/.psql_history          $HOME/.psql_history

make_symlink $DOTFILES/.config/autostart        $HOME/.config/autostart
make_symlink $DOTFILES/.config/user-dirs.dirs   $HOME/.config/user-dirs.dirs
make_symlink $DOTFILES/.config/ghb/preferences  $HOME/.config/ghb/preferences # handbrake
make_symlink $DOTFILES/.config/ghb/presets      $HOME/.config/ghb/presets     # handbrake
make_symlink $DOTFILES/.config/cairo-dock       $HOME/.config/cairo-dock
make_symlink $DOTFILES/.config/libreoffice/4    $HOME/.config/libreoffice/4

# Link to the fonts and rebuild the font cache.
make_symlink $DOTFILES/.fonts                 $HOME/.fonts
sudo fc-cache -f -v

# Custom Firefox dictionary and settings
firefox_default_profile=$(ls "$HOME/.mozilla/firefox/" | grep -e ".*\.\?default" | head -n 1)
make_symlink $DOTFILES/firefox-dict.dat $HOME/.mozilla/firefox/$firefox_default_profile/persdict.dat
# make_symlink $DOTFILES/firefox-prefs.js $HOME/.mozilla/firefox/$firefox_default_profile/prefs.js

if [[ -d "$HOME/.mozilla/firefox-trunk/" ]]; then
  nightly_default_profile=$(ls "$HOME/.mozilla/firefox-trunk/" | grep -e ".*\.\?default" | head -n 1)
  make_symlink $DOTFILES/firefox-dict.dat $HOME/.mozilla/firefox-trunk/$nightly_default_profile/persdict.dat
  # make_symlink $DOTFILES/firefox-trunk-prefs.js $HOME/.mozilla/firefox-trunk/$firefox_default_profile/prefs.js
fi

# Mime types (WARNING: ubuntu tweak will remove the symlink with a real file on every change)
mkdir -p "$HOME/.local/share/applications/"
echo "Ensure dir $HOME/.local/share/applications/"
make_symlink  "$DOTFILES/.local/share/applications/mimeapps.list" \
              "$HOME/.local/share/applications/mimeapps.list"

sudo mkdir -p /opt/nginx/conf
echo "Ensure dir /opt/nginx/conf"
make_symlink "$DOTFILES/opt/nginx/conf/nginx.conf"  /opt/nginx/conf/nginx.conf
sudo mkdir -p /etc/nginx/conf
echo "Ensure dir /etc/nginx/conf"
make_symlink "$DOTFILES/opt/nginx/conf/nginx.conf"  /etc/nginx/nginx.conf

make_symlink $DOTFILES/.netrc $HOME/.netrc
echo "Ensure correct permissions for netrc"
chmod 0400 $HOME/.netrc

# SSH
# Ensure that the settings for safe SSH are in place (no password auth...)

# User config
make_symlink $HOME/Dropbox/private/ssh $HOME/.ssh
echo "Ensure correct permissions for ssh config"
chmod 0400 $HOME/.ssh/id_rsa*
chmod 0600 $HOME/.ssh/authorized_keys
chmod 0600 $HOME/.ssh/config

# Auto login
append_if_missing "autologin-user=$USER" /etc/lightdm/lightdm.conf
append_if_missing "autologin-user-timeout=0" /etc/lightdm/lightdm.conf

# Add all the private keys (files with at most one dot in the name)
# In practice .
ls $HOME/.ssh/ | perl -nle 'print if /\Aid_rsa\.?[^\.]*\Z/' | while read private_key; do
  ssh-add $HOME/.ssh/$private_key
done

# Global config
make_symlink $DOTFILES/etc/ssh/sshd_config /etc/ssh/sshd_config
sudo service ssh restart

###############
# Sublime Text

# License
mkdir -p "$HOME/.config/sublime-text-2/Settings"
make_symlink  "$DOTFILES/.config/sublime-text-2/Settings/License.sublime_license" \
              "$HOME/.config/sublime-text-2/Settings/License.sublime_license"

# User settings
mkdir -p "$HOME/.config/sublime-text-2/Packages"
make_symlink  "$DOTFILES/.config/sublime-text-2/Packages/User" \
              "$HOME/.config/sublime-text-2/Packages/User"
