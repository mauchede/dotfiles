#!/bin/sh
set -x
cd "`dirname "$0"`/.."

fail() {
    echo $1 1>&2
    exit 1
}

[ $EUID != 0 ] && \
    fail "Impossible to prepare the system without root privileges."

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

    DOCKER_VERSION="1.12.0"
    curl -sLo /tmp/docker.tgz "https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION.tgz"
    tar xvf /tmp/docker.tgz -C /tmp
    mv /tmp/docker/* /usr/local/bin/

    groupadd -g 999 docker

    cp -rT ./src/system/etc/systemd/system/docker.service /etc/systemd/system/docker.service
    cp -rT ./src/system/etc/systemd/system/docker.socket /etc/systemd/system/docker.socket
    systemctl daemon-reload
    systemctl restart docker

    # configure root

    cp -rT ./src/system/user/.bashrc /root/.bashrc

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

    ## blackfire

    cp -rT ./src/system/etc/systemd/system/blackfire.service /etc/systemd/system/blackfire.service
    systemctl daemon-reload

    ## chromium-browser

    apt-get install -y --no-install-recommends \
        chromium-browser \
        chromium-browser-l10n

    ## codecs

    apt-get install -y \
        ubuntu-restricted-extras

    ## docker-compose

    DOCKER_COMPOSE_VERSION="1.7.0"
    curl -sLo /usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)"
    chmod +x /usr/local/bin/docker-compose

    ## docker-clean

    DOCKER_CLEAN_VERSION="2.0.3"
    curl -sLo /usr/local/bin/docker-clean "https://raw.githubusercontent.com/ZZROTDesign/docker-clean/v$DOCKER_CLEAN_VERSION/docker-clean"
    chmod +x /usr/local/bin/docker-clean

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

    cp -rT ./src/system/etc/systemd/system/mysql.service /etc/systemd/system/mysql.service
    systemctl daemon-reload

    cp -rT ./src/system/usr/local/bin/mysql /usr/local/bin/mysql

    ## nodejs

    cp -rT ./src/system/usr/local/bin/node /usr/local/bin/node
    cp -rT ./src/system/usr/local/bin/npm /usr/local/bin/npm

    ## npm-proxy-cache

    cp -rT ./src/system/etc/systemd/system/npm-proxy-cache.service /etc/systemd/system/npm-proxy-cache.service
    systemctl daemon-reload

    ## php

    apt-get install -y --no-install-recommends \
        php-apcu \
        php-bcmath \
        php-cli \
        php-curl \
        php-intl \
        php-gd \
        php-mbstring \
        php-mysql \
        php-pgsql \
        php-readline \
        php-xdebug \
        php-xml \
        php-zip

    curl -sLo /usr/local/bin/composer "https://getcomposer.org/composer.phar"
    chmod +x /usr/local/bin/composer

    curl -sLo /usr/local/bin/melody "http://get.sensiolabs.org/melody.phar"
    chmod +x /usr/local/bin/melody

    curl -sLo /usr/local/bin/symfony "http://symfony.com/installer"
    chmod +x /usr/local/bin/symfony

    ## phpstorm

    if [ ! -d /opt/phpstorm ] ; then
        PHPSTORM_VERSION="2016.2"
        PHPSTORM_BUILD="162.1121.38"

        curl -sLo /tmp/PhpStorm-$PHPSTORM_VERSION.tar.gz "https://download.jetbrains.com/webide/PhpStorm-$PHPSTORM_VERSION.tar.gz"
        tar -zxvf /tmp/PhpStorm-$PHPSTORM_VERSION.tar.gz -C /opt/
        mv /opt/PhpStorm-$PHPSTORM_BUILD /opt/phpstorm
    fi

    ## picard

    apt-get install -y --no-install-recommends \
        picard

    ## postgresql

    cp -rT ./src/system/etc/systemd/system/postgresql.service /etc/systemd/system/postgresql.service
    systemctl daemon-reload

    cp -rT ./src/system/usr/local/bin/psql /usr/local/bin/psql

    ## powertop

    apt-get install -y --no-install-recommends \
        powertop

    cp -rT ./src/system/etc/rc.local /etc/rc.local

    ## rawdns

    cp -rT ./src/system/etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf
    cp -rT ./src/system/etc/resolvconf/resolv.conf.d/head /etc/resolvconf/resolv.conf.d/head

    mkdir -p /srv/rawdns
    cp -rT ./src/system/srv/rawdns/rawdns.json /srv/rawdns/rawdns.json

    cp -rT ./src/system/etc/systemd/system/rawdns.service /etc/systemd/system/rawdns.service
    systemctl daemon-reload
    systemctl enable rawdns

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
