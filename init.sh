#!/bin/sh
cd $(dirname $0)
for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
    then
        ln -Fs "$PWD/$dotfile" $HOME
    fi
done

mkdir -p ~/.config/

git submodule init
git submodule update
git submodule foreach 'git checkout master; git pull'

if [ `uname` = "Darwin" ]; then
    #mac用のコード(Homebrew)
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
    brew tap Homebrew/brewdler
    brew bundle
fi

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

chmod 755 .vim/bundle/tagbar-phpctags/bin/phpctags

mkdir $HOME/.tmuxinator
wget https://raw.github.com/aziz/tmuxinator/master/completion/tmuxinator.zsh
mv tmuxinator.zsh $HOME/.tmuxinator

mkdir ${HOME}/bin
mkdir ${HOME}/go

ln -Fs "$PWD/plantuml" ~/bin

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

rm -rf ~/.rbenv/plugins/ruby-build
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

rm -rf tmp

cp tmuxx ~/bin
chmod +x ~/bin/vimpager
chmod +x ~/bin/vimcat
chmod +x ~/bin/tmuxx

