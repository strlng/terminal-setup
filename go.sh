#!/usr/bin/env bash

cp configs/.vimrc ~/

mkdir -p ~/.vim/backups
mkdir -p ~/.vim/swaps
mkdir -p ~/.vim/undo

if [ `uname` == Darwin ]; then
	brew install base16-manager
elif [ `uname` == Linux ]; then
	git clone https://github.com/AuditeMarlow/base16-manager.git
	cd base16-manager
	sudo make install
fi

base16-manager install chriskempson/base16-vim
base16-manager install chriskempson/base16-shell

base16-manager set tomorrow-night
