#!/usr/bin/env bash

set -e

# To get all the values run:
#
#      gconftool-2 -R /apps/gnome-terminal/profiles/Default

basic_profile(){
  local profile=$1

  echo "Apply basic profile for ${profile}"

  gconftool-2 --type string --set "/apps/gnome-terminal/profiles/${profile}/font"                     'Ubuntu Mono 12'
  gconftool-2 --type string --set "/apps/gnome-terminal/profiles/${profile}/background_type"          'solid'
  gconftool-2 --type float  --set "/apps/gnome-terminal/profiles/${profile}/background_darkness"      0.5
  gconftool-2 --type int    --set "/apps/gnome-terminal/profiles/${profile}/scrollback_lines"         512
  gconftool-2 --type int    --set "/apps/gnome-terminal/profiles/${profile}/default_size_rows"        36
  gconftool-2 --type int    --set "/apps/gnome-terminal/profiles/${profile}/default_size_columns"     128
  gconftool-2 --type bool   --set "/apps/gnome-terminal/profiles/${profile}/use_theme_colors"         false
  gconftool-2 --type bool   --set "/apps/gnome-terminal/profiles/${profile}/scrollback_unlimited"     true
  gconftool-2 --type bool   --set "/apps/gnome-terminal/profiles/${profile}/use_custom_default_size"  true
  gconftool-2 --type bool   --set "/apps/gnome-terminal/profiles/${profile}/use_system_font"          false
  gconftool-2 --type bool   --set "/apps/gnome-terminal/profiles/${profile}/silent_bell"              true
  gconftool-2 --type bool   --set "/apps/gnome-terminal/profiles/${profile}/allow_bold"               false
}

echo
echo "--- Gnome terminal setup ---"
echo

echo "Disable window menu"
gconftool-2 --type bool   --set /apps/gnome-terminal/global/use_mnemonics           false
gconftool-2 --type bool   --set /apps/gnome-terminal/global/use_menu_accelerators   false

echo "Disable next/prev tab key bindings"
gconftool-2 --type string --set /apps/gnome-terminal/keybindings/prev_tab 'disabled'
gconftool-2 --type string --set /apps/gnome-terminal/keybindings/next_tab 'disabled'

echo "Set up active profiles"
gconftool-2 --type list --list-type string --set /apps/gnome-terminal/global/profile_list '[Default,DefaultBkp,SolarizedDark,SolarizedLight,AgnosticDark,AgnosticLight]'

echo "Backup Default profile"
cp -R $HOME/.gconf/apps/gnome-terminal/profiles/Default $HOME/.gconf/apps/gnome-terminal/profiles/DefaultBkp
sleep 1
gconftool-2 --set /apps/gnome-terminal/profiles/DefaultBkp/visible_name --type string 'Default Bkp'

echo "Set up default profile"
gconftool-2 --type string --set /apps/gnome-terminal/global/default_profile 'SolarizedDark'

echo "Set up custom options for default profile"
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/foreground_color         '#F3F3F3F3F3F3'
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/palette                  '#000000000000:#CCCC00000000:#4E4E9A9A0606:#C4C4A0A00000:#34346565A4A4:#757550507B7B:#060698209A9A:#D3D3D7D7CFCF:#555557575353:#EFEF29292929:#8A8AE2E23434:#FCFCE9E94F4F:#72729F9FCFCF:#ADAD7F7FA8A8:#3434E2E2E2E2:#EEEEEEEEECEC'
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/background_color         '#103610361036'
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/bold_color               '#000000000000'

basic_profile "Default"

# Solarized for terminal
# <https://gist.github.com/codeforkjeff/1397104>
# <https://gist.github.com/lucabelmondo/5897436>
# Provided by https://github.com/sigurdga/gnome-terminal-colors-solarized (subsequent runs)
SOLARIZED_PALETTE="#073642:#DC322F:#859900:#B58900:#268BD2:#D33682:#2AA198:#EEE8D5:#002B36:#CB4B16:#586E75:#657B83:#839496:#6C71C4:#93A1A1:#FDF6E3"

echo "Create SolarizedDark profile as copy of Default"
cp -R $HOME/.gconf/apps/gnome-terminal/profiles/Default $HOME/.gconf/apps/gnome-terminal/profiles/SolarizedDark
sleep 1

