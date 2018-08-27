#!/bin/sh
set -e -u -x
cd "$(dirname "$0")"/..

fail() {
    echo 1>&2 "$1"
    echo 1>&2 "Usage: $(basename "$0") [USER]"
    exit 255
}

if [ "$(id --user)" != 0 ]; then
    fail "Impossible to execute this script without root privileges."
fi

if [ "$#" != 1 ]; then
    fail "Invalid number of arguments"
fi

if ! id --user "$1" > /dev/null 2>&1; then
    fail "User \"$1\" does not exist."
fi

# Add user to "docker" group

adduser "$1" docker

# Add user to "video" group

adduser "$1" video

# Reload systemd

systemctl-user "$1" daemon-reload

# Add specific files / folders

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    mkdir -p "${HOME}"/.bin
    cp --no-target-directory --recursive ./src/user/rootfs "${HOME}"/
    if [ ! -f "${HOME}"/.env ] ; then
        touch "${HOME}"/.env || :
    fi
EOF

# Configure atom

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    apm install eclipse-keybindings
    apm install file-icons
    apm install language-docker
    apm install open-recent
EOF

# Configure git

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    git config --global alias.amend "commit --amend"
    git config --global alias.branches "branch --all"
    git config --global alias.discard "checkout --"
    git config --global alias.lg "log --abbrev-commit --date=relative --graph --pretty=tformat:'%Cred%h%Creset -%C(cyan)%d %Creset%s %Cgreen(%an %cr)%Creset'"
    git config --global alias.oops "commit -C HEAD --amend --reset-author"
    git config --global alias.stashes "stash list"
    git config --global alias.tags "tag"
    git config --global alias.uncommit "reset --"
    git config --global alias.unstage "reset --quiet HEAD --"
    git config --global alias.up "pull --autostash --rebase"

    git config --global commit.gpgsign true
    git config --global core.editor vim
    git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring

    git config --global core.excludesfile "${HOME}"/.gitignore_global
    touch "${HOME}"/.gitignore_global
    if ! grep -F --quiet ".idea" "${HOME}"/.gitignore_global ; then
        echo ".idea" >> "${HOME}"/.gitignore_global
    fi
    if ! grep -F --quiet ".php_cs.cache" "${HOME}"/.gitignore_global ; then
        echo ".php_cs.cache" >> "${HOME}"/.gitignore_global
    fi
    if ! grep -F --quiet ".npm-*.log" "${HOME}"/.gitignore_global ; then
        echo ".npm-*.log" >> "${HOME}"/.gitignore_global
    fi
    if ! grep -F --quiet "yarn-*.log" "${HOME}"/.gitignore_global ; then
        echo "yarn-*.log" >> "${HOME}"/.gitignore_global
    fi
EOF

# Configure npm

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    npm config set progress false
EOF

# Configure phpstorm

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    curl --location "https://github.com/mauchede/phpstorm-config/raw/master/bin/installer" | sh -s -- install
EOF

# Configure webstorm

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    curl --location "https://github.com/mauchede/webstorm-config/raw/master/bin/installer" | sh -s -- install
EOF

