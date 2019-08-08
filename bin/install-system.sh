#!/bin/bash
set -e -u -x
cd "$(dirname "$0")"/..

# Install brew

if ! command -v brew; then
    /usr/bin/ruby -e "$(curl --fail --location --silent --show-error "https://raw.githubusercontent.com/Homebrew/install/master/install")"
fi

# Update system

brew update
brew upgrade

# Install base

brew install coreutils

# Install atom

if [ -d /Applications/Atom.app ]; then
    brew cask reinstall atom
else
    brew cask install atom
fi
xattr -d com.apple.quarantine /Applications/Atom.app || :

# Install aws-cli

brew install awscli

# Install bash

brew install bash
brew install bash-completion
brew install bashful

# Install cyberduck

if [ -d /Applications/Cyberduck.app ]; then
    brew cask reinstall cyberduck
else
    brew cask install cyberduck
fi
xattr -d com.apple.quarantine /Applications/Cyberduck.app || :

# Install docker-ce

if [ -d /Applications/Docker.app ]; then
    brew cask reinstall docker
else
    brew cask install docker
fi
xattr -d com.apple.quarantine /Applications/Docker.app || :
sudo cp src/system/rootfs/etc/nfs.conf /etc/nfs.conf
sudo nfsd restart

# Install drive

curl --location "https://gitlab.com/timonier/drive/raw/master/bin/installer" | sh -s -- install

# Install etcher

if [ -d /Applications/balenaEtcher.app ]; then
    brew cask reinstall balenaetcher
else
    brew cask install balenaetcher
fi
xattr -d com.apple.quarantine /Applications/balenaEtcher.app || :

# Install firefox

brew cask install firefox

# Install gatling

export $(curl --location "https://gitlab.com/mauchede/version-lister/raw/generated/_/gatling/latest" | xargs)
rm -f -r /usr/local/opt/gatling
curl --location --output /tmp/gatling.zip "${GATLING_RELEASE}"
sh -c "cd /tmp && unzip /tmp/gatling.zip"
mv /tmp/gatling-charts-highcharts-bundle-"${GATLING_VERSION}" /usr/local/opt/gatling
xattr -r -d com.apple.quarantine /usr/local/opt/gatling
cp src/system/rootfs/usr/local/bin/gatling /usr/local/bin/gatling
cp src/system/rootfs/usr/local/bin/gatling-recorder /usr/local/bin/gatling-recorder
rm -f -r /tmp/gatling*

# Install git

brew install git

# Install git-remote-gcrypt

curl --location --output /usr/local/bin/git-remote-gcrypt "https://github.com/spwhitton/git-remote-gcrypt/raw/master/git-remote-gcrypt"
chmod +x /usr/local/bin/git-remote-gcrypt

# Install google-chrome

brew cask install google-chrome

# Install google-cloud-sdk

brew cask install google-cloud-sdk

# Install gnupg

brew install gpg

# Install hostess

export $(curl --location "https://gitlab.com/mauchede/version-lister/raw/generated/cbednarski/hostess/latest" | xargs)
curl --location --output /usr/local/bin/hostess "${HOSTESS_DARWIN_RELEASE}"
chmod +x /usr/local/bin/hostess

# Install htop

brew install htop

# Install iterm2

if [ -d /Applications/iTerm.app ]; then
    brew cask reinstall iterm2
else
    brew cask install iterm2
fi
xattr -d com.apple.quarantine /Applications/iTerm.app || :

# Install java

brew cask install java

# Install jq

brew install jq

# Install keepassxc

if [ -d /Applications/KeePassXC.app ]; then
    brew cask reinstall keepassxc
else
    brew cask install keepassxc
fi
xattr -d com.apple.quarantine /Applications/KeePassXC.app || :

# Install keka

if [ -d /Applications/Keka.app ]; then
    brew cask reinstall keka
else
    brew cask install keka
