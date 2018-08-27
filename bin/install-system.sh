#!/bin/sh
set -e -u -x
cd "$(dirname "$0")"/..

fail() {
    echo 1>&2 "$1"
    echo 1>&2 "Usage: $(basename "$0")"
    exit 255
}

if [ "$(id --user)" != 0 ]; then
    fail "Impossible to execute this script without root privileges."
fi

# Update system

cp --no-target-directory ./src/system/rootfs/etc/apt/sources.list /etc/apt/sources.list
apt-get update
apt-get upgrade --yes
apt-get dist-upgrade --yes
snap refresh --list

# Install base

apt-get install --no-install-recommends --yes ca-certificates curl dos2unix gcc htop jq libappindicator1 libxml2-utils p7zip-full printer-driver-escpr rar rsync unrar unzip vim wget zip
apt-get install --yes xubuntu-restricted-extras
apt-get remove --purge --yes firefox firefox-locale-* libreoffice-* pidgin pidgin-* thunderbird thunderbird-locale-*
cp --no-target-directory ./src/system/rootfs/usr/local/sbin/systemctl-user /usr/local/sbin/systemctl-user

# Install docker-ce

if [ -f /etc/systemd/system/docker.service ]; then
    systemctl stop docker
fi

export $(curl --location "https://github.com/mauchede/version-lister/raw/generated/docker/docker-ce/latest" | xargs)
rm -f -r /tmp/docker* /usr/local/sbin/docker*
curl --location --output /tmp/docker.tgz "${DOCKER_CE_RELEASE}"
tar --directory /tmp --extract --file /tmp/docker.tgz
mv /tmp/docker/docker* /usr/local/sbin/
groupadd --gid 999 --non-unique docker || :

cp --no-target-directory ./src/system/rootfs/etc/systemd/system/docker.service /etc/systemd/system/docker.service
cp --no-target-directory ./src/system/rootfs/etc/systemd/system/docker.socket /etc/systemd/system/docker.socket
systemctl daemon-reload
systemctl restart docker

# Configure group "sudo"

cp --no-target-directory ./src/system/rootfs/etc/sudoers.d/sudo /etc/sudoers.d/sudo

# Configure user "root"

mkdir -p /root/.bin
cp --no-target-directory ./src/user/rootfs/.bash_aliases /root/.bash_aliases
cp --no-target-directory ./src/user/rootfs/.bashrc /root/.bashrc
cp --no-target-directory ./src/user/rootfs/.profile /root/.profile

# Install arc-theme

apt-get install --no-install-recommends --yes arc-theme

# Install atom

apt-get install --no-install-recommends --yes gvfs-bin
snap install --classic atom

# Install blackfire

cp --no-target-directory ./src/system/rootfs/etc/systemd/user/blackfire.service /etc/systemd/user/blackfire.service

# Install cheese

apt-get install --no-install-recommends --yes cheese

# Install chromium

snap install --classic chromium

# Install docker-certificates

curl --location "https://github.com/mauchede/docker-certificates/raw/master/bin/installer" | sh -s -- install

# Install docker-compose

export $(curl --location "https://github.com/mauchede/version-lister/raw/generated/docker/compose/latest" | xargs)
curl --location --output /usr/local/sbin/docker-compose "${COMPOSE_RELEASE}"
chmod +x /usr/local/sbin/docker-compose

# Install drive

curl --location "https://github.com/timonier/drive/raw/master/bin/installer" | sh -s -- install

# Install etcher

export $(curl --location "https://github.com/mauchede/version-lister/raw/generated/resin-io/etcher/latest" | xargs)
rm -f -r /opt/etcher
mkdir -p /opt/etcher
curl --location --output /opt/etcher/etcher "${ETCHER_RELEASE}"
chmod +x /opt/etcher/etcher

# Install extract

cp --no-target-directory ./src/system/rootfs/usr/local/bin/extract /usr/local/bin/extract

# Install filezilla

apt-get install --no-install-recommends --yes filezilla

# Install firefox

snap install --classic firefox

# Install git

apt-get install --no-install-recommends --yes git
apt-get install --no-install-recommends --yes libgnome-keyring-dev
sh -c "cd /usr/share/doc/git/contrib/credential/gnome-keyring && make"

# Install google-cloud-sdk

apt-get install --no-install-recommends --yes google-cloud-sdk

# Install gparted

apt-get install --no-install-recommends --yes gpart gparted

# Install homebank

add-apt-repository ppa:mdoyen/homebank --remove --yes
add-apt-repository ppa:mdoyen/homebank --yes
apt-get install --no-install-recommends --yes homebank

# Install insomnia

snap install --classic insomnia

# Install intellij

snap install --classic intellij-idea-community

# Install joplin

export $(curl --location "https://github.com/mauchede/version-lister/raw/generated/laurent22/joplin/latest" | xargs)
rm -f -r /opt/joplin
mkdir -p /opt/joplin
curl --location --output /opt/joplin/joplin "${JOPLIN_RELEASE}"
chmod +x /opt/joplin/joplin

# Install keepassxc

export $(curl --location "https://github.com/mauchede/version-lister/raw/generated/keepassxreboot/keepassxc/latest" | xargs)
rm -f -r /opt/keepassxc
mkdir -p /opt/keepassxc
curl --location --output /opt/keepassxc/keepassxc "${KEEPASSXC_RELEASE}"
chmod +x /opt/keepassxc/keepassxc

# Install kubectl

snap install --classic kubectl

# Install libreoffice

snap install --classic libreoffice

# Install license

curl --location "https://github.com/timonier/license/raw/master/bin/installer" | sh -s -- install

# Install mailcatcher

