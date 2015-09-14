# dotfiles

Files and scripts used to configure my Ubuntu computer.

## What kind of modifications are applied?

### System modifications

* Configure the system for intel hardware:
  - use `intel_pstate` governor.
  - use `powertop`.
  - use `intel_backlight`.
  - use `thermald`.

* Configure unity:
  - remove file lens.

* Add applications/aliases/commands:
  - [add-apt-repository](https://raw.githubusercontent.com/mauchede/dotfiles/master/src/system/usr/local/bin/add-apt-repository): similar to the original command but avoid duplicate sources
  - [bower](https://github.com/bower/bower) ([dockerized](https://github.com/mauchede/bower))
  - [chromium-browser](https://www.chromium.org/) with `google-talkplugin` and `pepperflashplugin-nonfree`
  - [docker](https://www.docker.com)
  - [drive](https://github.com/odeke-em/drive) ([dockerized](https://github.com/mauchede/drive))
  - [extract](https://raw.githubusercontent.com/mauchede/dotfiles/master/src/system/usr/local/bin/extract): easily extract an archive
  - [filezilla](https://filezilla-project.org)
  - [git](https://git-scm.com/)
  - [git-up](https://github.com/aanand/git-up) ([dockerized](https://github.com/mauchede/git-up))
  - [homebank](http://homebank.free.fr)
  - [keepass](http://keepass.info)
  - [mnemosyne](http://mnemosyne-proj.org/) ([dockerized](https://github.com/mauchede/mnemosyne))
  - [mysql](http://www.mysql.com) ([dockerized](https://github.com/mauchede/mysql))
  - [nodejs](https://nodejs.org) ([dockerized](https://github.com/mauchede/node))
  - [phpstorm](https://www.jetbrains.com/phpstorm)
  - [picard](https://picard.musicbrainz.org)
  - [pidgin](https://pidgin.im)
  - [postgresql](http://www.postgresql.org) ([dockerized](https://github.com/mauchede/postgresql))
  - [pyftpd](https://github.com/giampaolo/pyftpdlib) ([dockerized](https://github.com/mauchede/pyftpd))
  - [remmina](http://freerdp.github.io/Remmina/index.html)
  - [skype](http://www.skype.com)
  - [soap-ui](http://www.soapui.org)
  - [virtualbox](https://www.virtualbox.org)
  - [vlc](http://www.videolan.org/vlc)
  - [xfce4-terminal](http://docs.xfce.org/apps/terminal/start)
  - [xmllint](http://xmlsoft.org/xmllint.html)

### User modifications

* Use `chromium` as default browser.

* Use `xfce4-terminal` as a dropdown terminal (open / hide it with `F12`).

* Add applications/aliases/commands:
  - [composer](https://getcomposer.org/)
  - [docker-clean](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L20): remove stopped containers and dangling images
  - [docker-ip](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L21): get a container IP
  - [fuck](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L29): re-run the last command with root privileges
  - [melody](http://melody.sensiolabs.org/)
  - [ssh-unsafe](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L25): run a ssh client without server key checking

* Configure bash prompt:
  - add a new line if the previous command does not insert it.
  - add exit code of the previous command.
  - add time.
  - add git information.

* Configure git:
  - ignore PhpStorm metadata.
  - add alias [lg](https://github.com/mauchede/dotfiles/blob/master/src/user/.gitconfig#L8): have more logs about the current project
  - add alias [oops](https://github.com/mauchede/dotfiles/blob/master/src/user/.gitconfig#L9): add the current changes to the previous commit

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
  - use recursive search.

## How to use this project?

To configure the system:
```bash
sudo apt-get update && sudo apt-get upgrade
sudo bin/install-system.sh
sudo powertop --calibrate
```

To configure the user:
```bash
bin/install-user.sh
```
