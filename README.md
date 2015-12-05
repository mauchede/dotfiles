### What kind of modifications are applied?

#### System modifications

* Configure the system for intel hardware:
  - use `intel_pstate` governor.
  - use `powertop`.
  - use `intel_backlight`.
  - use `thermald`.

* Configure unity:
  - remove file lens.

* Add applications/aliases/commands:
  - [add-apt-repository](https://raw.githubusercontent.com/mauchede/dotfiles/master/src/system/usr/local/bin/add-apt-repository): similar to the original command but avoid duplicate sources
  - [ansible](http://www.ansible.com/)
  - [bower](https://github.com/bower/bower) ([dockerized](https://github.com/mauchede/bower))
  - [chromium-browser](https://www.chromium.org/) with `google-talkplugin` and `pepperflashplugin-nonfree`
  - [composer](https://getcomposer.org/)
  - [docker](https://www.docker.com)
  - [drive](https://github.com/odeke-em/drive) ([dockerized](https://github.com/mauchede/drive))
  - [extract](https://raw.githubusercontent.com/mauchede/dotfiles/master/src/system/usr/local/bin/extract): easily extract an archive
  - [filezilla](https://filezilla-project.org)
  - [git](https://git-scm.com/)
  - [git-up](https://github.com/aanand/git-up) ([dockerized](https://github.com/mauchede/git-up))
  - [homebank](http://homebank.free.fr) ([dockerized](https://github.com/mauchede/homebank))
  - [keepass](http://keepass.info)
  - [melody](http://melody.sensiolabs.org/)
  - [mnemosyne](http://mnemosyne-proj.org/) ([dockerized](https://github.com/mauchede/mnemosyne))
  - [mysql](http://www.mysql.com) (dockerized)
  - [nodejs](https://nodejs.org) (dockerized)
  - [phpstorm](https://www.jetbrains.com/phpstorm)
  - [picard](https://picard.musicbrainz.org)
  - [pidgin](https://pidgin.im)
  - [postgresql](http://www.postgresql.org) (dockerized)
  - [remmina](http://freerdp.github.io/Remmina/index.html)
  - [rsync](https://rsync.samba.org/)
  - [soap-ui](http://www.soapui.org)
  - [vlc](http://www.videolan.org/vlc)
  - [vsftpd](https://security.appspot.com/vsftpd.html) ([dockerized](https://github.com/mauchede/vsftpd))
  - [xfce4-terminal](http://docs.xfce.org/apps/terminal/start)
  - [xmllint](http://xmlsoft.org/xmllint.html)

#### User modifications

* Use `xfce4-terminal` as a dropdown terminal (open / hide it with `F12`).

* Add applications/aliases/commands:
  - [composer](https://getcomposer.org/)
  - [docker-clean](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L20): remove stopped containers and dangling images
  - [docker-ip](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L21): get a container IP
  - [docker-stop](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L22): stop all containers
  - [fuck](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L30): re-run the last command with root privileges
  - [melody](http://melody.sensiolabs.org/)
  - [ssh-unsafe](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases#L26): run a ssh client without server key checking

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
  - change theme: use [Flatabulous](https://github.com/anmoljagetia/Flatabulous).
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

### Usage

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

### Contributing

1. Fork it.
2. Create your branch: `git checkout -b my-new-feature`.
3. Commit your changes: `git commit -am 'Add some feature'`.
4. Push to the branch: `git push origin my-new-feature`.
5. Submit a pull request.

### Links

* [customize bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
* [mauchede/bower](https://github.com/mauchede/bower)
* [mauchede/drive](https://github.com/mauchede/drive)
* [mauchede/git-up](https://github.com/mauchede/git-up)
* [mauchede/mnemosyne](https://github.com/mauchede/mnemosyne)
* [mauchede/vsftpd](https://github.com/mauchede/vsftpd)
* [fix non-breaking spaces](https://bugs.launchpad.net/ubuntu/+source/xorg/+bug/218637)
