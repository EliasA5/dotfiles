#!/bin/bash

if [ $# -eq 0 ]; then exit 0; fi

declare -a for_linux=("nvim" "tmux" "wezterm" "nvim-code")

if [[ "$1" == "linux" ]]; then
for i in "${for_linux[@]}"
do
   git worktree add ../$i $i
done
fi

declare -a for_windows=("wezterm-windows")

if [[ "$1" == "windows" ]]; then
for i in "${for_windows[@]}"
do
   git worktree add ../$i $i
done
fi

declare -a for_wsl=("nvim-wsl" "tmux" "nvim-code")

if [[ "$1" == "wsl" ]]; then
for i in "${for_wsl[@]}"
do
   git worktree add ../$i $i
done
fi

