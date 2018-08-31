# README

Files and scripts used to configure my computer

## What kind of modifications are applied?

### System modifications

* Configure the system for intel hardware:
  - use `intel_pstate` governor.
  - use `thermald`.

* Add applications/aliases/commands:
  - [adminer](https://www.adminer.org/) ([dockerized](https://hub.docker.com/_/adminer/))
  - [atom](https://atom.io)
  - [blackfire](https://blackfire.io) ([dockerized](https://hub.docker.com/r/blackfire/blackfire))
  - [cheese](https://wiki.gnome.org/Apps/Cheese)
  - [chromium](https://www.chromium.org/)
  - [docker](https://www.docker.com)
  - [docker-compose](https://docs.docker.com/compose/overview)
  - [drive](https://github.com/odeke-em/drive) ([dockerized](https://github.com/timonier/drive))
  - [etcher](https://etcher.io/)
  - [extract](https://raw.githubusercontent.com/mauchede/dotfiles/master/src/system/usr/local/bin/extract): easily extract an archive
  - [filezilla](https://filezilla-project.org)
  - [firefox](https://www.mozilla.org/en/firefox/)
  - [git](https://git-scm.com)
  - [google cloud sdk](https://cloud.google.com/sdk/?hl=en)
  - [homebank](http://homebank.free.fr)
  - [insomnia](https://insomnia.rest)
  - [intellij idea](https://www.jetbrains.com/idea)
  - [joplin](https://github.com/laurent22/joplin)
  - [keepassxc](https://keepassxc.org/)
  - [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
  - [libreoffice](https://www.libreoffice.org)
  - [license](https://github.com/nishanths/license) ([dockerized](https://github.com/timonier/license))
  - [mailcatcher](https://github.com/sj26/mailcatcher) ([dockerized](https://hub.docker.com/r/timonier/mailcatcher))
  - [mysql](http://www.mysql.com) ([dockerized](https://hub.docker.com/r/timonier/mysql))
  - [nodejs](https://nodejs.org) ([dockerized](https://github.com/timonier/node))
  - [php](http://www.php.net) ([dockerized](https://github.com/timonier/php))
  - [phpstorm](https://www.jetbrains.com/phpstorm)
  - [postgresql](http://www.postgresql.org) ([dockerized](https://hub.docker.com/r/timonier/postgresql))
  - [postman](https://www.getpostman.com/)
  - [rabbitmq](https://www.rabbitmq.com) ([dockerized](https://hub.docker.com/_/rabbitmq))
  - [redis](https://redis.io) ([dockerized](https://hub.docker.com/r/timonier/redis))
  - [remmina](http://freerdp.github.io/Remmina/index.html)
  - [rawdns](https://github.com/tianon/rawdns) ([dockerized](https://hub.docker.com/r/tianon/rawdns/))
  - [rsync](https://rsync.samba.org)
  - [seahorse](https://wiki.gnome.org/Apps/Seahorse)
  - [selenium](http://www.seleniumhq.org/) ([dockerized](https://hub.docker.com/r/selenium/standalone-chrome/))
  - [shellcheck](https://github.com/koalaman/shellcheck)
  - [shfmt](https://github.com/mvdan/sh/releases)
  - [skype](https://www.skype.com/en/)
  - [slack](https://slack.com)
  - [sup](https://github.com/pressly/sup)
  - [vlc](http://www.videolan.org/vlc)
  - [webstorm](https://www.jetbrains.com/webstorm/)
  - [xfce4-terminal](http://docs.xfce.org/apps/terminal/start)
  - [xmllint](http://xmlsoft.org/xmllint.html)

### User modifications

* Use `xfce4-terminal` as a dropdown terminal (open / hide it with `F12`).

* Add applications/aliases/commands/shortcuts:
  - [bower](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L34): shortcut for `node_modules/.bin/bower`.
  - [docker-ip](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L20): get a container IP
  - [docker-rename](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L24): rename image
  - [eslint](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L35): shortcut for `node_modules/.bin/eslint`.
  - [gulp](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L36): shortcut for `node_modules/.bin/gulp`.
  - [ssh-unsafe](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L40): run a ssh client without server key checking

* Configure bash prompt:
  - add a new line if the previous command does not insert it.
  - add exit code of the previous command.
  - add time.
  - add git information.

* Configure git:
  - ignore PhpStorm metadata (`.idea` folder).
  - add [aliases](https://github.com/mauchede/dotfiles/blob/master/bin/install-user.sh#L63)

## Usage

To configure the system:

```sh
sudo bin/install-system.sh
```

To configure the user:

```sh
sudo bin/install-user.sh [USER]
```

## Contributing

1. Fork it.
2. Create your branch: `git checkout -b my-new-feature`.
3. Commit your changes: `git commit -am 'Add some feature'`.
4. Push to the branch: `git push origin my-new-feature`.
5. Submit a pull request.

If you like / use this project, please let me known by adding a [★](https://help.github.com/articles/about-stars/) on the [GitHub repository](https://github.com/mauchede/dotfiles).

## Links

* [creating a .desktop file for a new application](http://askubuntu.com/questions/281293/creating-a-desktop-file-for-a-new-application)
* [customize bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
* [fix joplin app-icon on linux](https://github.com/laurent22/joplin/issues/86#issuecomment-376811132)
* [fix non-breaking spaces](https://bugs.launchpad.net/ubuntu/+source/xorg/+bug/218637)
* [how to change dns on a minimal networking setup](https://superuser.com/questions/912272/how-to-change-dns-on-a-minimal-networking-setup)
* [human git aliases](http://gggritso.com/human-git-aliases)
* [mauchede/version-lister](https://github.com/mauchede/version-lister)
* [set environment variables from file](https://stackoverflow.com/questions/19331497/set-environment-variables-from-file)
* [snap creates redundant duplicate directories in home folder](https://bugs.launchpad.net/ubuntu/+source/snapcraft/+bug/1746710)
* [start shell script on network manager successful connection](http://www.techytalk.info/start-script-on-network-manager-successful-connection/)
* [using gnome keyring as git credential helper](https://blog.scottlowe.org/2016/11/21/gnome-keyring-git-credential-helper/)
