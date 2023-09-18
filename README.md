# README

Files and scripts used to configure my computer

If you like / use this project, please let me known by adding a ★ on the [GitHub repository](https://github.com/mauchede/dotfiles).

## What kind of modifications are applied?

### System modifications

* Add applications/aliases/commands:
  - [chromium](https://www.chromium.org/)
  - [docker](https://www.docker.com)
  - [docker-compose](https://docs.docker.com/compose/overview)
  - [firefox](https://www.mozilla.org/en/firefox/)
  - [git](https://git-scm.com)
  - [gparted](https://gparted.org/)
  - [guake](http://guake-project.org/)
  - [imagemagick](https://imagemagick.org/)
  - [libreoffice](https://www.libreoffice.org)
  - [phpstorm](https://www.jetbrains.com/phpstorm)
  - [remmina](https://remmina.org/)
  - [testdisk](https://www.cgsecurity.org/wiki/TestDisk)
  - [vlc](http://www.videolan.org/vlc)
  - [vscodium](https://vscodium.com/)
  - [wireguard](https://www.wireguard.com/)

### User modifications

* Add applications/aliases/commands/shortcuts:
  - [balena etcher](https://www.balena.io/etcher/)
  - [docker-ip](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases.d/docker#L1): get a container IP
  - [dotenv](https://github.com/bashup/dotenv)
  - [extract](https://raw.githubusercontent.com/mauchede/dotfiles/master/src/user/rootfs/.local/bin/extract): easily extract an archive
  - [ffmpeg](https://www.johnvansickle.com/ffmpeg/)
  - [go-task/task](https://github.com/go-task/task)
  - [joplin](https://joplinapp.org/)
  - [hostess](https://github.com/cbednarski/hostess)
  - [mkcert](https://github.com/FiloSottile/mkcert)
  - [ssh-unsafe](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases.d/ubuntu#L28): run a ssh client without server key checking

* Configure bash prompt:
  - add a new line if the previous command does not insert it.
  - add exit code of the previous command.
  - add time.
  - add git information.

* Configure git:
  - ignore PhpStorm metadata (`.idea` folder).
  - add [aliases](https://github.com/mauchede/dotfiles/blob/master/bin/install-user.sh#L63)

* Install fonts:
  - [Noto Color Emoji](https://www.google.com/get/noto/#emoji-zsye-color)

## Usage

To configure the system:

```sh
sudo bin/install-system.sh
```

To configure the user:

```sh
sudo bin/install-user.sh [USER]
```

## Links

* [customize bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
* [fix non-breaking spaces](https://bugs.launchpad.net/ubuntu/+source/xorg/+bug/218637)
* [how to enable color emoji on chrome for linux](https://www.omgubuntu.co.uk/2016/08/enable-color-emoji-linux-google-chrome-noto)
* [human git aliases](http://gggritso.com/human-git-aliases)
* [remove duplicate $PATH entries with awk command](https://unix.stackexchange.com/questions/40749/remove-duplicate-path-entries-with-awk-command)
* [set environment variables from file](https://stackoverflow.com/questions/19331497/set-environment-variables-from-file)
