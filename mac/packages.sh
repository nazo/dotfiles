#!/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

eval $(/opt/homebrew/bin/brew shellenv)

brew update
brew upgrade
brew install peco the_silver_searcher ctags python fzf git zsh tmux fzy direnv wget vim git-delta
brew tap thoughtbot/formulae
brew install rcm