echo "Set up SolarizedDark"
gconftool-2 --type string --set /apps/gnome-terminal/profiles/SolarizedDark/visible_name          'Solarized Dark'
gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/SolarizedDark/use_theme_background  false
gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/SolarizedDark/use_theme_colors      false
gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/SolarizedDark/bold_color_same_as_fg false
gconftool-2 --type string --set /apps/gnome-terminal/profiles/SolarizedDark/solarized_scheme      'dark'
gconftool-2 --type string --set /apps/gnome-terminal/profiles/SolarizedDark/palette               "$SOLARIZED_PALETTE"
gconftool-2 --type string --set /apps/gnome-terminal/profiles/SolarizedDark/background_color      "#002B36"
gconftool-2 --type string --set /apps/gnome-terminal/profiles/SolarizedDark/foreground_color      "#839496"
gconftool-2 --type string --set /apps/gnome-terminal/profiles/SolarizedDark/bold_color            '#93A1A1'

basic_profile "SolarizedDark"

echo "Create SolarizedLight profile as copy of Default"
cp -R $HOME/.gconf/apps/gnome-terminal/profiles/Default $HOME/.gconf/apps/gnome-terminal/profiles/SolarizedLight
sleep 1

echo "Set up SolarizedLight"
gconftool-2 --type string --set /apps/gnome-terminal/profiles/SolarizedLight/visible_name          'Solarized Light'
gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/SolarizedLight/use_theme_background  false
gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/SolarizedLight/use_theme_colors      false
gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/SolarizedLight/bold_color_same_as_fg false
gconftool-2 --type string --set /apps/gnome-terminal/profiles/SolarizedLight/solarized_scheme      'light'
gconftool-2 --type string --set /apps/gnome-terminal/profiles/SolarizedLight/palette               "$SOLARIZED_PALETTE"
gconftool-2 --type string --set /apps/gnome-terminal/profiles/SolarizedLight/background_color      '#FDF6E3'
gconftool-2 --type string --set /apps/gnome-terminal/profiles/SolarizedLight/foreground_color      '#657B83'
gconftool-2 --type string --set /apps/gnome-terminal/profiles/SolarizedLight/bold_color            '#586E75'

basic_profile "SolarizedLight"

AGNOSTIC_DARK_PALETTE="#06A22D392D39:#9D0212511251:#1E098CCC36BC:#947A936B017C:#0ADC4C408DA6:#82C31C378443:#10EE69CF69CF:#A221A221A221:#CA84CD44CF5B:#A8F5574B5AD1:#8473C7AD9371:#D39FD3078117:#53297365939F:#9709622C8EAB:#5D94955485B0:#F7F7F7F7D5D5"
AGNOSTIC_LIGHT_PALETTE="#F7F7F7F7D5D5:#AC5E5ECA5D14:#55D692C54FBE:#B2589EC10000:#3D816975740D:#9709622C933B:#5D94955485B0:#888888138813:#51EB51EB51EB:#851E14DA30EB:#090B5A731B33:#AEEE4C8C0829:#08CF49F38B17:#69CE16385E61:#10EE69CF69CF:#08D92F63340D"

echo "Create AgnosticDark profile as copy of Default"
cp -R $HOME/.gconf/apps/gnome-terminal/profiles/Default $HOME/.gconf/apps/gnome-terminal/profiles/AgnosticDark
sleep 1

echo "Set up AgnosticDark"
gconftool-2 --type string --set /apps/gnome-terminal/profiles/AgnosticDark/visible_name          'Agnostic Dark'
gconftool-2 --type string --set /apps/gnome-terminal/profiles/AgnosticDark/palette               "$AGNOSTIC_DARK_PALETTE"
gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/AgnosticDark/use_theme_background  false
gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/AgnosticDark/use_theme_colors      false
gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/AgnosticDark/bold_color_same_as_fg true
gconftool-2 --type string --set /apps/gnome-terminal/profiles/AgnosticDark/background_color      '#06A22D392D39'
gconftool-2 --type string --set /apps/gnome-terminal/profiles/AgnosticDark/foreground_color      '#F7F7F7F7D5D5'
# gconftool-2 --type string --set /apps/gnome-terminal/profiles/AgnosticDark/bold_color            '#586E75'

basic_profile "AgnosticDark"

echo "Create AgnosticLight profile as copy of Default"
cp -R $HOME/.gconf/apps/gnome-terminal/profiles/Default $HOME/.gconf/apps/gnome-terminal/profiles/AgnosticLight
sleep 1

