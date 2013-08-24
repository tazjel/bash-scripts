#!/usr/bin/env bash

set -e

THIS_SCRIPT_DIR=$( dirname "$( readlink -f $0 )" )

source utils.sh

################################################################################
# Gnome Desktop Settings

gsettings_set   com.canonical.indicator.datetime              show-calendar                   true
gsettings_set   com.canonical.indicator.datetime              show-clock                      true
gsettings_set   com.canonical.indicator.datetime              show-date                       true
gsettings_set   com.canonical.indicator.datetime              show-day                        true
gsettings_set   com.canonical.indicator.datetime              time-format                     '12-hour'

gsettings_set   com.canonical.indicator.session               show-real-name-on-panel         false
gsettings_set   com.canonical.indicator.session               user-show-menu                  false
gsettings_set   com.canonical.indicator.session               use-username-in-switch-item     false
gsettings_set   com.canonical.Unity.Launcher                  favorites                       "['nautilus-home.desktop', 'firefox.desktop', 'ubuntu-software-center.desktop', 'gnome-control-center.desktop']"
gsettings_set   org.gnome.desktop.sound                       event-sounds                    true
gsettings_set   org.gnome.desktop.sound                       input-feedback-sounds           false
gsettings_set   org.gnome.desktop.wm.preferences              action-middle-click-titlebar    'toggle-maximize-vertically'
gsettings_set   org.gnome.desktop.wm.preferences              action-right-click-titlebar     'toggle-maximize-horizontally'
gsettings_set   org.gnome.gnome-screenshot                    auto-save-directory             ''
gsettings_set   org.gnome.settings-daemon.plugins.media-keys  screensaver                     '<Control><Alt>l'
gsettings_set   org.gnome.SimpleScan                          document-type                   'photo'
gsettings_set   org.gnome.SimpleScan                          photo-dpi                       150

# Font settings
gsettings_set   com.canonical.unity-greeter       font-name             'Ubuntu 11'
gsettings_set   org.gnome.desktop.interface       document-font-name    'DejaVu Sans 10'
gsettings_set   org.gnome.desktop.interface       font-name             'Ubuntu 10'
gsettings_set   org.gnome.desktop.interface       monospace-font-name   'Ubuntu Mono 11'
gsettings_set   org.gnome.gnome-system-log        fontsize              10
gsettings_set   org.gnome.nautilus.desktop        font                  'Ubuntu 10'
gsettings_set   org.gnome.desktop.wm.preferences  titlebar-font         'Ubuntu Bold 10'

# User management
gsettings_set   org.gnome.desktop.lockdown        disable-user-switching    true
gsettings_set   org.gnome.desktop.screensaver     user-switch-enabled       false
gsettings_set   com.canonical.indicator.session   user-show-menu            false
gsettings_set   com.canonical.indicator.session   show-real-name-on-panel   false

# Other settings
gsettings_set   org.gnome.desktop.wm.preferences  action-middle-click-titlebar  'toggle-maximize-vertically'
gsettings_set   org.gnome.desktop.wm.preferences  action-right-click-titlebar   'toggle-maximize-horizontally'
gsettings_set   org.gnome.desktop.background      show-desktop-icons            true

gsettings_set   com.canonical.Unity.Panel         systray-whitelist       "['all']"

# Power settings
gsettings_set   org.gnome.settings-daemon.plugins.power   idle-dim-ac       false
gsettings_set   org.gnome.settings-daemon.plugins.power   idle-dim-battery  false

gsettings_set   com.canonical.Unity2d             sticky-edges            false
gsettings_set   com.canonical.Unity2d             use-opengl              false
gsettings_set   com.canonical.Unity2d.Dash        full-screen             true
gsettings_set   com.canonical.Unity2d.Launcher    edge-decayrate          1500
gsettings_set   com.canonical.Unity2d.Launcher    edge-overcome-pressure  2000
gsettings_set   com.canonical.Unity2d.Launcher    edge-responsiveness     1.30000000000000
gsettings_set   com.canonical.Unity2d.Launcher    edge-reveal-pressure    2000
gsettings_set   com.canonical.Unity2d.Launcher    edge-stop-velocity      6500
gsettings_set   com.canonical.Unity2d.Launcher    hide-mode               1
gsettings_set   com.canonical.Unity2d.Launcher    only-one-launcher       true
gsettings_set   com.canonical.Unity2d.Launcher    reveal-mode             0
gsettings_set   com.canonical.Unity2d.Launcher    super-key-enable        true
gsettings_set   com.canonical.Unity2d.Panel       applets                 "['appname', '!legacytray', 'indicator']"

