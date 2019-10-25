# bash

alias {up,..}="cd .."

# busybox

alias cp="cp -i"
alias df="df -h"
alias du="du -h"
alias grep="grep --exclude-dir '.git' --color=tty"
alias ll="ls -lh"
alias lla="ll -a"
alias mv="mv -i"

# docker

docker-compose() {
    if [ -z "${DOCKER_HOST}" ]; then
        local context_host="$(docker context inspect --format "{{ .Endpoints.docker.Host }}")"
        if [[ "${context_host}" == ssh://* ]] && [[ "${context_host}" != ssh://*@* ]]; then
            context_host="$(echo "${context_host}" | sed "s/ssh:\/\//ssh:\/\/$(ssh -G "${context_host}" -T | grep "user " | cut -c 6-)@/g")"
        fi
    fi
    DOCKER_HOST="${DOCKER_HOST:-"${context_host}"}" "$(which docker-compose)" "$@"
}

# history

history-clean() {
    > "${HOME}"/.bash_history
    history -c
}

# keka

alias 7z="/Applications/Keka.app/Contents/Resources/keka7z"

# ssh

alias ssh-unsafe="ssh -o 'StrictHostKeyChecking=no' -o 'UserKnownHostsFile /dev/null'"

# sudo

alias sudo="sudo "
