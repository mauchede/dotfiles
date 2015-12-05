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

    ## gedit

    gsettings set org.gnome.gedit.preferences.editor create-backup-copy false
    gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
    gsettings set org.gnome.gedit.preferences.editor highlight-current-line true
    gsettings set org.gnome.gedit.preferences.editor insert-spaces true
    gsettings set org.gnome.gedit.preferences.editor scheme oblivion
    gsettings set org.gnome.gedit.preferences.editor wrap-mode none

    ## unity

        ### always show the integrated menus

        gsettings set com.canonical.Unity always-show-menus true
        gsettings set com.canonical.Unity integrated-menus true

        ### change theme

        gsettings set org.gnome.desktop.interface icon-theme Ultra-Flat
        gsettings set org.gnome.desktop.interface gtk-theme Flatabulous
        gsettings set org.gnome.desktop.wm.preferences theme Flatabulous

        ### configure keyboard shortcuts

        gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '<Super>l'
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'xfce4-terminal'
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'xfce4-terminal --drop-down'
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding 'F12'

        ### configure launcher

        dconf write /org/compiz/profiles/unity/plugins/unityshell/icon-size 42
        dconf write /org/compiz/profiles/unity/plugins/unityshell/launcher-hide-mode 1
        gsettings set com.canonical.Unity.Launcher favorites "['unity://running-apps', 'unity://devices']"

        ### configure workspaces

        gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 2
        gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 1

        ### disable automount

        gsettings set org.gnome.desktop.media-handling automount false
        gsettings set org.gnome.desktop.media-handling automount-open false

        ### disable screen auto locking after inactivity

        dconf write /org/gnome/desktop/screensaver/lock-enabled false
        gsettings set org.gnome.desktop.session idle-delay 0

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

        ### use user background as lock-screen background

        gsettings set com.canonical.unity-greeter draw-user-backgrounds true

        ### use recursive search

        gsettings set org.gnome.nautilus.preferences enable-interactive-search false

EOF
