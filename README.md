# README

Files and scripts used to configure my computer

⚠️ This branch is no longer maintained. ⚠️

## What kind of modifications are applied?

### System modifications

* Add applications/aliases/commands:
  - [atom](https://atom.io)
  - [cyberduck](https://cyberduck.io)
  - [direnv](https://direnv.net/)
  - [docker](https://www.docker.com)
  - [docker-compose](https://docs.docker.com/compose/overview)
  - [drive](https://github.com/odeke-em/drive) ([dockerized](https://gitlab.com/timonier/drive))
  - [etcher](https://www.balena.io/etcher/)
  - [firefox](https://www.mozilla.org/en/firefox/)
  - [gatling](https://gatling.io)
  - [git](https://git-scm.com)
  - [git-remote-gcrypt](https://github.com/spwhitton/git-remote-gcrypt)
  - [google cloud sdk](https://cloud.google.com/sdk/)
  - [gnupg](https://www.gnupg.org/)
  - [hostess](https://github.com/cbednarski/hostess)
  - [iterm2](https://www.iterm2.com/)
  - [java](https://www.java.com)
  - [keepassxc](https://keepassxc.org)
  - [kubernetes-cli](https://kubernetes.io/)
  - [libreoffice](https://www.libreoffice.org)
  - [license](https://github.com/nishanths/license) ([dockerized](https://gitlab.com/timonier/license))
  - [macs fan control](https://www.crystalidea.com/macs-fan-control)
  - [mysql](http://www.mysql.com) ([dockerized](https://hub.docker.com/r/timonier/mysql))
  - [nodejs](https://nodejs.org) ([dockerized](https://gitlab.com/timonier/node))
  - [php](http://www.php.net) ([dockerized](https://gitlab.com/timonier/php))
  - [phpstorm](https://www.jetbrains.com/phpstorm)
  - [postgresql](http://www.postgresql.org) ([dockerized](https://hub.docker.com/r/timonier/postgresql))
  - [postman](https://www.getpostman.com/)
  - [redis](https://redis.io) ([dockerized](https://hub.docker.com/r/timonier/redis))
  - [remmina](http://freerdp.github.io/Remmina/index.html)
  - [shellcheck](https://github.com/koalaman/shellcheck)
  - [shfmt](https://github.com/mvdan/sh/releases)
  - [skype](https://www.skype.com/en/)
  - [slack](https://slack.com)
  - [sup](https://github.com/pressly/sup)
  - [vlc](https://www.videolan.org/vlc/)
  - [webstorm](https://www.jetbrains.com/webstorm)

### User modifications

* Add applications/aliases/commands/shortcuts:
  - [ssh-unsafe](https://gitlab.com/mauchede/dotfiles/blob/mac-os/darwin/src/user/rootfs/.bash_aliases): run a ssh client without server key checking

* Configure bash prompt:
  - add a new line if the previous command does not insert it.
  - add exit code of the previous command.
  - add time.
  - add git information.

* Configure git:
  - ignore macOS metadata (`.DS_Store` files).
  - ignore PhpStorm metadata (`.idea` folder).
  - ignore `php-cs-fixer` metadata (`.php_cs.cache` files).
  - ignore `nodejs` files (`.npm-*.log` and `yarn-*.log` files).

* Use `iterm2` as a dropdown terminal (open / hide it with `F12`).

## Usage

To configure the system:

```sh
bin/install-system.sh
```

To configure the user:

```sh
bin/install-user.sh
```

## Links

* [caractere accentue sous iterm (fr)](https://forums.macg.co/threads/caractere-accentue-sous-iterm-xterm.201706/)
* [human git aliases](http://gggritso.com/human-git-aliases)
* [if file is exists and is not empty. Always gives me the false value](https://stackoverflow.com/questions/30080997/if-file-is-exists-and-is-not-empty-always-gives-me-the-false-value)
* [recursive cp copies folder contents instead of folder on os x](https://serverfault.com/questions/11518/recursive-cp-copies-folder-contents-instead-of-folder-on-os-x)
* [set environment variables from file](https://stackoverflow.com/questions/19331497/set-environment-variables-from-file)
* [set up docker for mac with native NFS](https://medium.com/@sean.handley/how-to-set-up-docker-for-mac-with-native-nfs-145151458adc)
* [where is java_home on macos](https://stackoverflow.com/questions/6588390/where-is-java-home-on-macos-sierra-10-12-el-capitan-10-11-yosemite-10-10)
