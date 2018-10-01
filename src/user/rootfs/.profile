# define java home

export JAVA_HOME="$(/usr/libexec/java_home)"

# fix accentuated characters

stty cs8 -istrip -parenb
bind "set convert-meta off"
bind "set meta-flag on"
bind "set output-meta on"

# initialize bash

if [ -n "${BASH_VERSION}" ] && [ -f "${HOME}"/.bashrc ]; then
    . "${HOME}"/.bashrc
fi

# include "/usr/local/sbin" binaries

PATH=/usr/local/sbin:"${PATH}"

# include "~/.bin" binaries

if [ -d "${HOME}"/.bin ]; then
    PATH="${HOME}"/.bin:"${PATH}"
fi
