#!/bin/sh
set -x
cd "`dirname "$0"`/.."

fail() {
    echo $1 1>&2
    exit 1
}

[ $EUID != 0 ] && fail "Impossible to prepare the system without root privileges."

# preparation

    ## update

    apt-get update
    apt-get upgrade -y

    ## install base

    if grep --quiet "deb http://archive.canonical.com/ $(lsb_release -cs) partner" /etc/apt/sources.list ; then
        add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -cs) partner"
        apt-get update
    fi

    apt-get install -y --no-install-recommends \
        curl \
        git \
        htop \
        vim \
        wget

    ## install docker

    if [ ! -f /usr/bin/docker ] ; then
        curl -sL "https://get.docker.com/" | sh

        cp -rT ./src/system/etc/default/docker /etc/default/docker
        cp -rT ./src/system/etc/systemd/system/docker.service.d /etc/systemd/system/docker.service.d

        systemctl stop docker
        rm -rf /var/lib/docker
        systemctl daemon-reload
        systemctl start docker
    fi

# installation

    ## ansible

    apt-get install -y --no-install-recommends \
        ansible

    ## archives

    apt-get install -y --no-install-recommends \
        p7zip-full \
        rar \
        unrar \
        unzip \
        zip

    cp -rT ./src/system/usr/local/bin/extract /usr/local/bin/extract

    ## atom

    curl -sL "https://github.com/timonier/atom/raw/master/bin/installer" | sh -s install

    ## chromium-browser

    apt-get install -y --no-install-recommends \
        chromium-browser \
        chromium-browser-l10n \
        pepperflashplugin-nonfree

    ## codecs

    apt-get install -y \
        ubuntu-restricted-extras

    ## docker-compose

    if [ ! -f /usr/local/bin/docker-compose ] ; then
        DOCKER_COMPOSE_VERSION="1.7.0"

        curl -sLo /usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)"
        chmod +x /usr/local/bin/docker-compose
    fi

    ## docker-clean

    if [ ! -f /usr/local/bin/docker-clean ] ; then
        DOCKER_CLEAN_VERSION="2.0.3"

        curl -sLo /usr/local/bin/docker-clean "https://raw.githubusercontent.com/ZZROTDesign/docker-clean/v$DOCKER_CLEAN_VERSION/docker-clean"
        chmod +x /usr/local/bin/docker-clean
    fi

    ## drive

    curl -sL "https://github.com/timonier/drive/raw/master/bin/installer" | sh -s install

    ## extract-xiso

    curl -sL "https://github.com/timonier/extract-xiso/raw/master/bin/installer" | sh -s install

    ## filezilla

    apt-get install -y --no-install-recommends \
        filezilla

    ## git-up

    curl -sL "https://github.com/timonier/git-up/raw/master/bin/installer" | sh -s install

    ## gparted

    apt-get install -y --no-install-recommends \
        gpart \
        gparted

    ## homebank

    curl -sL "https://github.com/timonier/homebank/raw/master/bin/installer" | sh -s install

    ## intellij

    if [ ! -d /opt/intellij ] ; then
        INTELLIJ_VERSION="14.1.5"
        INTELLIJ_BUILD="141.2735.5"

        curl -sLo /tmp/ideaIC-$INTELLIJ_VERSION.tar.gz "http://download.jetbrains.com/idea/ideaIC-$INTELLIJ_VERSION.tar.gz"
        tar -zxvf /tmp/ideaIC-$INTELLIJ_VERSION.tar.gz -C /opt/
        mv /opt/idea-IC-$INTELLIJ_BUILD /opt/intellij
    fi

    ## java

    apt-get install -y --no-install-recommends \
        openjdk-8-jdk \
        openjdk-8-jre

    ## keepass

    apt-get install -y --no-install-recommends \
        keepass2

    ## libreoffice

    apt-get install -y --no-install-recommends \
        libreoffice \
        libreoffice-l10n-fr \
        libreoffice-style-sifr

    ## license

    curl -sLo /usr/local/bin/license "https://storage.googleapis.com/license-binaries/linux_amd64/license"
    chmod +x /usr/local/bin/license

    ## mnemosyne

    curl -sL "https://github.com/timonier/mnemosyne/raw/master/bin/installer" | sh -s install

    ## myspell

    apt-get install -y --no-install-recommends \
        myspell-fr

    ## mysql

    if [ ! -f /etc/systemd/mysql.service ] ; then
        cp -rT ./src/system/etc/systemd/system/mysql.service /etc/systemd/system/mysql.service
        systemctl daemon-reload
    fi

    cp -rT ./src/system/usr/local/bin/mysql /usr/local/bin/mysql

    ## nodejs

    cp -rT ./src/system/usr/local/bin/node /usr/local/bin/node
    cp -rT ./src/system/usr/local/bin/npm /usr/local/bin/npm

    ## npm-proxy-cache

    if [ ! -f /etc/systemd/npm-proxy-cache.service ] ; then
        cp -rT ./src/system/etc/systemd/system/npm-proxy-cache.service /etc/systemd/system/npm-proxy-cache.service
        systemctl daemon-reload
    fi

    ## php

    curl -sL "https://github.com/mauchede/php/raw/master/bin/installer" | sh -s install

    curl -sLo /usr/local/bin/composer "https://getcomposer.org/composer.phar"
    chmod +x /usr/local/bin/melody

    curl -sLo /usr/local/bin/melody "http://get.sensiolabs.org/melody.phar"
    chmod +x /usr/local/bin/melody

    curl -sLo /usr/local/bin/symfony "http://symfony.com/installer"
    chmod +x /usr/local/bin/symfony

    ## phpstorm

    if [ ! -d /opt/phpstorm ] ; then
        PHPSTORM_VERSION="9.0.2"
        PHPSTORM_BUILD="141.2462"

        curl -sLo /tmp/PhpStorm-$PHPSTORM_VERSION.tar.gz "http://download.jetbrains.com/webide/PhpStorm-$PHPSTORM_VERSION.tar.gz"
        tar -zxvf /tmp/PhpStorm-$PHPSTORM_VERSION.tar.gz -C /opt/
        mv /opt/PhpStorm-$PHPSTORM_BUILD /opt/phpstorm
    fi

    ## picard

    apt-get install -y --no-install-recommends \
        picard

    ## postgresql

    if [ ! -f /etc/systemd/postgresql.service ] ; then
        cp -rT ./src/system/etc/systemd/system/postgresql.service /etc/systemd/system/postgresql.service
        systemctl daemon-reload
    fi

    cp -rT ./src/system/usr/local/bin/psql /usr/local/bin/psql

    ## powertop

    apt-get install -y --no-install-recommends \
        powertop

    cp -rT ./src/system/etc/rc.local /etc/rc.local

    ## rancher

    if [ ! -f /usr/local/bin/rancher-compose ] ; then
        RANCHER_VERSION="v0.5.3"

        curl -sLo /tmp/rancher-compose-linux-amd64-$RANCHER_VERSION.tar.gz "https://github.com/rancher/rancher-compose/releases/download/$RANCHER_VERSION/rancher-compose-linux-amd64-$RANCHER_VERSION.tar.gz"
        tar -zxvf /tmp/rancher-compose-linux-amd64-$RANCHER_VERSION.tar.gz -C /tmp
        mv /tmp/rancher-compose-$RANCHER_VERSION/rancher-compose /usr/local/bin/rancher-compose
    fi

    ## remmina

    apt-get install -y --no-install-recommends \
        remmina

    ## skype

    curl -sL "https://github.com/timonier/skype/raw/master/bin/installer" | sh -s install

    ## soapui

    if [ ! -d /opt/soapui ] ; then
        SOAPUI_VERSION="5.1.3"

        curl -sLo /tmp/SoapUI-$SOAPUI_VERSION-linux-bin.tar.gz "http://smartbearsoftware.com/distrib/soapui/$SOAPUI_VERSION/SoapUI-$SOAPUI_VERSION-linux-bin.tar.gz"
        tar -zxvf /tmp/SoapUI-$SOAPUI_VERSION-linux-bin.tar.gz -C /opt/
        mv /opt/SoapUI-$SOAPUI_VERSION /opt/soapui
    fi

    ## rsync

    apt-get install -y --no-install-recommends \
        rsync

    ## ssh

    apt-get install -y --no-install-recommends \
        sshpass

    ## thermald

    apt-get install -y --no-install-recommends \
        thermald

    ## unity-tweak-tool

    apt-get install -y --no-install-recommends \
        unity-tweak-tool

    ## vlc

    apt-get install -y --no-install-recommends \
        browser-plugin-vlc \
        vlc

    ## xfce4-terminal

    apt-get install -y --no-install-recommends \
        xfce4-terminal

    ## xmllint

    apt-get install -y --no-install-recommends \
        libxml2-utils

# configuration

    ## intel hardware

    if ! grep --quiet "intel_pstate=enable" /etc/default/grub ; then
        sed -i 's/quiet splash/quiet splash intel_pstate=enable/' /etc/default/grub
        update-grub
    fi

    cp -rT ./src/system/usr/share/X11/xorg.conf.d/20-intel.conf /usr/share/X11/xorg.conf.d/20-intel.conf

    ## kernel

    if ! grep --quiet "fs.inotify.max_user_watches" /etc/sysctl.conf ; then
        echo "fs.inotify.max_user_watches=524288" | tee -a /etc/sysctl.conf
    fi

# clean

    ## apt

    apt-get autoremove -y --purge
    apt-get clean
