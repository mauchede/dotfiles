# bash

alias {up,..}='cd ..'

# busybox

alias cp='cp -i'
alias df='df -h'
alias du='du -h'
alias grep='grep --exclude-dir ".git" --color=tty'
alias free='free -m'
alias l='ls -lh --color'
alias ll='ls -lh --color'
alias lla='ll -a --color'
alias ls='ls --color'
alias mv='mv -i'

# docker

docker-ip() {
    docker inspect --format "{{ .NetworkSettings.IPAddress }}" $1
}

docker-rename() {
    docker tag $1 $2 && docker rmi $1 > /dev/null 2>&1
}

# php

alias php='php -dzend_extension=xdebug.so'

# history

alias history-clean='echo > $HOME/.bash_history ; history -c'

# nodejs

alias bower='node_modules/.bin/bower'
alias gulp='node_modules/.bin/gulp'

# ssh

alias ssh-unsafe='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile /dev/null"'

# sudo

alias fuck='sudo $(history -p \!\!)'
alias sudo='sudo '
