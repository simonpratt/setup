#!/bin/bash

echo "Running Setup"

set -e

currentUser=`logname`
currentHome=`eval echo ~$currentUser`
currentDirectory=`pwd`

# create home bin dir
if [ -d $currentHome/bin ]; then
  echo "[ok] bin exists"
else
  echo "[ok] creating bin!"
  mkdir $currentHome/bin
fi

echo ""

read -p "setup zsh? [y/n]: " setup_zsh;
read -p "setup git? [y/n]: " setup_git;
read -p "setup tmux? [y/n]: " setup_tmux;
read -p "setup kitty? [y/n]: " setup_kitty;

if [ "$setup_zsh" == "y" ]; then
    echo "installing up zsh"
    bash ./scripts/zsh.sh
fi

if [ "$setup_git" == "y" ]; then
    echo "setting up git"
    bash ./scripts/git.sh
fi

if [ "$setup_tmux" == "y" ]; then
    echo "setting up tmux"
    bash ./scripts/tmux.sh
fi

if [ "$setup_kitty" == "y" ]; then
    echo "setting up kitty"
    bash ./scripts/kitty.sh
fi