fi
xattr -d com.apple.quarantine /Applications/Keka.app || :

# kubernetes-completion

brew install kubernetes-cli

# Install libreoffice

if [ -d /Applications/LibreOffice.app ]; then
    brew cask reinstall libreoffice
else
    brew cask install libreoffice
fi
xattr -d com.apple.quarantine /Applications/LibreOffice.app || :

# Install license

curl --location "https://gitlab.com/timonier/license/raw/master/bin/installer" | sh -s -- install

# Install macs-fan-control

if [ -d "/Applications/Macs Fan Control.app" ]; then
    brew cask reinstall macs-fan-control
else
    brew cask install macs-fan-control
fi
xattr -d com.apple.quarantine "/Applications/Macs Fan Control.app" || :

# Install make

brew install make

# Install mysql

curl --location "https://gitlab.com/timonier/mysql/raw/master/bin/installer" | sh -s -- install

# Install nodejs

curl --location "https://gitlab.com/timonier/node/raw/master/bin/installer" | sh -s -- install

# Install osxfuse

brew cask install osxfuse
brew install ntfs-3g

# Install php

curl --location "https://gitlab.com/timonier/php/raw/master/bin/installer" | sh -s -- install

# Install phpstorm

if [ ! -d /Applications/PhpStorm.app ]; then
    brew cask install phpstorm
fi
xattr -d com.apple.quarantine /Applications/PhpStorm.app || :

# Install postgresql

curl --location "https://gitlab.com/timonier/postgresql/raw/master/bin/installer" | sh -s -- install

# Install postman

if [ -d /Applications/Postman.app ]; then
    brew cask reinstall postman
else
    brew cask install postman
fi
xattr -d com.apple.quarantine /Applications/Postman.app || :

# Install redis

curl --location "https://gitlab.com/timonier/redis/raw/master/bin/installer" | sh -s -- install

# Install shellcheck

brew install shellcheck
cp src/system/rootfs/usr/local/bin/shellcheck-folder /usr/local/bin/shellcheck-folder
chmod +x /usr/local/bin/shellcheck-folder

# Install shfmt

export $(curl --location "https://gitlab.com/mauchede/version-lister/raw/generated/mvdan/sh/latest" | xargs)
curl --location --output /usr/local/bin/shfmt "${SH_DARWIN_RELEASE}"
chmod +x /usr/local/bin/shfmt
cp src/system/rootfs/usr/local/bin/shell-cs-fixer /usr/local/bin/shell-cs-fixer
chmod +x /usr/local/bin/shell-cs-fixer

# Install skype

if [ -d /Applications/Skype.app ]; then
    brew cask reinstall skype
else
    brew cask install skype
fi
xattr -d com.apple.quarantine /Applications/Skype.app || :

# Install sshuttle

brew install sshuttle

# Install slack

if [ -d /Applications/Slack.app ]; then
    brew cask reinstall slack
else
    brew cask install slack
fi
xattr -d com.apple.quarantine /Applications/Slack.app || :

# Install spectacle

if [ -d /Applications/Spectacle.app ]; then
    brew cask reinstall spectacle
else
    brew cask install spectacle
fi
xattr -d com.apple.quarantine /Applications/Spectacle.app || :

# Install spotify

if [ -d /Applications/Spotify.app ]; then
    brew cask reinstall spotify
else
    brew cask install spotify
fi
xattr -d com.apple.quarantine /Applications/Spotify.app || :

# Install vlc

if [ -d /Applications/VLC.app ]; then
    brew cask reinstall vlc
else
    brew cask install vlc
fi
xattr -d com.apple.quarantine /Applications/VLC.app || :

# Install webstorm

if [ ! -d /Applications/WebStorm.app ]; then
    brew cask install webstorm
fi
xattr -d com.apple.quarantine /Applications/WebStorm.app || :

# Install wget

brew install wget

# Clean

brew cleanup -s
