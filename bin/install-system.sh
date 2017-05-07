#!/bin/sh
set -eux
cd "$(dirname "$0")/.."

fail() {
    echo "$1" 1>&2
    exit 1
}

if [ "$(id --user)" != 0 ] ; then
    fail "Impossible to prepare the system without root privileges."
fi

# Preparation

    ## Update system

    apt-get update
    apt-get upgrade --yes
    apt-get dist-upgrade --yes

    ## Install base

    apt-get install --no-install-recommends --yes \
        ca-certificates \
        curl \
        git \
        htop \
        vim \
        wget

    ## Install docker

        ### Install docker

        DOCKER_VERSION="1.13.1"

        if [ -f /etc/systemd/system/docker.service ] ; then
            systemctl stop docker
        fi
        rm --force /usr/local/sbin/docker*

        curl --location --output /tmp/docker.tgz "https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz"
        tar --directory /tmp --extract --file /tmp/docker.tgz
        mv /tmp/docker/docker* /usr/local/sbin/
        rm --force --recursive /tmp/docker*

        groupadd --gid 999 docker || :

        cp --no-target-directory ./src/system/etc/systemd/system/docker.service /etc/systemd/system/docker.service
        cp --no-target-directory ./src/system/etc/systemd/system/docker.socket /etc/systemd/system/docker.socket
        systemctl daemon-reload
        systemctl restart docker

        ### Install docker-clean

        DOCKER_CLEAN_VERSION="2.0.4"

        curl --location --output /usr/local/sbin/docker-clean "https://raw.githubusercontent.com/ZZROTDesign/docker-clean/v${DOCKER_CLEAN_VERSION}/docker-clean"
        chmod +x /usr/local/sbin/docker-clean

        ### Install docker-compose

        DOCKER_COMPOSE_VERSION="1.9.0"

        curl --location --output /usr/local/sbin/docker-compose "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-linux-x86_64"
        chmod +x /usr/local/sbin/docker-compose

        ### Install docker-update

        cp --no-target-directory ./src/system/usr/local/sbin/docker-update /usr/local/sbin/docker-update

        ### Install dumb-entrypoint

        curl --location "https://github.com/timonier/dumb-entrypoint/raw/master/bin/installer" | sh -s install

    ## Configure group "sudo"

    cp --no-target-directory ./src/system/etc/sudoers.d/sudo /etc/sudoers.d/sudo

    ## Configure user "root"

    mkdir --parents /root/bin
    cp --no-target-directory ./src/user/.bash_aliases /root/.bash_aliases
    cp --no-target-directory ./src/user/.bashrc /root/.bashrc
    cp --no-target-directory ./src/user/.profile /root/.profile

