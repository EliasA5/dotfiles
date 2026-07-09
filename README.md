
# My Dotfiles Repository

Feel free to use it however you like.

## Each dir is for a different program/platform

To install them you need [GNU Stow](https://www.gnu.org/software/stow/)

### first define xdg directories:
```bash
cat << 'EOF' >> ~/.bashrc
HOME_DIR=~
export XDG_CONFIG_HOME="$HOME_DIR/.config"
export XDG_DATA_HOME="$HOME_DIR/.local/share"
export XDG_CACHE_HOME="$HOME_DIR/.cache"
export XDG_STATE_HOME="$HOME_DIR/.local/state"
if [ -f $XDG_CONFIG_HOME/bash/bashrc_common ]; then
    source $XDG_CONFIG_HOME/bash/bashrc_common
fi
EOF
exec bash
```

### on a remote host:
```bash
stow -t $XDG_CONFIG_HOME/../ nvim lazygit tmux bash
```

### on a local host:
```bash
stow -t $XDG_CONFIG_HOME/../ nvim lazygit tmux kitty bash
```