echo "Set up AgnosticLight"
gconftool-2 --type string --set /apps/gnome-terminal/profiles/AgnosticLight/visible_name          'Agnostic Light'
gconftool-2 --type string --set /apps/gnome-terminal/profiles/AgnosticLight/palette               "$AGNOSTIC_LIGHT_PALETTE"
gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/AgnosticLight/use_theme_background  false
gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/AgnosticLight/use_theme_colors      false
gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/AgnosticLight/bold_color_same_as_fg true
gconftool-2 --type string --set /apps/gnome-terminal/profiles/AgnosticLight/foreground_color      '#06A22D392D39'
gconftool-2 --type string --set /apps/gnome-terminal/profiles/AgnosticLight/background_color      '#F7F7F7F7D5D5'

basic_profile "AgnosticLight"






# gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/background_image        <was empty, use unset instead>
# gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/custom_command          was empty, use unset instead

# Other options, that already default.
# gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/Default/bold_color_same_as_fg    true
# gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/visible_name             'Default'
# gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape             'block'
# gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/backspace_binding        'ascii-del'
# gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/delete_binding           'escape-sequence'
# gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/scrollbar_position       'right'
# gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_blink_mode        'system'
# gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/word_chars               '-A-Za-z0-9,./?%&#:_=+@~'
# gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/title                    'Terminal'
# gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/exit_action              'close'
# gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/title_mode               'replace'
# gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/Default/scroll_background        true
# gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/Default/update_records           true
# gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/Default/login_shell              false
# gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/Default/default_show_menubar     true
# gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/Default/use_custom_command       false
# gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/Default/scroll_on_output         false
# gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/Default/scroll_on_keystroke      true
# gconftool-2 --type bool   --set /apps/gnome-terminal/profiles/Default/alternate_screen_scroll  true

# From the gist
# gconftool-2  --type string --set /apps/gnome-terminal/profiles/SolarizedDark/palette                "#070736364242:#D3D301010202:#858599990000:#B5B589890000:#26268B8BD2D2:#D3D336368282:#2A2AA1A19898:#EEEEE8E8D5D5:#00002B2B3636:#CBCB4B4B1616:#58586E6E7575:#65657B7B8383:#838394949696:#6C6C7171C4C4:#9393A1A1A1A1:#FDFDF6F6E3E3"
# gconftool-2  --type string --set /apps/gnome-terminal/profiles/SolarizedDark/background_color       "#00002B2B3636"
# gconftool-2  --type string --set /apps/gnome-terminal/profiles/SolarizedDark/foreground_color       "#65657B7B8383"

# Provided by https://github.com/sigurdga/gnome-terminal-colors-solarized (first run)
# gconftool-2 --type string --set  /apps/gnome-terminal/profiles/SolarizedDark/palette                "#070736364242:#DCDC32322F2F:#858599990000:#B5B589890000:#26268B8BD2D2:#D3D336368282:#2A2AA1A19898:#EEEEE8E8D5D5:#00002B2B3636:#CBCB4B4B1616:#58586E6E7575:#65657B7B8383:#838394949696:#6C6C7171C4C4:#9393A1A1A1A1:#FDFDF6F6E3E3"
# gconftool-2 --type string --set  /apps/gnome-terminal/profiles/SolarizedDark/background_color       "#00002B2B3636"
# gconftool-2 --type string --set  /apps/gnome-terminal/profiles/SolarizedDark/foreground_color       "#838394949696"
# gconftool-2 --type string --set /apps/gnome-terminal/profiles/SolarizedDark/bold_color '#9393A1A1A1A1'

# From the gist
# gconftool-2 --type string --set  /apps/gnome-terminal/profiles/SolarizedLight/palette               "#EEEEE8E8D5D5:#D3D301010202:#858599990000:#B5B589890000:#26268B8BD2D2:#D3D336368282:#2A2AA1A19898:#070736364242:#FDFDF6F6E3E3:#CBCB4B4B1616:#9393A1A1A1A1:#838394949696:#65657B7B8383:#6C6C7171C4C4:#58586E6E7575:#00002B2B3636"
# gconftool-2 --type string --set  /apps/gnome-terminal/profiles/SolarizedLight/background_color      "#FDFDF6F6E3E3"
# gconftool-2 --type string --set  /apps/gnome-terminal/profiles/SolarizedLight/foreground_color      "#838394949696"

# Provided by https://github.com/sigurdga/gnome-terminal-colors-solarized
