#!/usr/bin/env bash

cp configs/vimrc ~/.vimrc

mkdir -p ~/.vim/backups
mkdir -p ~/.vim/swaps
mkdir -p ~/.vim/undo

if [ `uname` == Darwin ]; then
	echo "...Installing Source Code Pro font"
	brew tap caskroom/fonts && brew cask install font-source-code-pro

	echo "...Downloading base16-tomorrow-night vim color scheme"
	mkdir -p ~/.vim/colors
	curl --silent https://raw.githubusercontent.com/chriskempson/base16-vim/master/colors/base16-tomorrow-night.vim --output ~/.vim/colors/base16-tomorrow-night.vim

	echo "...Downloading base16-tomorrow-night iTerm color scheme"
	curl --silent https://raw.githubusercontent.com/martinlindhe/base16-iterm2/master/itermcolors/base16-tomorrow-night.itermcolors --output /tmp/base16-tomorrow-night.itermcolors

	echo "...Converting base16-tomorrow-night iTerm color scheme to Apple Terminal color scheme"
	curl --silent https://raw.githubusercontent.com/lysyi3m/osx-terminal-themes/master/tools/iterm2terminal.swift --output /tmp/iterm2terminal.swift
	sed -i "" 's/PragmataPro/SourceCodePro-Regular/g' /tmp/iterm2terminal.swift
	sed -i "" 's/"columnCount": 90/"columnCount": 100/g' /tmp/iterm2terminal.swift
	sed -i "" 's/"rowCount": 50/"rowCount": 35/g' /tmp/iterm2terminal.swift
	#sed -i "" 's/Foreground Color/Ansi 7 Color/g' /tmp/iterm2terminal.swift
	sed -i "" 's/BoldTextColor/TextBoldColor/g' /tmp/iterm2terminal.swift
	sed -i "" '/"rowCount": 35,/ i\
	"shellExitAction": 1,
	' /tmp/iterm2terminal.swift

	chmod +x /tmp/iterm2terminal.swift
	/tmp/iterm2terminal.swift /tmp/base16-tomorrow-night.itermcolors

	open -g /tmp/base16-tomorrow-night.terminal

	echo "...Setting Termainal application settings"
	defaults write ~/Library/Preferences/com.apple.Terminal.plist "Default Window Settings" "base16-tomorrow-night"
	defaults write ~/Library/Preferences/com.apple.Terminal.plist "Startup Window Settings" "base16-tomorrow-night"

	echo "...Complete! Restart Terminal application for all new settings to take effect."

elif [ `uname` == Linux ]; then
	git clone https://github.com/AuditeMarlow/base16-manager.git
	cd base16-manager
	sudo make install
	base16-manager install chriskempson/base16-vim
	base16-manager install chriskempson/base16-shell
	base16-manager set tomorrow-night
fi
