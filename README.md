# README

Files and scripts used to configure my computer

## What kind of modifications are applied?

### System modifications

* Add applications/aliases/commands:
  - [atom](https://atom.io)
  - [docker](https://www.docker.com)
  - [docker-compose](https://docs.docker.com/compose/overview)
  - [drive](https://github.com/odeke-em/drive) ([dockerized](https://github.com/timonier/drive))
  - [etcher](https://etcher.io/)
  - [filezilla](https://filezilla-project.org)
  - [firefox](https://www.mozilla.org/en/firefox/)
  - [gatling](https://gatling.io)
  - [git](https://git-scm.com)
  - [google cloud sdk](https://cloud.google.com/sdk/)
  - [homebank](http://homebank.free.fr)
  - [iterm2](https://www.iterm2.com/)
  - [java](https://www.java.com)
  - [keepassxc](https://keepassxc.org)
  - [libreoffice](https://www.libreoffice.org)
  - [license](https://github.com/nishanths/license) ([dockerized](https://github.com/timonier/license))
  - [mysql](http://www.mysql.com) ([dockerized](https://hub.docker.com/r/timonier/mysql))
  - [nodejs](https://nodejs.org) ([dockerized](https://github.com/timonier/node))
  - [php](http://www.php.net) ([dockerized](https://github.com/timonier/php))
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
  - [webstorm](https://www.jetbrains.com/webstorm)

### User modifications

* Add applications/aliases/commands/shortcuts:
  - [ssh-unsafe](https://github.com/mauchede/dotfiles/blob/master/src/user/.bash_aliases): run a ssh client without server key checking

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

## Contributing

1. Fork it.
2. Create your branch: `git checkout -b my-new-feature`.
3. Commit your changes: `git commit -am 'Add some feature'`.
4. Push to the branch: `git push origin my-new-feature`.
5. Submit a pull request.

If you like / use this project, please let me known by adding a [★](https://help.github.com/articles/about-stars/) on the [GitHub repository](https://github.com/mauchede/dotfiles).

## Links

* [human git aliases](http://gggritso.com/human-git-aliases)
* [gatling does not support java > 8](https://github.com/gatling/gatling/issues/3359)
* [install java8 on os x](https://gist.github.com/JeOam/a926dbb5145c4d0789c1)
* [if file is exists and is not empty. Always gives me the false value](https://stackoverflow.com/questions/30080997/if-file-is-exists-and-is-not-empty-always-gives-me-the-false-value)
* [recursive cp copies folder contents instead of folder on os x](https://serverfault.com/questions/11518/recursive-cp-copies-folder-contents-instead-of-folder-on-os-x)
* [set environment variables from file](https://stackoverflow.com/questions/19331497/set-environment-variables-from-file)
* [set up docker for mac with native NFS](https://medium.com/@sean.handley/how-to-set-up-docker-for-mac-with-native-nfs-145151458adc)
* [where is java_home on macos](https://stackoverflow.com/questions/6588390/where-is-java-home-on-macos-sierra-10-12-el-capitan-10-11-yosemite-10-10)
