#!/bin/sh

mkdir -p ${HOME}/dotfiles/tmp
cd ${HOME}/dotfiles/tmp
wget http://hp.vector.co.jp/authors/VA025040/ctags/downloads/ctags-5.8j2.tar.gz
tar zxvf ctags-5.8j2.tar.gz
cd ctags-5.8j2
mkdir ${HOME}/opt/ctags
./configure --prefix=${HOME}/opt/ctags
make
make install

