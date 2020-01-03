#!/bin/bash

sudo apt update
sudo apt upgrade
sudo apt install git zsh tmux silversearcher-ag python python-pip python3 python3-pip software-properties-common python-dev python3-dev python3-setuptools direnv


wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
echo "deb https://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
sudo apt-get update
sudo apt-get install rcm

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

wget https://github.com/jhawthorn/fzy/releases/download/0.9/fzy_0.9-1_amd64.deb
sudo dpkg -i fzy_0.9-1_amd64.deb

sudo apt-add-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
