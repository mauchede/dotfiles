# dotfiles

Files and scripts used to configure my Ubuntu computer.

## What kind of modifications are applied?

### System modifications

* Configure the system for intel hardware:
  - use `intel_pstate` governor.
  - use `powertop`.
  - use `intel_backlight`.
  - use `thermald`.

* Add applications/aliases/commands:
  - `add-apt-repository` (similar to the original command but avoid duplicate sources in `/etc/apt/sources.list`)
  - `chromium-browser` (with `google-talkplugin` and `pepperflashplugin-nonfree`)
  - `docker`
  - `extract` (easily extract an archive)
  - `filezilla`
  - `git` (with `git-up`)
  - `homebank`
  - `keepass`
  - `phpstorm`
  - `picard`
  - `pidgin`
  - `remmina`
  - `skype`
  - `soap-ui`
  - `virtualbox`
  - `vlc`
  - `xfce4-terminal`
  - `xmllint`

* Add applications/aliases/commands:
  - `mysql`
  - `psql`

With these applications, you can define the version:
  - `mysql ...` will use the "default" version (`5.6`).
  - `VERSION=5.7 mysql ..` will use the version `5.7`.

### User modifications

* Use `chromium` as default browser.

* Use `xfce4-terminal` as a dropdown terminal (open / hide it with `F12`).

* Add applications/aliases/commands:
  - `composer` (dependency management in PHP).
  - `docker-ip` (get a container IP).
  - `fuck` (re-run the last command with root privileges).
  - `melody` (one-file composer scripts).
  - `ssh-unsafe` (run a ssh client without server key checking).

* Configure bash prompt:
  - add a new line if the previous command does not insert it.
  - add exit code of the previous command.
  - add time.
  - add git information.

* Configure git:
  - ignore PhpStorm metadata.
  - add alias `lg` (have more logs about the current project).
  - add alias `oops` (add the current changes to the previous commit).

* Configure unity:
  - always show the menu.
  - configure launcher.
  - disable screen auto locking after inactivity.
  - disable sticky edges.
  - disable the remote lenses.
  - lock the screen with `Super + l`.
  - minimize applications in launcher.
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
