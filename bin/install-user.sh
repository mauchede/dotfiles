#!/bin/sh
set -ex
cd "$(dirname "$0")/.."

fail() {
    echo 1>&2 "$1"
    echo 1>&2 "Usage: $(basename "$0") [USER]"
    exit 1
}

if [ "$(id --user)" != 0 ] ; then
    fail "Impossible to configure a user without root privileges."
fi

if [ "$#" != 1 ] ; then
    fail "Invalid number of arguments"
fi

if ! id --user "$1" > /dev/null 2>&1 ; then
    fail "User \"$1\" does not exist."
fi

# Configure system

    ## Add user to "docker" group

    adduser "$1" docker

    ## Add user to "video" group

    adduser "$1" video

    ## Reload systemd

    systemctl-user "$1" daemon-reload

# Configure user

sudo --set-home --shell --user "$1" -- sh <<"EOF"
    set -ex

    ## Add specific files / folders

    mkdir --parents "${HOME}/bin"
    cp --no-target-directory --recursive ./src/user "${HOME}/"
    if [ ! -f "${HOME}/.env" ] ; then
        touch "${HOME}/.env" || :
    fi

    ## Configure atom

    apm install eclipse-keybindings
    apm install file-icons
    apm install language-docker
    apm install open-recent

    ## Configure git

        ### Add aliases

        git config --global alias.amend "commit --amend"
        git config --global alias.branches "branch --all"
        git config --global alias.discard "checkout --"
        git config --global alias.lg "log --abbrev-commit --date=relative --graph --pretty=tformat:\"%Cred%h%Creset -%C(cyan)%d %Creset%s %Cgreen(%an %cr)%Creset\""
        git config --global alias.oops "commit -C HEAD --amend --reset-author"
        git config --global alias.stashes "stash list"
        git config --global alias.tags "tag"
        git config --global alias.uncommit "reset --"
        git config --global alias.unstage "reset --quiet HEAD --"
        git config --global alias.up "pull --autostash --rebase"
        git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring

        ### Configure git

        git config --global core.editor "vim"
        git config --global core.excludesfile "~/.gitignore_global"
        if [ ! -f "${HOME}/.gitignore_global" ] ; then
            touch "${HOME}/.gitignore_global" || :
        fi
        if ! grep --quiet "/.idea" "${HOME}/.env" ; then
            echo "/.idea" >> "${HOME}/.gitignore_global" || :
        fi
        if ! grep --quiet "/.npm-*.log" "${HOME}/.env" ; then
            echo "/.npm-*.log" >> "${HOME}/.gitignore_global" || :
        fi
        if ! grep --quiet "/.yarn-*.log" "${HOME}/.env" ; then
            echo "/.yarn-*.log" >> "${HOME}/.gitignore_global" || :
        fi

    ## Configure npm

    npm config set progress false

    ## Configure phpstorm

    curl --location "https://github.com/mauchede/phpstorm-config/raw/master/bin/installer" | sh -s -- install

    ## Configure webstorm



    ## Configure yarn

    yarn config set version-git-tag true
    yarn config set version-sign-git-tag true

    ## Install composer

    curl --location --output "${HOME}/bin/composer" "https://getcomposer.org/composer.phar"
    chmod +x "${HOME}/bin/composer"

    ## Install melody

    curl --location --output "${HOME}/bin/melody" "http://get.sensiolabs.org/melody.phar"
    chmod +x "${HOME}/bin/melody"

    ## install symfony

    curl --location --output "${HOME}/bin/symfony" "http://symfony.com/installer"
    chmod +x "${HOME}/bin/symfony"
EOF
