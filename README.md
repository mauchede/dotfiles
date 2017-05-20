# README

Files and scripts used to configure my Xubuntu computer

## What kind of modifications are applied?

### System modifications

* Configure the system for intel hardware:
  - use `intel_pstate` governor.
  - use `powertop`.
  - use `intel_backlight`.
  - use `thermald`.

* Add applications/aliases/commands:
  - [ansible](http://www.ansible.com)
  - [atom](https://atom.io) ([dockerized](https://github.com/timonier/atom))
  - [blackfire](https://blackfire.io) ([dockerized](https://hub.docker.com/r/blackfire/blackfire))
  - [chromium-browser](https://www.chromium.org)
  - [composer](https://getcomposer.org)
  - [docker](https://www.docker.com)
  - [docker-clean](https://github.com/ZZROTDesign/docker-clean)
  - [docker-compose](https://docs.docker.com/compose/overview)
  - [drive](https://github.com/odeke-em/drive) ([dockerized](https://github.com/timonier/drive))
  - [extract](https://raw.githubusercontent.com/mauchede/dotfiles/master/src/system/usr/local/bin/extract): easily extract an archive
  - [extract-xiso](http://sourceforge.net/projects/extract-xiso) ([dockerized](https://github.com/timonier/extract-xiso))
  - [fabric](http://www.fabfile.org) ([dockerized](https://github.com/timonier/fabric))
  - [filezilla](https://filezilla-project.org)
  - [git](https://git-scm.com)
  - [git-up](https://github.com/aanand/git-up) ([dockerized](https://github.com/timonier/git-up))
  - [homebank](http://homebank.free.fr) ([dockerized](https://github.com/timonier/homebank))
  - [intellij idea](https://www.jetbrains.com/idea)
  - [keepass](http://keepass.info)
  - [libreoffice](https://www.libreoffice.org)
  - [license](https://github.com/nishanths/license) ([dockerized](https://github.com/timonier/license))
  - [melody](http://melody.sensiolabs.org)
  - [mnemosyne](http://mnemosyne-proj.org) ([dockerized](https://github.com/timonier/mnemosyne))
  - [mysql](http://www.mysql.com) ([dockerized](https://hub.docker.com/_/mysql))
  - [mysql-workbench](https://www.mysql.com/fr/products/workbench/)
  - [nodejs](https://nodejs.org) ([dockerized](https://hub.docker.com/_/node))
  - [npm-proxy-cache](https://github.com/runk/npm-proxy-cache) ([dockerized](https://github.com/timonier/npm-proxy-cache))
  - [php](http://www.php.net) ([dockerized](https://github.com/timonier/php))
  - [phpstorm](https://www.jetbrains.com/phpstorm)
  - [picard](https://picard.musicbrainz.org)
  - [postgresql](http://www.postgresql.org) ([dockerized](https://hub.docker.com/_/postgres))
  - [rabbitmq](https://www.rabbitmq.com) ([dockerized](https://hub.docker.com/_/rabbitmq))
  - [rambox](http://rambox.pro)
  - [redis](https://redis.io) ([dockerized](https://hub.docker.com/_/redis))
  - [remmina](http://freerdp.github.io/Remmina/index.html)
  - [rsync](https://rsync.samba.org)
  - [selenium](http://www.seleniumhq.org/)
  - [shellcheck](https://github.com/koalaman/shellcheck)
  - [vlc](http://www.videolan.org/vlc)
  - [webstorm](https://www.jetbrains.com/webstorm/)
  - [xfce4-terminal](http://docs.xfce.org/apps/terminal/start)
  - [xmllint](http://xmlsoft.org/xmllint.html)

### User modifications

* Use `xfce4-terminal` as a dropdown terminal (open / hide it with `F12`).

* Add applications/aliases/commands/shortcuts:
  - [bower](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L38): shortcut for `node_modules/.bin/bower`.
  - [docker-ip](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L20): get a container IP
  - [docker-rename](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L24): rename image
  - [gulp](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L39): shortcut for `node_modules/.bin/gulp`.
  - [ssh-unsafe](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L43): run a ssh client without server key checking

* Configure bash prompt:
  - add a new line if the previous command does not insert it.
  - add exit code of the previous command.
  - add time.
  - add git information.

* Configure git:
  - ignore PhpStorm metadata (`.idea` folder).
  - add [aliases](https://github.com/mauchede/dotfiles/blob/master/src/user/.gitconfig)

## Usage

To configure the system:

```sh
sudo bin/install-system.sh
sudo powertop --calibrate
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

## Links

* [creating a .desktop file for a new application](http://askubuntu.com/questions/281293/creating-a-desktop-file-for-a-new-application)
* [customize bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
* [fix non-breaking spaces](https://bugs.launchpad.net/ubuntu/+source/xorg/+bug/218637)
* [human git aliases](http://gggritso.com/human-git-aliases)
* [start shell script on network manager successful connection](http://www.techytalk.info/start-script-on-network-manager-successful-connection/)
* [timonier/dumb-entrypoint](https://github.com/timonier/dumb-entrypoint)
