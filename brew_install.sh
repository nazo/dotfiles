#!/bin/sh

ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
brew doctor
brew update

brew install jq
brew install ctags
brew install git
brew install git-now
brew install gettext
brew install jsl
brew install memcached
brew install tmux
brew install wget
brew install tig
brew install zsh
brew install mobile-shell
brew install phpenv
brew install reattach-to-user-namespace

