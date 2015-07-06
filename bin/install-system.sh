#!/bin/bash
set -ex
cd "`dirname "$0"`/.."

if [[ $EUID != 0 ]] ; then
    echo "Impossible to prepare the system without root privileges." 1>&2
    exit 1
fi

# base

add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
apt-get update

apt-get install -y --no-install-recommends \
    curl \
    htop \
    myspell-fr \
    powertop \
    thermald \
    vim \
    wget

cp -rT ./src/system /

if grep --quiet intel_pstate=enable /etc/default/grub; then
    sed -i 's/quiet splash/quiet splash intel_pstate=enable/' /etc/default/grub
    update-grub
fi

if [[ ! $(cat /etc/sysctl.conf | grep -q "fs.inotify.max_user_watches") ]] ; then
    echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
fi

# java

apt-get install -y --no-install-recommends \
    openjdk-7-jdk \
    openjdk-7-jre

# php

apt-get install -y --no-install-recommends \
    php5-cli \
    php5-curl \
    php5-intl \
    php5-mysqlnd \
    php5-pgsql \
    php5-readline \
    php5-xdebug

# ruby

apt-get install -y --no-install-recommends \
    ruby \
    ruby-dev

# archives

apt-get install -y --no-install-recommends \
    p7zip-full \
    rar \
    unrar \
    unzip \
    zip

# chromium-browser

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" > /etc/apt/sources.list.d/google-talkplugin.list
apt-get update

apt-get install -y --no-install-recommends \
    chromium-browser \
    chromium-browser-l10n \
    google-talkplugin \
    pepperflashplugin-nonfree

# codecs

apt-get install -y \
    ubuntu-restricted-extras

# docker

curl -sSL https://get.docker.com/ubuntu/ | sh
[[ -n $SUDO_USER ]] && adduser $SUDO_USER docker

curl -sLo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.2.0/docker-compose-$(uname -s)-$(uname -m)
chmod +x /usr/local/bin/docker-compose

# filezilla

apt-get install -y --no-install-recommends \
    filezilla

# git

apt-get install -y --no-install-recommends \
    git

gem install --no-rdoc --no-ri git-up

# gparted

apt-get install -y --no-install-recommends \
    gpart \
    gparted

# homebank

add-apt-repository -y ppa:mdoyen/homebank
apt-get update

apt-get install -y --no-install-recommends \
    homebank

# keepass

apt-get install -y --no-install-recommends \
    keepass2

# libreoffice

apt-get install -y --no-install-recommends \
    libreoffice \
    libreoffice-l10n-fr \
    libreoffice-style-sifr

# phpstorm

if [[ ! -d /opt/phpstorm ]] ; then
    curl -sLo /tmp/PhpStorm-8.0.3.tar.gz http://download.jetbrains.com/webide/PhpStorm-8.0.3.tar.gz
    tar -zxvf /tmp/PhpStorm-8.0.3.tar.gz -C /opt/
    mv /opt/PhpStorm-139.1348 /opt/phpstorm
fi

# picard

apt-get install -y --no-install-recommends \
    picard

# pidgin

apt-get install -y --no-install-recommends \
    pidgin \
    pidgin-libnotify

# remmina

apt-get install -y --no-install-recommends \
    remmina

# soapui

if [[ ! -d /opt/soapui ]] ; then
    curl -sLo /tmp/SoapUI-5.1.3-linux-bin.tar.gz http://downloads.sourceforge.net/project/soapui/soapui/5.1.3/SoapUI-5.1.3-linux-bin.tar.gz
    tar -zxvf /tmp/SoapUI-5.1.3-linux-bin.tar.gz -C /opt/
    mv /opt/SoapUI-5.1.3 /opt/soapui
fi

# skype

apt-get install -y \
    skype

# virtualbox

apt-get install -y --no-install-recommends \
    virtualbox

# vlc

apt-get install -y --no-install-recommends \
    vlc

# xfce4-terminal

apt-get install -y --no-install-recommends \
    xfce4-terminal

# xmllint

apt-get install -y --no-install-recommends \
    libxml2-utils
