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

apt-get update
apt-get upgrade --yes
apt-get dist-upgrade --yes
snap refresh --list

# Install base

apt-get install --no-install-recommends --yes ca-certificates curl exfat-fuse exfat-utils htop p7zip-full printer-driver-escpr rar vim
apt-get install --yes ubuntu-restricted-extras

# Install docker-ce

if [ -f /etc/systemd/system/docker.service ]; then
    systemctl stop docker
fi

export $(curl --location "https://github.com/mauchede/version-lister/raw/generated/docker/docker-ce/latest" | xargs)
rm -f -r /tmp/docker* /usr/local/sbin/containerd* /usr/local/sbin/ctr /usr/local/sbin/docker* /usr/local/sbin/runc /usr/local/sbin/runc
curl --location --output /tmp/docker.tgz "${DOCKER_CE_LINUX_RELEASE}"
tar --directory /tmp --extract --file /tmp/docker.tgz
mv /tmp/docker/* /usr/local/sbin/

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

# Install atom

snap install --classic atom

# Install chromium

snap install --devmode chromium

# Install direnv

apt-get install --no-install-recommends --yes direnv

# Install docker-compose

export $(curl --location "https://github.com/mauchede/version-lister/raw/generated/docker/compose/latest" | xargs)
curl --location --output /usr/local/sbin/docker-compose "${COMPOSE_LINUX_RELEASE}"
chmod +x /usr/local/sbin/docker-compose

# Install drive

curl --location "https://github.com/timonier/drive/raw/master/bin/installer" | sh -s -- install

# Install extract

cp --no-target-directory ./src/system/rootfs/usr/local/bin/extract /usr/local/bin/extract

# Install filezilla

apt-get install --no-install-recommends --yes filezilla

# Install firefox

snap install --devmode firefox

# Install ffmpeg

apt-get install --no-install-recommends --yes ffmpeg

# Install git

apt-get install --no-install-recommends --yes git git-remote-gcrypt

# Install gparted

apt-get install --no-install-recommends --yes gparted

# Install guake

apt-get install --no-install-recommends --yes guake

# Install hostess

export $(curl --location "https://gitlab.com/mauchede/version-lister/raw/generated/cbednarski/hostess/latest" | xargs)
curl --location --output /usr/local/sbin/hostess "${HOSTESS_LINUX_RELEASE}"
chmod +x /usr/local/sbin/hostess

# Install keybase

curl --location "https://keybase.io/docs/server_security/code_signing_key.asc" | apt-key add
cp --no-target-directory ./src/system/rootfs/etc/apt/sources.list.d/keybase.list /etc/apt/sources.list.d/keybase.list
apt-get update
apt-get install --no-install-recommends --yes keybase

# Install keepassxc

snap install --devmode keepassxc

# Install jq

snap install --devmode jq

# Install libreoffice

snap install --devmode libreoffice

# Install license

curl --location "https://github.com/timonier/license/raw/master/bin/installer" | sh -s -- install

# Install myspell

apt-get install --no-install-recommends --yes myspell-fr

# Install phpstorm

snap install --classic phpstorm

# Install postman

snap install --devmode postman

# Install shellcheck

apt-get install --no-install-recommends --yes shellcheck
cp --no-target-directory ./src/system/rootfs/usr/local/bin/shellcheck-folder /usr/local/bin/shellcheck-folder

# Install shfmt

export $(curl --location "https://github.com/mauchede/version-lister/raw/generated/mvdan/sh/latest" | xargs)
curl --location --output /usr/local/bin/shfmt "${SH_LINUX_RELEASE}"
chmod +x /usr/local/bin/shfmt

# Install skype

snap install --classic skype

# Install slack

snap install --classic slack

# Install spotify

snap install --devmode spotify

# Install sshuttle

curl --location "https://github.com/timonier/sshuttle/raw/master/bin/installer" | sh -s -- install

# Install vlc

snap install --classic vlc

# Install webstorm

snap install --classic webstorm

# Clean

apt-get autoremove --purge --yes
apt-get clean
