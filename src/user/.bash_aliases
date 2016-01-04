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

docker-clean() {
    docker rm $(docker ps -q -f status=exited) > /dev/null 2>&1
    docker rmi $(docker images -q -f "dangling=true") > /dev/null 2>&1
    docker run -v $(which docker):/bin/docker -v /var/run/docker.sock:/var/run/docker.sock -v $(readlink -f /var/lib/docker):/var/lib/docker --rm martin/docker-cleanup-volumes > /dev/null 2>&1
}

docker-ip() {
    docker inspect --format "{{ .NetworkSettings.IPAddress }}" $1
}

docker-rename() {
    docker tag $1 $2 && docker rmi $1 > /dev/null 2>&1
}

docker-stop() {
    docker rm -f $(docker ps -q) > /dev/null 2>&1 || :
}

# php

alias php='php -dzend_extension=xdebug.so'

# history

alias history-clean='echo > $HOME/.bash_history ; history -c'

# ssh

alias ssh-unsafe='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile /dev/null"'

# sudo

alias fuck='sudo $(history -p \!\!)'
alias sudo='sudo '
