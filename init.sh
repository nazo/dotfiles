#!/bin/bash

OS=linux
if [ "$(uname)" == 'Darwin' ]; then
  OS=mac
fi
if [ -e /etc/lsb-release ]; then
  OS=ubuntu
fi

/bin/sh $PWD/$OS/packages.sh

# dotfiles
rcup -d $PWD/home -v

# vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install --upgrade neovim
pip install --user powerline-status

# zsh

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
