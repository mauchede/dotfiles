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

# Install base

apt-get install --no-install-recommends --yes ca-certificates curl exfat-fuse exfat-utils gawk htop make p7zip-full printer-driver-escpr python3-pip python3-setuptools rar vim
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
systemctl enable docker
systemctl restart docker

# Configure sudo

cp --no-target-directory ./src/system/rootfs/etc/sudoers.d/sudo /etc/sudoers.d/sudo

# Configure user "root"

mkdir -p /root/.bash_aliases.d /root/.bin
cp --no-target-directory ./src/user/rootfs/.bash_aliases.d/docker /root/.bash_aliases.d/docker
cp --no-target-directory ./src/user/rootfs/.bash_aliases.d/ubuntu /root/.bash_aliases.d/ubuntu
cp --no-target-directory ./src/user/rootfs/.bashrc /root/.bashrc
cp --no-target-directory ./src/user/rootfs/.profile /root/.profile

# Install aws-cli

snap install --classic aws-cli
snap refresh aws-cli

# Install composer

cp --no-target-directory ./src/system/rootfs/usr/local/bin/composer /usr/local/bin/composer

# Install discord

snap install --devmode discord
snap refresh discord

# Install docker-compose

pip3 install docker-compose --no-cache-dir --upgrade

# Install drive

curl --location "https://github.com/timonier/drive/raw/master/bin/installer" | sh -s -- install

# Install extract

cp --no-target-directory ./src/system/rootfs/usr/local/bin/extract /usr/local/bin/extract

# Install filezilla

apt-get install --no-install-recommends --yes filezilla

# Install firefox

apt-get install --no-install-recommends --yes firefox firefox-locale-fr

# Install ffmpeg

apt-get install --no-install-recommends --yes ffmpeg

# Install git

apt-get install --no-install-recommends --yes git git-remote-gcrypt

# Install google-chrome

echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
curl --location --output - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | apt-key add -
apt-get update
apt-get install --no-install-recommends google-chrome-stable

# Install gparted

apt-get install --no-install-recommends --yes gparted

# Install guake

apt-get install --no-install-recommends --yes guake

# Install hostess

export $(curl --location "https://gitlab.com/mauchede/version-lister/raw/generated/cbednarski/hostess/latest" | xargs)
curl --location --output /usr/local/sbin/hostess "${HOSTESS_LINUX_RELEASE}"
chmod +x /usr/local/sbin/hostess

# Install hugo

snap install --devmode hugo
snap refresh hugo

# Install keybase

curl --location "https://keybase.io/docs/server_security/code_signing_key.asc" | apt-key add
cp --no-target-directory ./src/system/rootfs/etc/apt/sources.list.d/keybase.list /etc/apt/sources.list.d/keybase.list
apt-get update
apt-get install --no-install-recommends --yes keybase

# Install keepassxc

snap install --devmode keepassxc
snap refresh keepassxc

# Install jq

snap install --devmode jq
snap refresh jq

# Install libreoffice

snap install --devmode libreoffice
snap refresh libreoffice

# Install license

curl --location "https://github.com/timonier/license/raw/master/bin/installer" | sh -s -- install

# Install mkcert

apt-get install --no-install-recommends --yes libnss3-tools
export $(curl --location "https://gitlab.com/mauchede/version-lister/raw/generated/filosottile/mkcert/latest" | xargs)
curl --location --output /usr/local/bin/mkcert "${MKCERT_LINUX_RELEASE}"
chmod +x /usr/local/bin/mkcert

# Install myspell

apt-get install --no-install-recommends --yes myspell-fr

# Install phpstorm

snap install --classic phpstorm
snap refresh phpstorm

# Install postman

snap install --devmode postman
snap refresh postman

# Install shellcheck

apt-get install --no-install-recommends --yes shellcheck
cp --no-target-directory ./src/system/rootfs/usr/local/bin/shellcheck-folder /usr/local/bin/shellcheck-folder

# Install simple-scan

apt-get install --no-install-recommends --yes simple-scan

# Install shfmt

export $(curl --location "https://github.com/mauchede/version-lister/raw/generated/mvdan/sh/latest" | xargs)
curl --location --output /usr/local/bin/shfmt "${SH_LINUX_RELEASE}"
chmod +x /usr/local/bin/shfmt

# Install skype

snap install --classic skype
snap refresh skype

# Install slack

snap install --classic slack
snap refresh slack

# Install spotify

snap install --devmode spotify
snap refresh spotify

# Install sshuttle

apt-get install --no-install-recommends --yes sshuttle

# Install telegram

snap install --devmode telegram-desktop
snap refresh telegram-desktop

# Install visual studio code

snap install --classic code
snap refresh code

# Install vlc

snap install --classic vlc
snap refresh vlc

# Clean

apt-get autoremove --purge --yes
apt-get clean
