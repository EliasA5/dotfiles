#!/bin/bash

if [ $# -eq 0 ]; then exit 0; fi
declare -a all=("nvim" "tmux" "wezterm" "nvim-code" "kitty" "wezterm-windows" "nvim-wsl" "lazygit")

declare -a for_linux=("nvim" "tmux" "wezterm" "nvim-code" "kitty" "lazygit")

if [[ ${all[@]} =~ $1 ]]; then
	git worktree add ~/.config/$1 origin/$1
	exit 0
else
	echo "invalid name, valid configs: (${all[@]})"
	exit 1
fi

if [[ "$1" == "linux" ]]; then
	for i in "${for_linux[@]}"
	do
		git worktree add ~/.config/$i origin/$i
	done
	exit 0
fi

declare -a for_windows=("wezterm-windows")

if [[ "$1" == "windows" ]]; then
	for i in "${for_windows[@]}"
	do
		git worktree add ../$i origin/$i
	done
	exit 0
fi

declare -a for_wsl=("nvim-wsl" "tmux" "nvim-code")

if [[ "$1" == "wsl" ]]; then
	for i in "${for_wsl[@]}"
	do
		git worktree add ~/.config/$i origin/$i
	done
	exit 0
fi

