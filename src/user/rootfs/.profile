# initialize bash

if [ -n "${BASH_VERSION}" ] && [ -f "${HOME}"/.bashrc ]; then
    . "${HOME}"/.bashrc
fi

# include user's bin

if [ -d "${HOME}"/.local/bin ]; then
    PATH="${HOME}"/.local/bin:"${PATH}"
fi
