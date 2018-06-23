#!/bin/sh

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade
brew install neovim peco ag ctags zplug python@2 python fzf reattach-to-user-namespace git zsh tmux fzy
brew tap thoughtbot/formulae
brew install rcm
