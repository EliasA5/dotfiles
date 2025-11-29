# My Tmux configuration

Installation:
1. clone the repository and install the tmux config:
    ```bash
    git clone tmux https://github.com/EliasA5/dotfiles/ ~/dotfiles
    stow -t ~/ tmux
    ```
2. install tpm:
    ```bash
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ```
3. open tmux and source the config:
    ```
    tmux
    tmux source ~/.config/tmux/tmux.conf
    ```
4. trigger an update: `<C-Space>` then `I`.
5. Enjoy.

