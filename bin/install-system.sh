#!/bin/sh
set -ex
cd "$(dirname "$0")/.."

fail() {
    echo 1>&2 "$1"
    echo 1>&2 "Usage: $(basename "$0")"
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

        ### Stop previous docker

        if [ -f /etc/systemd/system/docker.service ] ; then
            systemctl list-dependencies --reverse --plain docker.service | tail --lines +2 | xargs --max-lines=1 --no-run-if-empty systemctl stop
            docker-clean stop

            systemctl stop docker
        fi

        ### Install docker

        export $(curl "https://raw.githubusercontent.com/timonier/version-lister/release/generated/docker/latest" | xargs)

        curl --location --output /tmp/docker.tgz "https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}-ce.tgz"
        tar --directory /tmp --extract --file /tmp/docker.tgz
        rm --force /usr/local/sbin/docker*
        mv /tmp/docker/docker* /usr/local/sbin/
        rm --force --recursive /tmp/docker*

        groupadd --gid 999 docker || :

        ### Install docker-clean

        export $(curl "https://raw.githubusercontent.com/timonier/version-lister/release/generated/docker-clean/latest" | xargs)

        curl --location --output /usr/local/sbin/docker-clean "https://raw.githubusercontent.com/ZZROTDesign/docker-clean/v${DOCKER_CLEAN_VERSION}/docker-clean"
        chmod +x /usr/local/sbin/docker-clean

        ### Install docker-compose

        export $(curl "https://raw.githubusercontent.com/timonier/version-lister/release/generated/docker-compose/latest" | xargs)

        curl --location --output /usr/local/sbin/docker-compose "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-linux-x86_64"
        chmod +x /usr/local/sbin/docker-compose

        ### Install docker-update

        cp --no-target-directory ./src/system/usr/local/sbin/docker-update /usr/local/sbin/docker-update

        ### Install dumb-entrypoint

        curl --location "https://github.com/timonier/dumb-entrypoint/raw/master/bin/installer" | sh -s -- install

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/system/docker.service /etc/systemd/system/docker.service
        cp --no-target-directory ./src/system/etc/systemd/system/docker.socket /etc/systemd/system/docker.socket
        systemctl daemon-reload
        systemctl restart docker

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

    curl --location "https://github.com/timonier/atom/raw/master/bin/installer" | sh -s -- install

    ## Install blackfire

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/user/blackfire.service /etc/systemd/user/blackfire.service

    ## Install codecs

    apt-get install --yes \
        xubuntu-restricted-extras

    ## Install drive

    curl --location "https://github.com/timonier/drive/raw/master/bin/installer" | sh -s -- install

    ## Install extract-xiso

    curl --location "https://github.com/timonier/extract-xiso/raw/master/bin/installer" | sh -s -- install

    ## Install fabric

    curl --location "https://github.com/timonier/fabric/raw/master/bin/installer" | sh -s -- install

    ## Install filezilla

    apt-get install --no-install-recommends --yes \
        filezilla

    ## Install git-up

    curl --location "https://github.com/timonier/git-up/raw/master/bin/installer" | sh -s -- install

    ## Install google-chrome

        ### Install ppa

        if [ ! -f /etc/apt/sources.list.d/google-chrome.list ] ; then
            wget --output-document - --quiet "https://dl-ssl.google.com/linux/linux_signing_key.pub" | apt-key add -
            echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
            apt-get update
        fi

        ### Install google-chrome

        apt-get install --no-install-recommends --yes \
            google-chrome-stable

    ## Install google-cloud-sdk

        ### Install ppa

        if [ -f /etc/apt/sources.list.d/google-cloud-sdk ] ; then
            curl "https://packages.cloud.google.com/apt/doc/apt-key.gpg" | apt-key add -
            echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" > /etc/apt/sources.list.d/google-cloud-sdk.list
            apt-get update
        fi

        ### Install google-cloud-sdk

        apt-get install --no-install-recommends --yes \
            google-cloud-sdk \
            kubectl

    ## Install gparted

    apt-get install --no-install-recommends --yes \
        gpart \
        gparted

    ## Install homebank

    curl --location "https://github.com/timonier/homebank/raw/master/bin/installer" | sh -s -- install

    ## Install intellij

    export $(curl "https://raw.githubusercontent.com/timonier/version-lister/release/generated/intellij-idea/latest" | xargs)

    rm --force --recursive /opt/intellij
    curl --location "https://download.jetbrains.com/idea/ideaIC-${INTELLIJ_IDEA_VERSION}.tar.gz" | tar --directory /opt --extract --gzip || :
    mv "/opt/idea-IC-${INTELLIJ_IDEA_BUILD}" /opt/intellij

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

    curl --location "https://github.com/timonier/license/raw/master/bin/installer" | sh -s -- install

    ## Install mailcatcher

        ### Install cli

        curl --location "https://github.com/timonier/mailcatcher/raw/master/bin/installer" | sh -s -- install

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

    ## Install mysql-workbench

    apt-get install --no-install-recommends --yes \
        mysql-workbench

    ## Install nodejs

        ### Install cli

        curl --location "https://github.com/timonier/node/raw/master/bin/installer" | sh -s -- install

    ## Install php

        ### Install cli

        curl --location "https://github.com/timonier/php/raw/master/bin/installer" | sh -s -- install

    ## Install phpstorm

    export $(curl "https://raw.githubusercontent.com/timonier/version-lister/release/generated/phpstorm/latest" | xargs)

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

    export $(curl "https://raw.githubusercontent.com/timonier/version-lister/release/generated/rambox/latest" | xargs)

    apt-get install --no-install-recommends --yes \
        libappindicator1

    rm --force --recursive /opt/rambox
    curl --location "https://github.com/saenzramiro/rambox/releases/download/${RAMBOX_VERSION}/Rambox-${RAMBOX_VERSION}-x64.tar.gz" | tar --directory /opt --extract --gzip || :
    mv "/opt/Rambox-${RAMBOX_VERSION}" /opt/rambox

    cp --no-target-directory ./src/system/usr/share/applications/rambox.desktop /usr/share/applications/rambox.desktop
    cp --no-target-directory ./src/system/usr/share/icons/rambox.png /usr/share/icons/rambox.png

    ## Install rawdns

        ### Configure network-manager

        cp --no-target-directory ./src/system/etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf
        cp --no-target-directory ./src/system/etc/NetworkManager/dispatcher.d/99rawdns /etc/NetworkManager/dispatcher.d/99rawdns

        ### Configure resolvconf

        cp --no-target-directory ./src/system/etc/resolvconf/resolv.conf.d/head /etc/resolvconf/resolv.conf.d/head
        resolvconf -u

        ### Install rawdns-update

        cp --no-target-directory ./src/system/usr/local/sbin/rawdns-update /usr/local/sbin/rawdns-update

        ### Install rawdns configuration

        mkdir --parents /etc/rawdns
        cp --no-target-directory ./src/system/etc/rawdns/rawdns.json /etc/rawdns/rawdns.json

        ### Install service

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

    ## Install selenium

        ### Install services

        cp --no-target-directory ./src/system/etc/systemd/user/selenium-chrome.service /etc/systemd/user/selenium-chrome.service
        cp --no-target-directory ./src/system/etc/systemd/user/selenium-firefox.service /etc/systemd/user/selenium-firefox.service

    ## Install shellcheck

        ### Install shellcheck

        apt-get install --no-install-recommends --yes \
            shellcheck

        ### Install shellcheck-folder

        cp --no-target-directory ./src/system/usr/local/bin/shellcheck-folder /usr/local/bin/shellcheck-folder

    ## Install sshpass

    apt-get install --no-install-recommends --yes \
        sshpass

    ## Install sshuttle

    curl --location "https://github.com/timonier/sshuttle/raw/master/bin/installer" | sh -s -- install

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

    export $(curl "https://raw.githubusercontent.com/timonier/version-lister/release/generated/webstorm/latest" | xargs)

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
