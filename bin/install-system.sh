#!/bin/bash
set -ex
cd "`dirname "$0"`/.."

if [[ $EUID != 0 ]] ; then
    echo "Impossible to prepare the system without root privileges." 1>&2
    exit 1
fi

# installation

    ## base

    if grep --quiet "deb http://archive.canonical.com/ $(lsb_release -cs) partner" /etc/apt/sources.list ; then
        add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -cs) partner"
    fi

    if [[ ! -f /etc/apt/sources.list.d/noobslab-ubuntu-icons-$(lsb_release -cs).list ]] ; then
        add-apt-repository -y ppa:noobslab/icons
    fi

    apt-get update

    apt-get install -y --no-install-recommends \
        curl \
        htop \
        myspell-fr \
        powertop \
        thermald \
        vim \
        wget

    if ! grep --quiet "intel_pstate=enable" /etc/default/grub ; then
        sed -i 's/quiet splash/quiet splash intel_pstate=enable/' /etc/default/grub
        update-grub
    fi

    if ! grep --quiet "fs.inotify.max_user_watches" /etc/sysctl.conf ; then
        echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
    fi

    ## ansible

    apt-add-repository -y ppa:ansible/ansible
    apt-get update

    apt-get install -y --no-install-recommends \
        ansible

    ## archives

    apt-get install -y --no-install-recommends \
        p7zip-full \
        rar \
        unrar \
        unzip \
        zip

    ## bower

    curl -sSL https://github.com/timonier/bower/raw/master/bin/installer | bash -s install

    ## chromium-browser

    apt-get install -y --no-install-recommends \
        chromium-browser \
        chromium-browser-l10n \
        pepperflashplugin-nonfree

    ## codecs

    apt-get install -y \
        ubuntu-restricted-extras

    ## docker

    if [[ ! -f /usr/bin/docker ]] ; then
        curl -sSL https://get.docker.com/ | sh
    fi

    if [[ ! -f /usr/local/bin/docker-compose ]] ; then
        DOCKER_COMPOSE_VERSION="1.4.0"

        curl -sLo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)
        chmod +x /usr/local/bin/docker-compose
    fi

    ## drive

    curl -sSL https://github.com/timonier/drive/raw/master/bin/installer | bash -s install

    ## filezilla

    apt-get install -y --no-install-recommends \
        filezilla

    ## git

    apt-get install -y --no-install-recommends \
        git

    curl -sSL https://github.com/timonier/git-up/raw/master/bin/installer | bash -s install

    ## gparted

    apt-get install -y --no-install-recommends \
        gpart \
        gparted

    ## homebank

    curl -sSL https://github.com/timonier/homebank/raw/master/bin/installer | bash -s install

    ## intellij

    if [[ ! -d /opt/intellij ]] ; then
        INTELLIJ_VERSION="14.1.5"
        INTELLIJ_PACKAGE_VERSION="141.2735.5"

        curl -sLo /tmp/ideaIC-$INTELLIJ_VERSION.tar.gz http://download.jetbrains.com/idea/ideaIC-$INTELLIJ_VERSION.tar.gz
        tar -zxvf /tmp/ideaIC-$INTELLIJ_VERSION.tar.gz -C /opt/
        mv /opt/idea-IC-$INTELLIJ_PACKAGE_VERSION /opt/intellij
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

    curl -sLo /usr/local/bin/license https://storage.googleapis.com/license-binaries/linux_amd64/license
    chmod +x /usr/local/bin/license

    ## mnemosyne

    curl -sSL https://github.com/timonier/mnemosyne/raw/master/bin/installer | bash -s install

    ## php

    apt-get install -y --no-install-recommends \
        php5-apcu \
        php5-cli \
        php5-curl \
        php5-intl \
        php5-mysqlnd \
        php5-pgsql \
        php5-readline \
        php5-xdebug

    rm /etc/php5/cli/conf.d/20-xdebug.ini

    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin
    mv /usr/local/bin/composer.phar /usr/local/bin/composer

    curl -sLo /usr/local/bin/melody http://get.sensiolabs.org/melody.phar
    chmod a+x /usr/local/bin/melody

    curl -sLo /usr/local/bin/symfony http://symfony.com/installer
    chmod a+x /usr/local/bin/symfony

    ## phpstorm

    if [[ ! -d /opt/phpstorm ]] ; then
        PHPSTORM_VERSION="9.0.2"
        PHPSTORM_PACKAGE_VERSION="141.2462"

        curl -sLo /tmp/PhpStorm-$PHPSTORM_VERSION.tar.gz http://download.jetbrains.com/webide/PhpStorm-$PHPSTORM_VERSION.tar.gz
        tar -zxvf /tmp/PhpStorm-$PHPSTORM_VERSION.tar.gz -C /opt/
        mv /opt/PhpStorm-$PHPSTORM_PACKAGE_VERSION /opt/phpstorm
    fi

    ## picard

    apt-get install -y --no-install-recommends \
        picard

    ## rancher

    if [[ ! -f /usr/local/bin/rancher-compose ]] ; then
        RANCHER_VERSION="v0.5.3"

        curl -sLo /tmp/rancher-compose-linux-amd64-$RANCHER_VERSION.tar.gz "https://github.com/rancher/rancher-compose/releases/download/$RANCHER_VERSION/rancher-compose-linux-amd64-$RANCHER_VERSION.tar.gz"
        tar -zxvf /tmp/rancher-compose-linux-amd64-$RANCHER_VERSION.tar.gz -C /tmp
        mv /tmp/rancher-compose-$RANCHER_VERSION/rancher-compose /usr/local/bin/rancher-compose
    fi

    ## remmina

    apt-get install -y --no-install-recommends \
        remmina

    ## soapui

    if [[ ! -d /opt/soapui ]] ; then
        SOAPUI_VERSION="5.1.3"

        curl -sLo /tmp/SoapUI-$SOAPUI_VERSION-linux-bin.tar.gz http://downloads.sourceforge.net/project/soapui/soapui/$SOAPUI_VERSION/SoapUI-$SOAPUI_VERSION-linux-bin.tar.gz
        tar -zxvf /tmp/SoapUI-$SOAPUI_VERSION-linux-bin.tar.gz -C /opt/
        mv /opt/SoapUI-$SOAPUI_VERSION /opt/soapui
    fi

    ## rsync

    apt-get install -y --no-install-recommends \
        rsync

    ## ssh

    apt-get install -y --no-install-recommends \
        sshpass

    ## unity

    apt-get install -y --no-install-recommends \
        ultra-flat-icons

    apt-get remove -y --purge \
        unity-lens-files

    if [[ ! -d /usr/share/themes/Flatabulous ]] ; then
        git clone https://github.com/anmoljagetia/Flatabulous /usr/share/themes/Flatabulous
    fi

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

cp -rT ./src/system /

# clean

    ## docker

    systemctl stop docker
    rm -rf /var/lib/docker
    systemctl start docker

    ## apt

    apt-get autoremove -y --purge
    apt-get clean
