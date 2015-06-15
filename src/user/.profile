# initialize bash

[ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# include user's bin

[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