# Configure xfce

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x
    export XDG_RUNTIME_DIR=/run/user/"$(id --user)"

    ## Configure thunar

    xfconf-query --channel thunar --create --property "/misc-middle-click-in-tab" --set "true" --type bool
    xfconf-query --channel thunar --create --property "/misc-thumbnail-mode" --set "THUNAR_THUMBNAIL_MODE_NEVER" --type string

    ## Configure xfce4-desktop

    xfconf-query --channel xfce4-desktop --property "/desktop-icons/file-icons/show-filesystem" --set "false"
    xfconf-query --channel xfce4-desktop --property "/desktop-icons/file-icons/show-home" --set "false"
    xfconf-query --channel xfce4-desktop --property "/desktop-icons/file-icons/show-removable" --set "false"
    xfconf-query --channel xfce4-desktop --property "/desktop-icons/file-icons/show-trash" --set "false"
    xfconf-query --channel xfce4-desktop --create --property "/desktop-icons/show-thumbnails" --set "false" --type bool
    xfconf-query --channel xfce4-desktop --create --property "/desktop-icons/show-tooltips" --set "false" --type bool

    ## Configure xfce4-keyboard-shortcuts

    xfconf-query --channel xfce4-keyboard-shortcuts --property "/xfwm4/custom/<Alt>Insert" --reset || :
    xfconf-query --channel xfce4-keyboard-shortcuts --property "/xfwm4/custom/<Primary><Alt>Insert" --reset || :
    xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Primary><Alt>Insert" --set "add_workspace_key" --type string

    xfconf-query --channel xfce4-keyboard-shortcuts --property "/xfwm4/custom/<Alt>Delete" --reset || :
    xfconf-query --channel xfce4-keyboard-shortcuts --property "/xfwm4/custom/<Primary><Alt>Delete" --reset || :
    xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Primary><Alt>Delete" --set "del_workspace_key" --type string

    xfconf-query --channel xfce4-keyboard-shortcuts --property "/xfwm4/custom/<Primary><Super>Up" --reset || :
    xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Primary><Super>Up" --set "maximize_window_key" --type string

    xfconf-query --channel xfce4-keyboard-shortcuts --property "/xfwm4/custom/<Primary><Shift><Alt>Left" || :
    xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Primary><Shift><Alt>Left" --set "move_window_left_workspace_key" --type string

    xfconf-query --channel xfce4-keyboard-shortcuts --property "/xfwm4/custom/<Primary><Shift><Alt>Right" --reset || :
    xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Primary><Shift><Alt>Right" --set "move_window_right_workspace_key" --type string

    xfconf-query --channel xfce4-keyboard-shortcuts --property "/xfwm4/custom/<Primary><Super>Left" --reset
    xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Primary><Super>Left" --set "tile_left_key" --type string
    xfconf-query --channel xfce4-keyboard-shortcuts --property "/xfwm4/custom/<Super>Left" --reset

    xfconf-query --channel xfce4-keyboard-shortcuts --property "/xfwm4/custom/<Primary><Super>Right" --reset || :
    xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Primary><Super>Right" --set "tile_right_key" --type string
    xfconf-query --channel xfce4-keyboard-shortcuts --property "/xfwm4/custom/<Super>Right" --reset

    xfconf-query --channel xfce4-keyboard-shortcuts --property "/commands/custom/<Primary><Alt>BackSpace" --reset || :
    xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/commands/custom/<Primary><Alt>BackSpace" --set "xfce4-panel --restart" --type string

    xfconf-query --channel xfce4-keyboard-shortcuts --reset --property "/commands/custom/<Super>space" || :
    xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/commands/custom/<Super>space" --set "xfce4-popup-whiskermenu" --type string
    xfconf-query --channel xfce4-keyboard-shortcuts --property "/commands/custom/<Primary>Escape" --reset

    xfconf-query --channel xfce4-keyboard-shortcuts --property "/commands/custom/F12" --reset || :
    xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/commands/custom/F12" --set "xfce4-terminal --drop-down" --type string

    xfconf-query --channel xfce4-keyboard-shortcuts --property "/commands/custom/<Primary><Alt>Delete" --reset
    xfconf-query --channel xfce4-keyboard-shortcuts --property "/commands/custom/<Primary><Alt>l" --reset
    xfconf-query --channel xfce4-keyboard-shortcuts --property "/commands/custom/<Super>l" --reset || :
    xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/commands/custom/<Super>l" --set "xflock4" --type string

    ## Configure xfce4-power-manager

    xfconf-query --channel xfce4-power-manager --property "/xfce4-power-manager/dpms-enabled" --reset || :
    xfconf-query --channel xfce4-power-manager --create --property "/xfce4-power-manager/dpms-enabled" --set "false" --type bool

    xfconf-query --channel xfce4-power-manager --property "/xfce4-power-manager/general-notification" --reset || :
    xfconf-query --channel xfce4-power-manager --create --property "/xfce4-power-manager/general-notification" --set "true" --type bool

    xfconf-query --channel xfce4-power-manager --property "/xfce4-power-manager/lid-action-on-ac" --reset || :
    xfconf-query --channel xfce4-power-manager --create --property "/xfce4-power-manager/lid-action-on-ac" --set 1 --type int

    xfconf-query --channel xfce4-power-manager --property "/xfce4-power-manager/lid-action-on-battery" --reset || :
    xfconf-query --channel xfce4-power-manager --create --property "/xfce4-power-manager/lid-action-on-battery" --set 1 --type int

    xfconf-query --channel xfce4-power-manager --property "/xfce4-power-manager/power-button-action" --reset || :
    xfconf-query --channel xfce4-power-manager --create --property "/xfce4-power-manager/power-button-action" --set 3 --type int

    ## Configure xfwm4

    xfconf-query --channel xfwm4 --property "/general/activate_action" --set "switch"
    xfconf-query --channel xfwm4 --property "/general/cycle_workspaces" --set "true"
    xfconf-query --channel xfwm4 --property "/general/title_font" --set "Noto Sans Bold 9"
    xfconf-query --channel xfwm4 --property "/general/theme" --set "Arc-Darker"
    xfconf-query --channel xfwm4 --property "/general/workspace_count" --set "4"

    ## Configure xsettings

    xfconf-query --channel xsettings --property "/Gtk/FontName" --set "Noto Sans 9"
    xfconf-query --channel xsettings --property "/Gtk/MonospaceFontName" --set "DejaVu Sans Mono 10"
    xfconf-query --channel xsettings --property "/Net/IconThemeName" --set "Moka"
    xfconf-query --channel xsettings --property "/Net/ThemeName" --set "Arc-Darker"
EOF

# Configure yarn

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    yarn config set version-git-tag true
    yarn config set version-sign-git-tag true
EOF

# Fix duplicate directories in home folder (see https://bugs.launchpad.net/ubuntu/+source/snapcraft/+bug/1746710)

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    mkdir -p "${HOME}"/snap/firefox/common
    rm -f -r "${HOME}"/Desktop "${HOME}"/Downloads "${HOME}"/Music "${HOME}"/Pictures "${HOME}"/snap/firefox/common/Téléchargements "${HOME}"/Templates "${HOME}"/Videos
    ln --symbolic "${HOME}"/Bureau "${HOME}"/Desktop
    ln --symbolic "${HOME}"/Téléchargements "${HOME}"/Downloads
    ln --symbolic "${HOME}"/Téléchargements "${HOME}"/snap/firefox/common/Téléchargements
    ln --symbolic "${HOME}"/Musique "${HOME}"/Music
    ln --symbolic "${HOME}"/Images "${HOME}"/Pictures
    ln --symbolic "${HOME}"/Modèles "${HOME}"/Templates
    ln --symbolic "${HOME}"/Vidéos "${HOME}"/Videos
EOF
