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

apt-get install --no-install-recommends --yes ca-certificates curl exfat-fuse gawk htop make p7zip-full printer-driver-escpr rar vim
apt-get install --yes ubuntu-restricted-extras

# Install docker-ce

apt-get install --no-install-recommends --yes docker.io
systemctl enable docker
systemctl start docker

# Configure sudo

cp --no-target-directory ./src/system/rootfs/etc/sudoers.d/sudo /etc/sudoers.d/sudo

# Configure user "root"

cp --no-target-directory --recursive ./src/user/rootfs/.bash_aliases.d /root/.bash_aliases.d
cp --no-target-directory --recursive ./src/user/rootfs/.bash_environment.d /root/.bash_environment.d
cp --no-target-directory ./src/user/rootfs/.bash_profile /root/.bash_profile
cp --no-target-directory ./src/user/rootfs/.bashrc /root/.bashrc

## Install balena etcher

rm -f /tmp/balenaEtcher-1.7.9-x64.zip
( cd /tmp && curl --location --output /tmp/balenaEtcher-1.7.9-x64.zip "https://github.com/balena-io/etcher/releases/download/v1.7.9/balena-etcher-electron-1.7.9-linux-x64.zip" && unzip /tmp/balenaEtcher-1.7.9-x64.zip )
rm -f /tmp/balenaEtcher-1.7.9-x64.zip
mv /tmp/balenaEtcher-1.7.9-x64.AppImage /usr/local/bin/balenaEtcher
chmod +x /usr/local/bin/balenaEtcher

# Install chromium

snap install chromium
snap refresh chromium

# Install composer

cp --no-target-directory ./src/system/rootfs/usr/local/bin/composer /usr/local/bin/composer

# Install discord

curl --location --output /tmp/discord.deb "https://discord.com/api/download?platform=linux&format=deb"
apt-get install --no-install-recommends --yes libappindicator1 libatomic1 libc++1 libgconf-2-4
dpkg -i /tmp/discord.deb

# Install docker-compose

apt-get install --no-install-recommends --yes docker-compose

# Install extract

cp --no-target-directory ./src/system/rootfs/usr/local/bin/extract /usr/local/bin/extract

# Install filezilla

apt-get install --no-install-recommends --yes filezilla

# Install firefox

snap install firefox
snap refresh firefox

# Install ffmpeg

apt-get install --no-install-recommends --yes ffmpeg

# Install git

apt-get install --no-install-recommends --yes git git-remote-gcrypt

# Install gparted

apt-get install --no-install-recommends --yes gparted

# Install guake

apt-get install --no-install-recommends --yes guake

# Install hostess

curl --location --output /usr/local/sbin/hostess "https://github.com/cbednarski/hostess/releases/download/v0.5.2/hostess_linux_amd64"
chmod +x /usr/local/sbin/hostess

# Install imagemagick

apt-get install --no-install-recommends --yes imagemagick
sed -e 's@<policy domain="coder" rights="none" pattern="PDF" />@<policy domain="coder" rights="read | write" pattern="PDF" />@g' -i /etc/ImageMagick-6/policy.xml

# Install java

apt-get install --no-install-recommends --yes default-jdk default-jre

# Install jq

snap install jq
snap refresh jq

# Install libreoffice

snap install libreoffice
snap refresh libreoffice

# Install mkcert

apt-get install --no-install-recommends --yes libnss3-tools
curl --location --output /usr/local/bin/mkcert "https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-linux-amd64"
chmod +x /usr/local/bin/mkcert

# Install node

snap install --classic node
snap refresh node

# Install phpstorm

snap install --classic phpstorm
snap refresh phpstorm

# Install postman

snap install --devmode postman
snap refresh postman

# Install simple-scan

apt-get install --no-install-recommends --yes simple-scan

# Install slack

snap install slack
snap refresh slack

# Install spotify

snap install spotify
snap refresh spotify

# Install vlc

snap install vlc
snap refresh vlc

# Install vscodium

snap install --classic codium
snap refresh codium

# Clean

apt-get autoremove --purge --yes
apt-get clean
