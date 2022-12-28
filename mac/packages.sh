#!/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

eval $(/opt/homebrew/bin/brew shellenv)

brew update
brew upgrade
brew install peco the_silver_searcher ctags python fzf git zsh tmux fzy direnv wget vim git-delta gh act certbot foreman heroku gomplate mint pwgen qcachegrind terraform hey asdf ack awslogs autoconf automake bison freetype gd gettext icu4c krb5 libedit libiconv libjpeg libpng libxml2 libzip pkg-config re2c zlib gmp libsodium imagemagick
brew tap thoughtbot/formulae
brew install hyper --cask
brew install rcm

