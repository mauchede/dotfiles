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

apt-get install --no-install-recommends --yes ca-certificates curl exfat-fuse gawk htop make p7zip-full rar vim
apt-get install --yes ubuntu-restricted-extras

# Install docker-ce

curl --location --silent "https://download.docker.com/linux/debian/gpg" | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg --yes
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release --codename --short) stable" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install --no-install-recommends --yes containerd.io docker-buildx-plugin docker-ce docker-ce-cli docker-compose-plugin
systemctl daemon-reload
systemctl enable docker

# Configure sudo

cp --no-target-directory ./src/system/rootfs/etc/sudoers.d/sudo /etc/sudoers.d/sudo

# Configure user "root"

cp --no-target-directory --recursive ./src/user/rootfs/.bash_aliases.d /root/.bash_aliases.d
cp --no-target-directory --recursive ./src/user/rootfs/.bash_environment.d /root/.bash_environment.d
cp --no-target-directory ./src/user/rootfs/.bash_profile /root/.bash_profile
cp --no-target-directory ./src/user/rootfs/.bashrc /root/.bashrc

# Install chromium

snap install chromium
snap refresh chromium

# Install filezilla

apt-get install --no-install-recommends --yes filezilla

# Install firefox

snap install firefox
snap refresh firefox

# Install git

apt-get install --no-install-recommends --yes git git-remote-gcrypt

# Install gparted

apt-get install --no-install-recommends --yes gparted

# Install guake

apt-get install --no-install-recommends --yes guake

# Install imagemagick

apt-get install --no-install-recommends --yes imagemagick
sed -e 's@<policy domain="coder" rights="none" pattern="PDF" />@<policy domain="coder" rights="read | write" pattern="PDF" />@g' -i /etc/ImageMagick-6/policy.xml

# Install libreoffice

snap install libreoffice
snap refresh libreoffice

# Install phpstorm

snap install --classic phpstorm
snap refresh phpstorm

# Install remmina

apt-get install --no-install-recommends remmina remmina-plugin-rdp

# Install simple-scan

apt-get install --no-install-recommends --yes simple-scan

# Install testdisk

apt-get install --no-install-recommends --yes testdisk

# Install vlc

snap install vlc
snap refresh vlc

# Install vscodium

snap install --classic codium
snap refresh codium

# Install wireguard

apt-get install --no-install-recommends --yes wireguard
if ! which resolvconf ; then
    ln -s /usr/bin/resolvectl /usr/local/bin/resolvconf
fi

# Clean

apt-get autoremove --purge --yes
apt-get clean
