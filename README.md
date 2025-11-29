
# My Dotfiles Repository

## Each branch is for a different program/platform

- Use `git worktree add <path> <branch>` to checkout each config, for example:

``` bash
git worktree add ../nvim nvim
```

Feel free to use it however you like.


# My Tmux configuration

Installation:
1. clone the repository:
    ```bash
    git clone --single-branch -b tmux https://github.com/EliasA5/dotfiles/ ~/.config/tmux
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

