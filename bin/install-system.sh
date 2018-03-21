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
    snap refresh --list

    ## Install base

    apt-get install --no-install-recommends --yes \
        ca-certificates \
        curl \
        default-jdk \
        default-jre \
        dos2unix \
        htop \
        libappindicator1 \
        libxml2-utils \
        p7zip-full \
        printer-driver-escpr \
        rar \
        rsync \
        unrar \
        unzip \
        vim \
        wget \
        zip
    apt-get install --yes \
        xubuntu-restricted-extras \

    ## Install docker-ce

        ### Stop previous instance

        if [ -f /etc/systemd/system/docker.service ] ; then
            for TARGET in $(systemctl list-unit-files | cut --delimiter " " --field 1 | grep ".service" | grep -v "@" | head --lines -2 | tail --lines +2) ; do
                systemctl show -p Requires "${TARGET}" | grep --quiet "docker.service" && systemctl disable "$(echo "${TARGET}" | sed "s@.service@.timer@g")" || :
                systemctl show -p Requires "${TARGET}" | grep --quiet "docker.service" && systemctl disable "${TARGET}" || :
            done
            for TARGET in $(systemctl list-unit-files | cut --delimiter " " --field 1 | grep ".service" | grep -v "@" | head --lines -2 | tail --lines +2) ; do
                systemctl show -p Requires "${TARGET}" | grep --quiet "docker.service" && systemctl stop "$(echo "${TARGET}" | sed "s@.service@.timer@g")" || :
                systemctl show -p Requires "${TARGET}" | grep --quiet "docker.service" && systemctl stop "${TARGET}" || :
            done
            systemctl stop docker
        fi

        ### Install docker-ce

        export $(curl --location "https://github.com/timonier/version-lister/raw/generated/docker/docker-ce/latest" | xargs)
        curl --location --output /tmp/docker.tgz "https://download.docker.com/linux/static/edge/x86_64/docker-${DOCKER_CE_VERSION}-ce.tgz"
        tar --directory /tmp --extract --file /tmp/docker.tgz
        rm --force /usr/local/sbin/docker*
        mv /tmp/docker/docker* /usr/local/sbin/
        rm --force --recursive /tmp/docker*
        groupadd --gid 999 docker || :

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

    ## Install atom

    snap install --classic \
        atom

    ## Install blackfire

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/user/blackfire.service /etc/systemd/user/blackfire.service

    ## Install datagrip

    snap install --classic \
        datagrip

    ## Install docker-certificate

    curl --location "https://github.com/mauchede/docker-certificate/raw/master/bin/installer" | sh -s -- install

    ## Install docker-compose

    export $(curl --location "https://github.com/timonier/version-lister/raw/generated/docker/compose/latest" | xargs)
    curl --location --output /usr/local/sbin/docker-compose "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-linux-x86_64"
    chmod +x /usr/local/sbin/docker-compose

    ## Install drive

    curl --location "https://github.com/timonier/drive/raw/master/bin/installer" | sh -s -- install

    ## Install etcher

    export ETCHER_VERSION="$(curl --silent "https://github.com/resin-io/etcher/releases" | grep --only-matching --perl-regexp "(?<=etcher-)[0-9\.]+(?=-x86_64\.AppImage)" | head --lines 1)"
    rm --force --recursive /opt/etcher
    curl --location --output /tmp/etcher.zip "https://github.com/resin-io/etcher/releases/download/v${ETCHER_VERSION}/etcher-${ETCHER_VERSION}-linux-x86_64.zip"
    mkdir --parents /opt/etcher
    sh -c "cd /opt/etcher && unzip /tmp/etcher.zip"
    mv "/opt/etcher/etcher-${ETCHER_VERSION}-x86_64.AppImage" /opt/etcher/etcher

    ## Install extract

    cp --no-target-directory ./src/system/usr/local/bin/extract /usr/local/bin/extract

    ## Install extract-xiso

    curl --location "https://github.com/timonier/extract-xiso/raw/master/bin/installer" | sh -s -- install

    ## Install fabric

    curl --location "https://github.com/timonier/fabric/raw/master/bin/installer" | sh -s -- install

    ## Install filezilla

    apt-get install --no-install-recommends --yes \
        filezilla

    ## Install firefox

    snap install --classic \
        firefox

    ## Install git

        ### Install git

        apt-get install --no-install-recommends --yes \
            git

        ### Install git-credential-gnome-keyring

        apt-get install --no-install-recommends --yes \
            libgnome-keyring-dev

        sh -c "cd /usr/share/doc/git/contrib/credential/gnome-keyring && make"

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
            echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release --codename --short) main" > /etc/apt/sources.list.d/google-cloud-sdk.list
            apt-get update
        fi

        ### Install google-cloud-sdk

        apt-get install --no-install-recommends --yes \
            google-cloud-sdk

    ## Install gparted

    apt-get install --no-install-recommends --yes \
        gpart \
        gparted

    ## Install homebank

    curl --location "https://github.com/timonier/homebank/raw/master/bin/installer" | sh -s -- install

    ## Install intellij

    snap install --classic \
        intellij-idea-community

    ## Install joplin

    export JOPLIN_VERSION="$(curl --silent "https://github.com/laurent22/joplin/releases" | grep --only-matching --perl-regexp "(?<=Joplin-)[0-9\.]+(?=-x86_64\.AppImage)" | head --lines 1)"
    rm --force --recursive /opt/joplin
    mkdir --parent /opt/joplin
    curl --location --output /opt/joplin/joplin "https://github.com/laurent22/joplin/releases/download/v${JOPLIN_VERSION}/Joplin-${JOPLIN_VERSION}-x86_64.AppImage"
    chmod +x /opt/joplin/joplin

    ## Install jq

    apt-get install --no-install-recommends --yes \
        jq

    ## Install keepassxc

    snap install --classic \
        keepassxc

    ## Install kubectl

    snap install --classic \
        kubectl

    ## Install libreoffice

    snap install --classic \
        libreoffice

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

        curl --location "https://github.com/timonier/mysql/raw/master/bin/installer" | sh -s -- install

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/user/mysql.service /etc/systemd/user/mysql.service

    ## Install nodejs

        ### Install cli

        curl --location "https://github.com/timonier/node/raw/master/bin/installer" | sh -s -- install

    ## Install php

        ### Install cli

        curl --location "https://github.com/timonier/php/raw/master/bin/installer" | sh -s -- install

    ## Install phpstorm

    snap install --classic \
        phpstorm

    ## Install picard

    apt-get install --no-install-recommends --yes \
        picard

    ## Install postgresql

        ### Install cli

        curl --location "https://github.com/timonier/postgresql/raw/master/bin/installer" | sh -s -- install

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/user/postgresql.service /etc/systemd/user/postgresql.service

    ## Install postman

    rm --force --recursive /opt/postman
    curl --location --output /tmp/postman.tar.gz "https://dl.pstmn.io/download/latest/linux64"
    tar --directory /tmp --extract --file /tmp/postman.tar.gz --gzip
    mv /tmp/Postman /opt/postman
    cp --no-target-directory ./src/system/usr/share/applications/postman.desktop /usr/share/applications/postman.desktop
    cp --no-target-directory ./src/system/usr/share/icons/postman.png /usr/share/icons/postman.png

    ## Install powertop

        ### Install cli

        apt-get install --no-install-recommends --yes \
            powertop

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/system/powertop.service /etc/systemd/system/powertop.service
        systemctl daemon-reload
        systemctl enable powertop

    ## Install rabbitmq

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/user/rabbitmq.service /etc/systemd/user/rabbitmq.service

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
        cp --no-target-directory ./src/system/etc/rawdns/rawdns.json.template /etc/rawdns/rawdns.json.template

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/system/rawdns.service /etc/systemd/system/rawdns.service
        systemctl daemon-reload
        systemctl enable rawdns
        systemctl start rawdns

    ## Install redis

        ### Install cli

        curl --location "https://github.com/timonier/redis/raw/master/bin/installer" | sh -s -- install

        ### Install service

        cp --no-target-directory ./src/system/etc/systemd/user/redis.service /etc/systemd/user/redis.service

    ## Install remmina

    snap install --classic \
        remmina

    ## Install restic

    curl --location "https://github.com/timonier/restic/raw/master/bin/installer" | sh -s -- install restic

    ## Install seahorse

    apt-get install --no-install-recommends --yes \
        seahorse

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

    ## Install skype

    snap install --classic \
        skype

    ## Install slack

    snap install --classic \
        slack

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

    snap install --classic \
        vlc

    ## Install webstorm

    snap install --classic \
        webstorm

    ## Install xfce4-terminal

    apt-get install --no-install-recommends --yes \
        xfce4-terminal

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
