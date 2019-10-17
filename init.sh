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

pip3 install --user powerline-status awscli awslogs pynvim

# powerline
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# zsh
zsh prezto.sh

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# zsh
touch ~/.zshrc.mine

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

