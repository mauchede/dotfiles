#!/bin/sh
set -e -u -x
cd "$(dirname "$0")"/..

fail() {
    echo 1>&2 "$1"
    echo 1>&2 "Usage: $(basename "$0")"
    exit 255
}

# Install brew

if ! command -v brew ; then
    /usr/bin/ruby -e "$(curl --fail --location --silent --show-error "https://raw.githubusercontent.com/Homebrew/install/master/install")"
fi

# Update system

brew update
brew upgrade

# Install base

brew install bash-completion coreutils

# Install atom

brew cask install atom

# Install bash

brew install bash

# Install docker-ce

brew cask install docker
sudo cp ./src/system/rootfs/etc/nfs.conf /etc/nfs.conf
sudo nfsd restart

# Install drive

curl --location "https://github.com/timonier/drive/raw/master/bin/installer" | sh -s -- install

# Install etcher

brew cask install etcher

# Install firefox

brew cask install firefox

# Install filezilla

if [ -d /Applications/FileZilla.app ] ; then
    brew cask reinstall filezilla
else
    brew cask install filezilla
fi

# Install gatling

export $(curl --location "https://github.com/mauchede/version-lister/raw/generated/_/gatling/latest" | xargs)
brew cask install caskroom/versions/java8
rm -f -r /usr/local/opt/gatling
curl --location --output /tmp/gatling.zip "${GATLING_RELEASE}"
sh -c "cd /tmp && unzip /tmp/gatling.zip"
mv /tmp/gatling-charts-highcharts-bundle-"${GATLING_VERSION}" /usr/local/opt/gatling
xattr -r -d com.apple.quarantine /usr/local/opt/gatling
cp ./src/system/rootfs/usr/local/bin/gatling /usr/local/bin/gatling
cp ./src/system/rootfs/usr/local/bin/gatling-recorder /usr/local/bin/gatling-recorder
rm -f -r /tmp/gatling*

# Install git

brew install git

# Install google-chrome

brew cask install google-chrome

# Install google-cloud-sdk

brew cask install google-cloud-sdk

# Install homebank

brew install homebank

# Install iterm2

if [ -d /Applications/iTerms.app ]; then
    brew cask reinstall iterm2
else
    brew cask install iterm2
fi

# Install java

brew cask install java

# Install jq

brew install jq

# Install keepassxc

brew cask install keepassxc

# Install keka

brew cask install keka

# Install libreoffice

brew cask install libreoffice

# Install license

curl --location "https://github.com/timonier/license/raw/master/bin/installer" | sh -s -- install

# Install make

brew install make

# Install mysql

curl --location "https://github.com/timonier/mysql/raw/master/bin/installer" | sh -s -- install

# Install nodejs

curl --location "https://github.com/timonier/node/raw/master/bin/installer" | sh -s -- install

# Install osxfuse

brew cask install osxfuse
brew install ntfs-3g

# Install php

curl --location "https://github.com/timonier/php/raw/master/bin/installer" | sh -s -- install

# Install phpstorm

if [ -d /Applications/PhpStorm.app ] ; then
    brew cask reinstall phpstorm
else
    brew cask install phpstorm
fi

# Install postgresql

curl --location "https://github.com/timonier/postgresql/raw/master/bin/installer" | sh -s -- install

# Install postman

brew cask install postman

# Install redis

curl --location "https://github.com/timonier/redis/raw/master/bin/installer" | sh -s -- install

# Install shellcheck

brew install shellcheck
cp ./src/system/rootfs/usr/local/bin/shellcheck-folder /usr/local/bin/shellcheck-folder
chmod +x /usr/local/bin/shellcheck-folder

# Install shfmt

export $(curl --location "https://github.com/mauchede/version-lister/raw/generated/mvdan/sh/latest" | xargs)
curl --location --output /usr/local/bin/shfmt "${SH_DARWIN_RELEASE}"
chmod +x /usr/local/bin/shfmt

# Install skype

brew cask install skype

# Install sshuttle

brew install sshuttle

# Install slack

brew cask install slack

# Install spectacle

brew cask install spectacle

# Install spotify

brew cask install spotify

# Install sup

export $(curl --location "https://github.com/mauchede/version-lister/raw/generated/pressly/sup/latest" | xargs)
curl --location --output /usr/local/bin/sup "${SUP_DARWIN_RELEASE}"
chmod +x /usr/local/bin/sup

# Install webstorm

if [ -d /Applications/WebStorm.app ] ; then
    brew cask reinstall webstorm
else
    brew cask install webstorm
fi

# Clean

brew cleanup -s