# Disable HUD
# Can't find an option with gsettings
gconftool-2 --set /apps/compiz-1/plugins/unityshell/screen0/options/show_hud 'Disabled' --type string

gsettings_set   com.ubuntu.update-notifier        show-apport-crashes     false

gsettings_set   org.gnome.desktop.interface       icon-theme              'Faenza-Ambiance'
# gsettings_set   org.gnome.desktop.interface       gtk-theme               'Bluebird-GTK'
# gsettings_set   org.gnome.desktop.wm.preferences  theme                   'Bluebird-GTK'

gsettings_set   org.gnome.desktop.interface       show-input-method-menu  false
gsettings_set   org.gnome.desktop.interface       show-unicode-menu       false

gsettings_set   org.gnome.desktop.screensaver     lock-enabled            true
gsettings_set   org.gnome.desktop.screensaver     lock-delay uint32       300
gsettings_set   org.gnome.desktop.screensaver     ubuntu-lock-on-suspend  true

# Open the file browser with CTRL+ALT+F
gsettings_set   org.gnome.settings-daemon.plugins.media-keys  home            "<Primary><Alt>f"
gsettings_set   org.gnome.desktop.wm.keybindings              show-desktop    "['<Primary><Alt>d', '<Primary><Super>d', '<Super>d']"
gsettings_set   org.gnome.desktop.wm.keybindings              switch-windows  "['<Alt>Tab']"
gsettings_set   org.gnome.desktop.wm.preferences              audible-bell    false
gsettings_set   org.gnome.desktop.wm.preferences              visual-bell     false
gsettings_set   org.gnome.desktop.wm.preferences              num-workspaces  2

gsettings_set   org.gnome.nautilus.desktop        computer-icon-visible         true
gsettings_set   org.gnome.nautilus.desktop        home-icon-visible             true
gsettings_set   org.gnome.nautilus.desktop        trash-icon-visible            true
gsettings_set   org.gnome.nautilus.desktop        volumes-visible               true
gsettings_set   org.gnome.nautilus.desktop        trash-icon-name               'Bin'

gsettings_set   org.gnome.nautilus.list-view      default-visible-columns       "['name', 'size', 'type', 'date_modified', 'where', 'owner', 'permissions']"
gsettings_set   org.gnome.nautilus.preferences    default-folder-viewer         'list-view'
gsettings_set   org.gnome.nautilus.preferences    executable-text-activation    'display'
gsettings_set   org.gnome.nautilus.preferences    show-advanced-permissions     true
gsettings_set   org.gnome.nautilus.window-state   start-with-status-bar         true
gsettings_set   org.gnome.nautilus.compact-view   all-columns-have-same-width   false

gsettings_set   org.gnome.settings-daemon.peripherals.touchpad  horiz-scroll-enabled  true
gsettings_set   org.gnome.settings-daemon.peripherals.touchpad  scroll-method         'two-finger-scrolling'
gsettings_set   org.gnome.settings-daemon.peripherals.touchpad  tap-to-click          true

# gsettings_set   org.gnome.desktop.default-applications.terminal exec 'konsole'
# gsettings_set   org.gnome.desktop.wm.preferences visual-bell-type 'fullscreen-flash'
# gsettings_set   com.canonical.Unity2d use-opengl false

# Ensure that <Alt>Tab is mapped to "switch windows"
# This should work, but does not...
#   gsettings_set   org.gnome.desktop.wm.keybindings  switch-windows          "['<Alt>Tab']"
# ...so fall back to gconftool-2
gconftool-2 --set --type string /apps/metacity/global_keybindings/switch_windows '<Alt>Tab'
