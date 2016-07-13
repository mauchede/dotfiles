# What kind of modifications are applied?

## System modifications

* Configure the system for intel hardware:
  - use `intel_pstate` governor.
  - use `powertop`.
  - use `intel_backlight`.
  - use `thermald`.

* Add applications/aliases/commands:
  - [ansible](http://www.ansible.com/)
  - [atom](https://atom.io/) ([dockerized](https://github.com/timonier/atom))
  - [blackfire](https://blackfire.io/) (dockerized)
  - [chromium-browser](https://www.chromium.org/) with `pepperflashplugin-nonfree`
  - [composer](https://getcomposer.org/)
  - [docker](https://www.docker.com)
  - [drive](https://github.com/odeke-em/drive) ([dockerized](https://github.com/timonier/drive))
  - [extract](https://raw.githubusercontent.com/mauchede/dotfiles/master/src/system/usr/local/bin/extract): easily extract an archive
  - [extract-xiso](http://sourceforge.net/projects/extract-xiso/) ([dockerized](https://github.com/timonier/extract-xiso))
  - [filezilla](https://filezilla-project.org)
  - [git](https://git-scm.com/)
  - [git-up](https://github.com/aanand/git-up) ([dockerized](https://github.com/timonier/git-up))
  - [homebank](http://homebank.free.fr) ([dockerized](https://github.com/timonier/homebank))
  - [intellij](https://www.jetbrains.com/idea/)
  - [keepass](http://keepass.info)
  - [libreoffice](https://www.libreoffice.org/)
  - [license](https://github.com/nishanths/license)
  - [melody](http://melody.sensiolabs.org/)
  - [mnemosyne](http://mnemosyne-proj.org/) ([dockerized](https://github.com/timonier/mnemosyne))
  - [mysql](http://www.mysql.com) (dockerized)
  - [nodejs](https://nodejs.org) (dockerized)
  - [npm-proxy-cache](https://github.com/runk/npm-proxy-cache) ([dockerized](https://github.com/timonier/npm-proxy-cache))
  - [php](http://www.php.net) ([dockerized](https://github.com/mauchede/php))
  - [phpstorm](https://www.jetbrains.com/phpstorm)
  - [picard](https://picard.musicbrainz.org)
  - [pidgin](https://pidgin.im)
  - [postgresql](http://www.postgresql.org) (dockerized)
  - [rabbitmq](https://www.rabbitmq.com/) (dockerized)
  - [remmina](http://freerdp.github.io/Remmina/index.html)
  - [rsync](https://rsync.samba.org/)
  - [soap-ui](http://www.soapui.org)
  - [unity-tweak-tool](https://github.com/freyja-dev/unity-tweak-tool)
  - [vlc](http://www.videolan.org/vlc)
  - [xfce4-terminal](http://docs.xfce.org/apps/terminal/start)
  - [xmllint](http://xmlsoft.org/xmllint.html)

## User modifications

* Use `xfce4-terminal` as a dropdown terminal (open / hide it with `F12`).

* Add applications/aliases/commands:
  - [composer](https://getcomposer.org/)
  - [docker-clean](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L20): remove stopped containers and dangling images
  - [docker-ip](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L26): get a container IP
  - [docker-rename](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L30): rename image
  - [docker-stop](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L34): stop all containers
  - [fuck](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L30): re-run the last command with root privileges
  - [melody](http://melody.sensiolabs.org/)
  - [ssh-unsafe](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L48): run a ssh client without server key checking

* Configure bash prompt:
  - add a new line if the previous command does not insert it.
  - add exit code of the previous command.
  - add time.
  - add git information.

* Configure git:
  - ignore PhpStorm metadata (`.idea` folder).
  - add [aliases](https://github.com/mauchede/dotfiles/blob/master/src/user/.gitconfig)

* Configure unity:
  - always show the menu.
  - configure launcher.
  - disable automount.
  - disable screen auto locking after inactivity.
  - disable sticky edges.
  - disable the remote lenses.
  - lock the screen with `Super + l`.
  - minimize applications in launcher.
  - show battery percentage.
  - use user background as lock-screen background.
  - use recursive search.

# Usage

To configure the system:
```bash
sudo bin/install-system.sh
sudo powertop --calibrate
```

To configure the user:
```bash
sudo bin/install-user.sh [USER]
```

# Contributing

1. Fork it.
2. Create your branch: `git checkout -b my-new-feature`.
3. Commit your changes: `git commit -am 'Add some feature'`.
4. Push to the branch: `git push origin my-new-feature`.
5. Submit a pull request.

# Links

* [customize bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
* [docker-clean](https://github.com/ZZROTDesign/docker-clean)
* [files disappears from the launcher Ubuntu 16.04](http://ubuntuforums.org/showthread.php?t=2321285&p=13487098#post13487098)
* [fix non-breaking spaces](https://bugs.launchpad.net/ubuntu/+source/xorg/+bug/218637)
* [human git aliases](http://gggritso.com/human-git-aliases)
* [npm-proxy-cache](https://github.com/runk/npm-proxy-cache)
* [timonier/atom](https://github.com/timonier/atom)
* [timonier/drive](https://github.com/timonier/drive)
* [timonier/extract-xiso](https://github.com/timonier/extract-xiso)
* [timonier/git-up](https://github.com/timonier/git-up)
* [timonier/homebank](https://github.com/timonier/homebank)
* [timonier/mnemosyne](https://github.com/timonier/mnemosyne)
* [timonier/npm-proxy-cache](https://github.com/timonier/npm-proxy-cache)