# Installation

    ## Install ansible

    apt-get install --no-install-recommends --yes \
        ansible

    ## Install archive tools

    apt-get install --no-install-recommends --yes \
        p7zip-full \
        rar \
        unrar \
        unzip \
        zip

    cp --no-target-directory ./src/system/usr/local/bin/extract /usr/local/bin/extract

    ## Install atom

    curl --location "https://github.com/timonier/atom/raw/master/bin/installer" | sh -s install

    ## Install blackfire

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/user/blackfire.service /etc/systemd/user/blackfire.service

    ## Install chromium-browser

    apt-get install --no-install-recommends --yes \
        chromium-browser \
        chromium-browser-l10n

    ## Install codecs

    apt-get install --yes \
        xubuntu-restricted-extras

    ## Install drive

    curl --location "https://github.com/timonier/drive/raw/master/bin/installer" | sh -s install

    ## Install extract-xiso

    curl --location "https://github.com/timonier/extract-xiso/raw/master/bin/installer" | sh -s install

    ## Install fabric

    curl --location "https://github.com/timonier/fabric/raw/master/bin/installer" | sh -s install

    ## Install filezilla

    apt-get install --no-install-recommends --yes \
        filezilla

    ## Install git-up

    curl --location "https://github.com/timonier/git-up/raw/master/bin/installer" | sh -s install

    ## Install gparted

    apt-get install --no-install-recommends --yes \
        gpart \
        gparted

    ## Install homebank

    curl --location "https://github.com/timonier/homebank/raw/master/bin/installer" | sh -s install

    ## Install intellij

    INTELLIJ_VERSION="2017.1"
    INTELLIJ_BUILD="171.3780.107"

    rm --force --recursive /opt/intellij
    curl --location "https://download.jetbrains.com/idea/ideaIC-${INTELLIJ_VERSION}.tar.gz" | tar --directory /opt --extract --gzip || :
    mv "/opt/idea-IC-${INTELLIJ_BUILD}" /opt/intellij

    ## Install java

    apt-get install --no-install-recommends --yes \
        default-jdk \
        default-jre

    ## Install jq

    apt-get install --no-install-recommends --yes \
        jq

    ## Install keepass

    apt-get install --no-install-recommends --yes \
        keepass2

    ## Install libreoffice

    apt-get install --no-install-recommends --yes \
        libreoffice \
        libreoffice-l10n-fr \
        libreoffice-style-sifr

    ## Install license

    curl --location "https://github.com/timonier/license/raw/master/bin/installer" | sh -s install

    ## Install mailcatcher

        ### Install cli

        curl --location "https://github.com/timonier/mailcatcher/raw/master/bin/installer" | sh -s install

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/user/mailcatcher.service /etc/systemd/user/mailcatcher.service

    ## Install mnemosyne

    apt-get install --no-install-recommends --yes \
        mnemosyne

    ## Install myspell

    apt-get install --no-install-recommends --yes \
        myspell-fr

    ## Install mysql

        ### Install cli

        cp --no-target-directory ./src/system/usr/local/bin/mysql /usr/local/bin/mysql

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/user/mysql.service /etc/systemd/user/mysql.service

    ## Install nodejs

    cp --no-target-directory ./src/system/usr/local/bin/node /usr/local/bin/node
    cp --no-target-directory ./src/system/usr/local/bin/npm /usr/local/bin/npm

    ## Install npm-proxy-cache

        ### Install cli

        curl --location "https://github.com/timonier/npm-proxy-cache/raw/master/bin/installer" | sh -s install

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/system/npm-proxy-cache.service /etc/systemd/system/npm-proxy-cache.service
        systemctl daemon-reload
        systemctl enable npm-proxy-cache
        systemctl start npm-proxy-cache

    ## Install php

        ### Install cli

        curl --location "https://github.com/timonier/php/raw/master/bin/installer" | sh -s install

    ## Install phpstorm

    PHPSTORM_VERSION="2017.1"
    PHPSTORM_BUILD="171.3780.104"

    rm --force --recursive /opt/phpstorm
    curl --location "https://download.jetbrains.com/webide/PhpStorm-${PHPSTORM_VERSION}.tar.gz" | tar --directory /opt --extract --gzip || :
    mv "/opt/PhpStorm-${PHPSTORM_BUILD}" /opt/phpstorm

    ## Install picard

    apt-get install --no-install-recommends --yes \
        picard

    ## Install postgresql

        ### Install cli

        cp --no-target-directory ./src/system/usr/local/bin/pg_dump /usr/local/bin/pg_dump
        cp --no-target-directory ./src/system/usr/local/bin/psql /usr/local/bin/psql

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/user/postgresql.service /etc/systemd/user/postgresql.service

    ## Install powertop

    apt-get install --no-install-recommends --yes \
        powertop

    cp --no-target-directory ./src/system/etc/rc.local /etc/rc.local

    ## Install rabbitmq

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/user/rabbitmq.service /etc/systemd/user/rabbitmq.service

    ## Install rambox

    RAMBOX_VERSION="0.5.3"

    apt-get install --no-install-recommends --yes \
        libappindicator1

    rm --force --recursive /opt/rambox
    curl --location "https://github.com/saenzramiro/rambox/releases/download/${RAMBOX_VERSION}/Rambox-${RAMBOX_VERSION}-x64.tar.gz" | tar --directory /opt --extract --gzip || :
    mv "/opt/Rambox-${RAMBOX_VERSION}" /opt/rambox

    cp --no-target-directory ./src/system/usr/share/applications/rambox.desktop /usr/share/applications/rambox.desktop
    cp --no-target-directory ./src/system/usr/share/icons/rambox.png /usr/share/icons/rambox.png

    ## Install rawdns

    cp --no-target-directory ./src/system/etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf
    cp --no-target-directory ./src/system/etc/resolvconf/resolv.conf.d/head /etc/resolvconf/resolv.conf.d/head

    mkdir --parents /etc/rawdns
    cp --no-target-directory ./src/system/etc/rawdns/rawdns.json /etc/rawdns/rawdns.json

    cp --no-target-directory ./src/system/etc/systemd/system/rawdns.service /etc/systemd/system/rawdns.service
    systemctl daemon-reload
    systemctl enable rawdns
    systemctl start rawdns

    ## Install redis

        ### Install cli

        cp --no-target-directory ./src/system/usr/local/bin/redis-cli /usr/local/bin/redis-cli

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/user/redis.service /etc/systemd/user/redis.service

    ## Install remmina

    apt-get install --no-install-recommends --yes \
        remmina

    ## Install rsync

    apt-get install --no-install-recommends --yes \
        rsync

    ## Install shellcheck

        ### Install shellcheck

        apt-get install --no-install-recommends --yes \
            shellcheck

        ### Install shellcheck-folder

        cp --no-target-directory ./src/system/usr/local/bin/shellcheck-folder /usr/local/bin/shellcheck-folder

    ## Install soapui

    SOAPUI_VERSION="5.1.3"

    rm --force --recursive /opt/soapui
    curl --location "http://smartbearsoftware.com/distrib/soapui/${SOAPUI_VERSION}/SoapUI-${SOAPUI_VERSION}-linux-bin.tar.gz" | tar --directory /opt --extract --gzip || :
    mv "/opt/SoapUI-${SOAPUI_VERSION}" /opt/soapui

    ## Install sshpass

    apt-get install --no-install-recommends --yes \
        sshpass

    ## Install sshuttle

    curl --location "https://github.com/timonier/sshuttle/raw/master/bin/installer" | sudo sh -s install

    ## Install systemd-user

    cp --no-target-directory ./src/system/usr/local/sbin/systemctl-user /usr/local/sbin/systemctl-user

    ## Install thermald

    apt-get install --no-install-recommends --yes \
        thermald

    ## Install transcode

    apt-get install --no-install-recommends --yes \
        transcode

    ## Install vlc

    apt-get install --no-install-recommends --yes \
        browser-plugin-vlc \
        vlc

    ## Install webstorm

    WEBSTORM_VERSION="2017.1.1"
    WEBSTORM_BUILD="171.4073.40"

    rm --force --recursive /opt/webstorm
    curl --location "https://download.jetbrains.com/webstorm/WebStorm-${WEBSTORM_VERSION}.tar.gz" | tar --directory /opt --extract --gzip || :
    mv "/opt/WebStorm-${WEBSTORM_BUILD}" /opt/webstorm

    ## Install xfce4-terminal

    apt-get install --no-install-recommends --yes \
        xfce4-terminal

    ## Install xmllint

    apt-get install --no-install-recommends --yes \
        libxml2-utils

# Optimization

    ## Optimize intel hardware

    if ! grep --quiet "intel_pstate=enable" /etc/default/grub ; then
        sed --in-place "s/quiet splash/quiet splash intel_pstate=enable/" /etc/default/grub
        update-grub
    fi

    cp --no-target-directory ./src/system/usr/share/X11/xorg.conf.d/20-intel.conf /usr/share/X11/xorg.conf.d/20-intel.conf

    ## Optimize kernel

    if ! grep --quiet "fs.inotify.max_user_watches" /etc/sysctl.conf ; then
        echo "fs.inotify.max_user_watches=524288" | tee --append /etc/sysctl.conf
    fi

# Clean

    ## Clean packages

    apt-get autoremove --purge --yes
    apt-get clean
