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
    git config --global core.editor nano

    git config --global core.excludesfile "${HOME}"/.git_ignore_global
    touch "${HOME}"/.git_ignore_global
    if ! grep -F --quiet ".idea" "${HOME}"/.git_ignore_global ; then
        echo ".idea" >> "${HOME}"/.git_ignore_global
    fi
    if ! grep -F --quiet ".php_cs.cache" "${HOME}"/.git_ignore_global ; then
        echo ".php_cs.cache" >> "${HOME}"/.git_ignore_global
    fi
    if ! grep -F --quiet ".npm-*.log" "${HOME}"/.git_ignore_global ; then
        echo ".npm-*.log" >> "${HOME}"/.git_ignore_global
    fi
    if ! grep -F --quiet "yarn-*.log" "${HOME}"/.git_ignore_global ; then
        echo "yarn-*.log" >> "${HOME}"/.git_ignore_global
    fi

    git config --global init.defaultBranch master

    git config --global fetch.prune true
EOF

# Configure user

adduser "$1" docker

# Install fonts

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    mkdir -p "${HOME}"/.fonts
    ( cd "$(mktemp -d)" && curl --location --output NotoColorEmoji.zip "https://noto-website.storage.googleapis.com/pkgs/NotoColorEmoji-unhinted.zip" && unzip NotoColorEmoji.zip && cp NotoColorEmoji.ttf "${HOME}/.fonts/NotoColorEmoji.ttf" )

    fc-cache -f -v
EOF

# Install balenaEtcher

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    rm -f "${HOME}"/.local/bin/balenaEtcher
    curl --location --output "${HOME}"/.local/bin/balenaEtcher "https://github.com/balena-io/etcher/releases/download/v1.18.11/balenaEtcher-1.18.11-x64.AppImage"
    chmod +x "${HOME}"/.local/bin/balenaEtcher
EOF

# Install dotenv

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    curl --location --output "${HOME}"/.local/bin/dotenv "https://github.com/bashup/dotenv/raw/master/dotenv"
    chmod +x "${HOME}"/.local/bin/dotenv
EOF

# Install ffmpeg

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    rm -f -r /tmp/ffmpeg
    mkdir -p /tmp/ffmpeg
    curl --location --output /tmp/ffmpeg/ffmpeg.tar.xz "https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz"
    bash -c 'cd /tmp/ffmpeg && tar xvf ffmpeg.tar.xz'
    mv /tmp/ffmpeg/ffmpeg-git-*-amd64-static/ffmpeg "${HOME}"/.local/bin/ffmpeg
    chmod +x "${HOME}"/.local/bin/ffmpeg
    mv /tmp/ffmpeg/ffmpeg-git-*-amd64-static/ffprobe "${HOME}"/.local/bin/ffprobe
    chmod +x "${HOME}"/.local/bin/ffprobe
    rm -f -r /tmp/ffmpeg
EOF

# Install hostess

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    curl --location --output "${HOME}"/.local/bin/hostess "https://github.com/cbednarski/hostess/releases/download/v0.5.2/hostess_linux_amd64"
    chmod +x "${HOME}"/.local/bin/hostess
EOF

# Install joplin

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    curl --location --output /dev/stdout "https://github.com/laurent22/joplin/raw/dev/Joplin_install_and_update.sh" | bash -s -- --force
EOF

# Install mkcert

sudo --set-home --shell --user "$1" -- bash << "EOF"
    curl --location --output "${HOME}"/.local/bin/mkcert "https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-linux-amd64"
    chmod +x "${HOME}"/.local/bin/mkcert
EOF

# Install taskfile

sudo --set-home --shell --user "$1" -- bash << "EOF"
    set -e -u -x

    rm -f -r /tmp/task
    mkdir -p /tmp/task
    curl --location --output /tmp/task/task.tar.gz "https://github.com/go-task/task/releases/download/v3.32.0/task_linux_amd64.tar.gz"
    cd /tmp/task
    tar xvf task.tar.gz
    mv /tmp/task/task "${HOME}"/.local/bin/task
    chmod +x "${HOME}"/.local/bin/task
    rm -f -r /tmp/task
EOF
