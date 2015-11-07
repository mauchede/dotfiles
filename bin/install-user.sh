#!/bin/bash
set -ex
cd "`dirname "$0"`/.."

if [[ $EUID != 0 ]] ; then
    echo "Impossible to configure an user without root privileges." 1>&2
    exit 1
fi

if [[ -z $1 ]] || ! id -u $1 >/dev/null 2>&1 ; then
    echo "Invalid user." 1>&2
    echo "Usage: $0 [USER]" 1>&2
    exit 1
fi

# configure system

    ## docker

    adduser $1 docker

# configure user

sudo -u $1 -H -s -- <<"EOF"

    set -ex

    ## base

    mkdir -p $HOME/bin
    cp -rT ./src/user $HOME/

    ## unity

        ### always show the menu

        gsettings set com.canonical.Unity always-show-menus true

        ### configure keyboard shortcuts

        gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '<Super>l'
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'xfce4-terminal'
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'xfce4-terminal --drop-down'
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding 'F12'

        ### configure launcher

        dconf write /org/compiz/profiles/unity/plugins/unityshell/launcher-hide-mode 1
        gsettings set com.canonical.Unity.Launcher favorites "['application://nautilus.desktop', 'application://chromium-browser.desktop', 'application://thunderbird.desktop', 'unity://running-apps', 'unity://devices']"

        ### configure workspaces

        gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 2
        gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 1

        ### disable automount

        gsettings set org.gnome.desktop.media-handling automount false

        ### disable screen auto locking after inactivity

        dconf write /org/gnome/desktop/screensaver/lock-enabled false

        ### disable sticky edges

        dconf write /org/compiz/profiles/unity/plugins/unityshell/launcher-capture-mouse false

        ### disable the remote lenses

        gsettings set com.canonical.Unity.Lenses remote-content-search none

        ### lock the screen with "Super + l"

        gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '<Super>l'

        ### minimize applications in launcher

        dconf write /org/compiz/profiles/unity/plugins/unityshell/launcher-minimize-window true

        ### show battery percentage

        gsettings set com.canonical.indicator.power show-percentage true

        ### use recursive search

        gsettings set org.gnome.nautilus.preferences enable-interactive-search false

EOF
