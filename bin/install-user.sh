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

    mkdir -p "${HOME}"/.local/bin
    cp --no-target-directory --recursive ./src/user/rootfs "${HOME}"/
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

    git config --global init.defaultBranch master

    git config --global fetch.prune true
EOF

# Configure user

adduser "$1" docker

# Install android sdk

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    if [ ! -d "${HOME}"/Android ]; then
        rm -f "${HOME}"/cmdline-tools.zip
        ( cd "${HOME}" && curl --location --output "${HOME}"/cmdline-tools.zip "https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip" && unzip "${HOME}"/cmdline-tools.zip )
        rm -f "${HOME}"/cmdline-tools.zip

        mkdir -p "${HOME}"/Android/Sdk/cmdline-tools
        mv "${HOME}"/cmdline-tools "${HOME}"/Android/Sdk/cmdline-tools/latest

        yes | "${HOME}"/Android/Sdk/cmdline-tools/latest/bin/sdkmanager "platform-tools"
    fi
EOF

# Install fonts

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    mkdir -p "${HOME}"/.fonts
    ( cd "$(mktemp -d)" && curl --location --output NotoColorEmoji.zip "https://noto-website.storage.googleapis.com/pkgs/NotoColorEmoji-unhinted.zip" && unzip NotoColorEmoji.zip && cp NotoColorEmoji.ttf "${HOME}/.fonts/NotoColorEmoji.ttf" )

    fc-cache -f -v
EOF

# Install joplin

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    curl --location "https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh" | bash
EOF
