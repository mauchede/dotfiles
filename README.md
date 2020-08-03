# README

Files and scripts used to configure my computer

## What kind of modifications are applied?

### System modifications

* Add applications/aliases/commands:
  - [aws-cli](https://aws.amazon.com/en/cli/)
  - [composer](https://getcomposer.org/) ([dockerized](https://raw.githubusercontent.com/mauchede/dotfiles/master/src/system/usr/local/bin/composer)
  - [discord](https://discordapp.com/)
  - [docker](https://www.docker.com)
  - [docker-compose](https://docs.docker.com/compose/overview)
  - [drive](https://github.com/odeke-em/drive) ([dockerized](https://github.com/timonier/drive))
  - [extract](https://raw.githubusercontent.com/mauchede/dotfiles/master/src/system/usr/local/bin/extract): easily extract an archive
  - [firefox](https://www.mozilla.org/en/firefox/)
  - [git](https://git-scm.com)
  - [google-chrome](https://www.google.com/intl/fr_fr/chrome/)
  - [gparted](https://gparted.org/)
  - [guake](http://guake-project.org/)
  - [ffmpeg](https://www.ffmpeg.org/)
  - [hostess](https://github.com/cbednarski/hostess)
  - [hugo](https://gohugo.io/)
  - [keybase](https://keybase.io/)
  - [keepassxc](https://keepassxc.org/)
  - [jq](https://stedolan.github.io/jq/)
  - [libreoffice](https://www.libreoffice.org)
  - [license](https://github.com/nishanths/license) ([dockerized](https://github.com/timonier/license))
  - [phpstorm](https://www.jetbrains.com/phpstorm)
  - [postman](https://www.getpostman.com/)
  - [shellcheck](https://github.com/koalaman/shellcheck)
  - [shfmt](https://github.com/mvdan/sh/releases)
  - [skype](https://www.skype.com/en/)
  - [slack](https://slack.com)
  - [spotify](https://www.spotify.com/)
  - [sshuttle](https://github.com/sshuttle/sshuttle)
  - [telegram](https://telegram.org/)
  - [visual studio code](https://code.visualstudio.com/)
  - [vlc](http://www.videolan.org/vlc)

### User modifications

* Add applications/aliases/commands/shortcuts:
  - [docker-ip](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases.d/docker#L1): get a container IP
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

## Contributing

1. Fork it.
2. Create your branch: `git checkout -b feature/my-new-feature`.
3. Commit your changes: `git commit -am 'Add some feature'`.
4. Push to the branch: `git push origin feature/my-new-feature`.
5. Submit a pull request.

If you like / use this project, please let me known by adding a [★](https://help.github.com/articles/about-stars/) on the [GitHub repository](https://github.com/mauchede/dotfiles).

## Links

* [customize bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
* [fix non-breaking spaces](https://bugs.launchpad.net/ubuntu/+source/xorg/+bug/218637)
* [how to enable color emoji on chrome for linux](https://www.omgubuntu.co.uk/2016/08/enable-color-emoji-linux-google-chrome-noto)
* [human git aliases](http://gggritso.com/human-git-aliases)
* [mauchede/version-lister](https://github.com/mauchede/version-lister)
* [set environment variables from file](https://stackoverflow.com/questions/19331497/set-environment-variables-from-file)
* [snap creates redundant duplicate directories in home folder](https://bugs.launchpad.net/ubuntu/+source/snapcraft/+bug/1746710)
