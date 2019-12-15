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

# Fix duplicate directories in home folder (see https://bugs.launchpad.net/ubuntu/+source/snapcraft/+bug/1746710)

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    rm -f -r "${HOME}"/Desktop "${HOME}"/Downloads "${HOME}"/Music "${HOME}"/Pictures "${HOME}"/snap/firefox/current/.config/Slack "${HOME}"/Templates "${HOME}"/Videos
    ln --symbolic "${HOME}"/.config/Slack "${HOME}"/snap/firefox/current/.config/Slack
    ln --symbolic "${HOME}"/Bureau "${HOME}"/Desktop
    ln --symbolic "${HOME}"/Téléchargements "${HOME}"/Downloads
    ln --symbolic "${HOME}"/Musique "${HOME}"/Music
    ln --symbolic "${HOME}"/Images "${HOME}"/Pictures
    ln --symbolic "${HOME}"/Modèles "${HOME}"/Templates
    ln --symbolic "${HOME}"/Vidéos "${HOME}"/Videos
EOF
