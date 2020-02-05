#!/bin/sh

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade
brew install peco the_silver_searcher ctags python fzf git zsh tmux fzy direnv wget vim
brew tap thoughtbot/formulae
brew install rcm
