#!/bin/sh
cd $(dirname $0)
for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
    then
        ln -Fis "$PWD/$dotfile" $HOME
    fi
done

git submodule init
git submodule update
cd .vim/bundle/vundle
git checkout master
cd ../../..

cd .vim/doc/download
wget http://jp.php.net/get/php_manual_ja.tar.gz/from/this/mirror
mv mirror php_manual_ja.tar.gz
tar zxvf php_manual_ja.tar.gz
rm php_manual_ja.tar.gz
cd ../../..

mkdir tmp
cd tmp

if [ `uname` = "Darwin" ]; then
    #mac用のコード
    git clone https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard.git
    cd tmux-MacOSX-pasteboard
    make reattach-to-user-namespace
    cp reattach-to-user-namespace ~/bin
    cd ..

    echo 'set-option -g default-command "reattach-to-user-namespace -l zsh"' >> ../.tmux.conf
fi

cd ..
rm -rf tmp

