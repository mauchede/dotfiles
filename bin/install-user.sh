#!/bin/sh
set -e -u -x
cd "$(dirname "$0")"/..

fail() {
    echo 1>&2 "$1"
    echo 1>&2 "Usage: $(basename "$0") [USER]"
    exit 255
}

# Add specific files / folders

cp -R ./src/user/rootfs/ "${HOME}"/
mkdir -p "${HOME}"/.bin
if [ ! -f "${HOME}"/.env ] ; then
    touch "${HOME}"/.env || :
fi

# Configure atom

apm install file-icons
apm install language-docker
apm install open-recent

# Configure git

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
git config --global fetch.prune true

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

# Configure nfs

if ! grep -F --quiet "${HOME}" /etc/exports ; then
    echo "${HOME} -alldirs -mapall=$(id -u):$(id -g) localhost" | sudo tee -a /etc/exports
    sudo nfsd restart
fi

# Configure npm

npm config set progress false

# Configure phpstorm

curl --location "https://github.com/mauchede/phpstorm-config/raw/mac-os/darwin/bin/installer" | sh -s -- install

# Configure webstorm

curl --location "https://github.com/mauchede/webstorm-config/raw/mac-os/darwin/bin/installer" | sh -s -- install

# Configure yarn

if ! grep -F --quiet "YARN_CACHE_FOLDER=" "${HOME}"/.env ; then
    echo "YARN_CACHE_FOLDER=${HOME}/.yarn/cache" >> "${HOME}"/.env
fi
yarn config set version-git-tag true
yarn config set version-sign-git-tag true
