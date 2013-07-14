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
mkdir .vim/bundle

cd .vim/doc/download
wget http://jp.php.net/get/php_manual_ja.tar.gz/from/this/mirror
mv mirror php_manual_ja.tar.gz
tar zxvf php_manual_ja.tar.gz
rm php_manual_ja.tar.gz
cd ../../..

mkdir ~/bin

mkdir tmp
cd tmp

if [ `uname` = "Darwin" ]; then
    #mac用のコード
    git clone https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard.git
    cd tmux-MacOSX-pasteboard
    make reattach-to-user-namespace
    cp reattach-to-user-namespace ~/bin
    cd ..

    cp ../tmux-pbcopy ~/bin
fi

git clone https://github.com/rkitover/vimpager.git
mv vimpager/vimpager ~/bin
mv vimpager/vimcat ~/bin
chmod +x ~/bin/vimpager
chmod +x ~/bin/vimcat

cd ..
rm -rf tmp

