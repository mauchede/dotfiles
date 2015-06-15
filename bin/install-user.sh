#!/bin/bash
set -ex
cd "`dirname "$0"`/.."

# dotfiles

mkdir -p $HOME/bin
cp -rT ./src/user $HOME/

# composer

curl -sS https://getcomposer.org/installer | php -- --install-dir=$HOME/bin
mv $HOME/bin/composer.phar $HOME/bin/composer

# melody

curl -sLo $HOME/bin/melody http://get.sensiolabs.org/melody.phar
chmod a+x $HOME/bin/melody

# symfony

curl -sLo $HOME/bin/symfony http://symfony.com/installer
chmod a+x $HOME/bin/symfony

# unity

    ## always show the menu

    gsettings set com.canonical.Unity always-show-menus true

    ## autohide launcher

    #dconf write /org/compiz/profiles/unity/plugins/unityshell/launcher-hide-mode 1

    ## configure keyboard shortcuts

        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"


        ### lock the screen with "Super + l"

        gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '<Super>l'

        ### open dropdown terminal with "F12"

        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'xfce4-terminal'
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'xfce4-terminal --drop-down'
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding 'F12'

    ## configure the launcher favorites

    gsettings set com.canonical.Unity.Launcher favorites "['application://ubiquity.desktop', 'application://nautilus.desktop', 'application://firefox.desktop', 'unity://running-apps', 'unity://devices']"

    ## configure workspaces

    gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 2
    gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 1

    ## disable screen auto locking after inactivity

    gsettings set org.gnome.desktop.screensaver lock-delay 0

    ## disable sticky edges

    dconf write /org/compiz/profiles/unity/plugins/unityshell/launcher-capture-mouse false

    ## disable the remote lenses

    gsettings set com.canonical.Unity.Lenses remote-content-search none

    ## lock the screen with "Super + l"

    gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '<Super>l'

    ## minimize applications in launcher

    dconf write /org/compiz/profiles/unity/plugins/unityshell/launcher-minimize-window true

    ## use recursive search

    gsettings set org.gnome.nautilus.preferences enable-interactive-search false
