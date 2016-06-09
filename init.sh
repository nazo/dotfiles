#!/bin/sh
cd $(dirname $0)
for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
    then
        ln -Fs "$PWD/$dotfile" $HOME
    fi
done

git submodule init
git submodule update
git submodule foreach 'git checkout master; git pull'

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

chmod 755 .vim/bundle/tagbar-phpctags/bin/phpctags

mkdir -p $HOME/.zsh/plugins/bd
curl https://raw.githubusercontent.com/Tarrasch/zsh-bd/master/bd.zsh > $HOME/.zsh/plugins/bd/bd.zsh

mkdir $HOME/.tmuxinator
wget https://raw.github.com/aziz/tmuxinator/master/completion/tmuxinator.zsh
mv tmuxinator.zsh $HOME/.tmuxinator

cd .vim/doc/download
wget http://jp.php.net/get/php_manual_ja.tar.gz/from/this/mirror
mv mirror php_manual_ja.tar.gz
tar zxvf php_manual_ja.tar.gz
rm php_manual_ja.tar.gz
cd ../../..

mkdir ${HOME}/bin
mkdir ${HOME}/go

ln -Fs "$PWD/plantuml" ~/bin

if [ `uname` = "Darwin" ]; then
    #mac用のコード(Homebrew)
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    brew doctor
    brew bundle
fi

mkdir tmp
cd tmp

if [ `uname` = "Darwin" ]; then
    #mac用のコード
    cp ../tmux-pbcopy ~/bin
fi

git clone https://github.com/rkitover/vimpager.git
mv vimpager/vimpager ~/bin
mv vimpager/vimcat ~/bin

git clone https://github.com/erikw/tmux-powerline.git

cd ..

sh ctags.sh

rm -rf tmp

cp tmuxx ~/bin
chmod +x ~/bin/vimpager
chmod +x ~/bin/vimcat
chmod +x ~/bin/tmuxx

