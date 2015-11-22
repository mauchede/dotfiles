#!/bin/bash
set -ex
cd "`dirname "$0"`/.."

if [[ $EUID != 0 ]] ; then
    echo "Impossible to prepare the system without root privileges." 1>&2
    exit 1
fi

# install

    ## base

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

    ## archives

    apt-get install -y --no-install-recommends \
        p7zip-full \
        rar \
        unrar \
        unzip \
        zip

    ## bower

    curl -sLo /usr/local/bin/bower https://raw.githubusercontent.com/mauchede/bower/master/bin/bower
    chmod +x /usr/local/bin/bower

    ## chromium-browser

    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

    echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" > /etc/apt/sources.list.d/google-talkplugin.list
    apt-get update

    apt-get install -y --no-install-recommends \
        chromium-browser \
        chromium-browser-l10n \
        google-talkplugin \
        pepperflashplugin-nonfree

    ## codecs

    apt-get install -y \
        ubuntu-restricted-extras

    ## docker

    if [[ ! -f /usr/bin/docker ]] ; then
        curl -sSL https://get.docker.com/ | sh

        echo "DOCKER_OPTS=\"-s overlay\"" > /etc/default/docker
    fi

    curl -sLo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.4.0/docker-compose-$(uname -s)-$(uname -m)
    chmod +x /usr/local/bin/docker-compose

    ## drive

    curl -sLo /usr/local/bin/drive https://raw.githubusercontent.com/mauchede/drive/master/bin/drive
    chmod +x /usr/local/bin/drive

    ## filezilla

    apt-get install -y --no-install-recommends \
        filezilla

    ## git

    apt-get install -y --no-install-recommends \
        git

    curl -sLo /usr/local/bin/git-up https://raw.githubusercontent.com/mauchede/git-up/master/bin/git-up
    chmod +x /usr/local/bin/git-up

    ## gparted

    apt-get install -y --no-install-recommends \
        gpart \
        gparted

    ## homebank

    curl -sLo /usr/local/bin/homebank https://github.com/mauchede/homebank/raw/master/bin/homebank
    chmod +x /usr/local/bin/homebank

    ## keepass

    apt-get install -y --no-install-recommends \
        keepass2

    ## intellij

    if [[ ! -d /opt/intellij ]] ; then
        curl -sLo /tmp/ideaIC-14.1.5.tar.gz http://download.jetbrains.com/idea/ideaIC-14.1.5.tar.gz
        tar -zxvf /tmp/ideaIC-14.1.5.tar.gz -C /opt/
        mv /opt/idea-IC-141.2735.5 /opt/intellij
    fi

    ## java

    apt-get install -y --no-install-recommends \
        openjdk-8-jdk \
        openjdk-8-jre

    ## libreoffice

    apt-get install -y --no-install-recommends \
        libreoffice \
        libreoffice-l10n-fr \
        libreoffice-style-sifr

    ## mnemosyne

    curl -sLo /usr/local/bin/mnemosyne https://raw.githubusercontent.com/mauchede/mnemosyne/master/bin/mnemosyne
    chmod +x /usr/local/bin/mnemosyne

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

    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin
    mv /usr/local/bin/composer.phar /usr/local/bin/composer

    curl -sLo /usr/local/bin/melody http://get.sensiolabs.org/melody.phar
    chmod a+x /usr/local/bin/melody

    curl -sLo /usr/local/bin/symfony http://symfony.com/installer
    chmod a+x /usr/local/bin/symfony

    ## phpstorm

    if [[ ! -d /opt/phpstorm ]] ; then
        curl -sLo /tmp/PhpStorm-9.0.2.tar.gz http://download.jetbrains.com/webide/PhpStorm-9.0.2.tar.gz
        tar -zxvf /tmp/PhpStorm-9.0.2.tar.gz -C /opt/
        mv /opt/PhpStorm-141.2462 /opt/phpstorm
    fi

    ## picard

    apt-get install -y --no-install-recommends \
        picard

    ## remmina

    apt-get install -y --no-install-recommends \
        remmina

    ## soapui

    if [[ ! -d /opt/soapui ]] ; then
        curl -sLo /tmp/SoapUI-5.1.3-linux-bin.tar.gz http://downloads.sourceforge.net/project/soapui/soapui/5.1.3/SoapUI-5.1.3-linux-bin.tar.gz
        tar -zxvf /tmp/SoapUI-5.1.3-linux-bin.tar.gz -C /opt/
        mv /opt/SoapUI-5.1.3 /opt/soapui
    fi

    ## rsync

    apt-get install -y --no-install-recommends \
        rsync

    ## ssh

    apt-get install -y --no-install-recommends \
        sshpass

    ## unity

    apt-get remove -y --purge \
        unity-lens-files

    ## vlc

    apt-get install -y --no-install-recommends \
        vlc

    ## xfce4-terminal

    apt-get install -y --no-install-recommends \
        xfce4-terminal

    ## xmllint

    apt-get install -y --no-install-recommends \
        libxml2-utils

# clean

apt-get autoremove -y --purge
apt-get clean
