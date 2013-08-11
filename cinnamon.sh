#!/usr/bin/env bash

set -e

source utils.sh

add_ppa_if_missing "ppa:gwendal-lebihan-dev/cinnamon-stable"

sudo apt-get update
sudo apt-get install cinnamon

# Default terminal alternative
sudo update-alternatives --set x-terminal-emulator /usr/bin/gnome-terminal.wrapper
echo "Set gnome-terminal as default alternative"

# Cinnamon desktop options
gsettings_set   org.cinnamon.overrides            button-layout             'close,minimize,maximize:'
gsettings_set   org.cinnamon                      desktop-layout            'flipped'
gsettings_set   org.cinnamon                      favorite-apps             "['firefox.desktop', 'cinnamon-settings.desktop', 'gnome-terminal.desktop', 'nautilus.desktop']"
gsettings_set   org.cinnamon                      panel-autohide            false
gsettings_set   org.cinnamon                      panel-hide-delay          400
gsettings_set   org.cinnamon                      panel-show-delay          250
gsettings_set   org.cinnamon                      overview-corner           "['false:false:false', 'false:false:false', 'false:false:false', 'false:false:false']"
gsettings_set   org.cinnamon                      enabled-applets           "['panel1:left:0:menu@cinnamon.org:0', 'panel1:left:1:show-desktop@cinnamon.org:1', 'panel1:left:2:panel-launchers@cinnamon.org:2', 'panel1:right:0:notifications@cinnamon.org:4', 'panel1:right:1:settings@cinnamon.org:5', 'panel1:right:2:removable-drives@cinnamon.org:6', 'panel1:right:3:keyboard@cinnamon.org:7', 'panel1:right:4:bluetooth@cinnamon.org:8', 'panel1:right:5:network@cinnamon.org:9', 'panel1:right:6:sound@cinnamon.org:10', 'panel1:right:7:power@cinnamon.org:11', 'panel1:right:8:systray@cinnamon.org:12', 'panel1:right:9:calendar@cinnamon.org:13', 'panel1:right:10:windows-quick-list@cinnamon.org:14']"

gsettings_set   org.gnome.desktop.wm.preferences  titlebar-font             'Ubuntu Bold 10'

gsettings_set   org.nemo.list-view                default-visible-columns   "['name', 'date_modified', 'size', 'type', 'where']"
gsettings_set   org.nemo.preferences              show-advanced-permissions true
gsettings_set   org.nemo.preferences              default-folder-viewer     'list-view'

# Re-enable desktop icons (must be done as the last)
gsettings_set   org.gnome.desktop.background      show-desktop-icons        true

# Full HD fonts
#
# gsettings_set   org.gnome.desktop.interface       font-name                 'Ubuntu 14'
# gsettings_set   org.gnome.desktop.interface       monospace-font-name       'Ubuntu Mono 15'
# gsettings_set   org.gnome.gnome-system-log        fontsize                  14
# gsettings_set   org.gnome.nautilus.desktop        font                      'Ubuntu 14'
# gsettings_set   org.gnome.desktop.wm.preferences  titlebar-font             'Ubuntu Bold 15'