cp --no-target-directory ./src/system/rootfs/etc/systemd/user/mailcatcher.service /etc/systemd/user/mailcatcher.service

# Install moka-icon-theme

apt-get install --no-install-recommends --yes moka-icon-theme

# Install myspell

apt-get install --no-install-recommends --yes myspell-fr

# Install mysql

curl --location "https://github.com/timonier/mysql/raw/master/bin/installer" | sh -s -- install
cp --no-target-directory ./src/system/rootfs/etc/systemd/user/mysql.service /etc/systemd/user/mysql.service

# Install nodejs

curl --location "https://github.com/timonier/node/raw/master/bin/installer" | sh -s -- install

# Install php

curl --location "https://github.com/timonier/php/raw/master/bin/installer" | sh -s -- install

# Install phpstorm

snap install --classic phpstorm

# Install postgresql

curl --location "https://github.com/timonier/postgresql/raw/master/bin/installer" | sh -s -- install
cp --no-target-directory ./src/system/rootfs/etc/systemd/user/postgresql.service /etc/systemd/user/postgresql.service

# Install postman

apt-get install --no-install-recommends --yes libgconf2-4
rm -f -r /opt/postman
curl --location --output /tmp/postman.tar.gz "https://dl.pstmn.io/download/latest/linux64"
tar --directory /tmp --extract --file /tmp/postman.tar.gz --gzip
mv /tmp/Postman /opt/postman
cp --no-target-directory ./src/system/rootfs/usr/share/applications/postman.desktop /usr/share/applications/postman.desktop
cp --no-target-directory ./src/system/rootfs/usr/share/icons/postman.png /usr/share/icons/postman.png

# Install rabbitmq

cp --no-target-directory ./src/system/rootfs/etc/systemd/user/rabbitmq.service /etc/systemd/user/rabbitmq.service

# Install rawdns

mkdir -p /etc/rawdns
cp --no-target-directory ./src/system/rootfs/etc/rawdns/config.json.template /etc/rawdns/config.json.template

mkdir -p /etc/rawdns/scripts
cp --no-target-directory ./src/system/rootfs/etc/rawdns/scripts/generate-configuration /etc/rawdns/scripts/generate-configuration
cp --no-target-directory ./src/system/rootfs/etc/rawdns/scripts/if-up /etc/rawdns/scripts/if-up
chmod +x /etc/rawdns/scripts/generate-configuration /etc/rawdns/scripts/if-up

rm -f /etc/network/if-up.d/rawdns
ln --symbolic /etc/rawdns/scripts/if-up /etc/network/if-up.d/rawdns

rm -f /etc/resolv.conf
ln --symbolic /run/systemd/resolve/resolv.conf /etc/resolv.conf
mkdir -p /etc/systemd/resolved.conf.d
cp --no-target-directory ./src/system/rootfs/etc/systemd/resolved.conf.d/rawdns.conf /etc/systemd/resolved.conf.d/rawdns.conf

cp --no-target-directory ./src/system/rootfs/etc/systemd/system/rawdns.service /etc/systemd/system/rawdns.service
systemctl daemon-reload
systemctl enable rawdns
systemctl restart rawdns
systemctl restart systemd-resolved

# Install redis

curl --location "https://github.com/timonier/redis/raw/master/bin/installer" | sh -s -- install
cp --no-target-directory ./src/system/rootfs/etc/systemd/user/redis.service /etc/systemd/user/redis.service

# Install remmina

snap install --classic remmina

# Install seahorse

apt-get install --no-install-recommends --yes seahorse

# Install selenium

cp --no-target-directory ./src/system/rootfs/etc/systemd/user/selenium-chrome.service /etc/systemd/user/selenium-chrome.service
cp --no-target-directory ./src/system/rootfs/etc/systemd/user/selenium-firefox.service /etc/systemd/user/selenium-firefox.service

# Install shellcheck

apt-get install --no-install-recommends --yes shellcheck
cp --no-target-directory ./src/system/rootfs/usr/local/bin/shellcheck-folder /usr/local/bin/shellcheck-folder

# Install shfmt

export $(curl --location "https://github.com/mauchede/version-lister/raw/generated/mvdan/sh/latest" | xargs)
curl --location --output /usr/local/bin/shfmt "${SH_RELEASE}"
chmod +x /usr/local/bin/shfmt

# Install skype

snap install --classic skype

# Install slack

snap install --classic slack

# Install spotify

snap install --classic spotify

# Install sshpass

apt-get install --no-install-recommends --yes sshpass

# Install sshuttle

curl --location "https://github.com/timonier/sshuttle/raw/master/bin/installer" | sh -s -- install

# Install sup

export $(curl --location "https://github.com/mauchede/version-lister/raw/generated/pressly/sup/latest" | xargs)
curl --location --output /usr/local/bin/sup "${SUP_RELEASE}"
chmod +x /usr/local/bin/sup

# Install thermald

apt-get install --no-install-recommends --yes thermald

# Install transcode

apt-get install --no-install-recommends --yes transcode

# Install vlc

snap install --classic vlc

# Install webstorm

snap install --classic webstorm

# Optimize intel hardware

apt-get install --no-install-recommends --yes intel-microcode
if ! grep -q "intel_pstate=enable" /etc/default/grub; then
    sed --in-place "s@quiet splash@quiet splash intel_pstate=enable@" /etc/default/grub
    update-grub
fi

# Optimize kernel

if ! grep -q "fs.inotify.max_user_watches" /etc/sysctl.conf; then
    echo "fs.inotify.max_user_watches=524288" | tee --append /etc/sysctl.conf
fi

# Clean

apt-get autoremove --purge --yes
apt-get clean
