# initialize bash

if [ -n "${BASH_VERSION}" ] && [ -f "${HOME}"/.bashrc ]; then
    . "${HOME}"/.bashrc
fi

# include sbin binaries

PATH=/usr/local/sbin:"${PATH}"

# include user's bin

if [ -d "${HOME}"/.bin ]; then
    PATH="${HOME}"/.bin:"${PATH}"
fi
