github = https://raw.githubusercontent.com/chrisaddy

mac: git homebrew zsh vim go node python

zsh:
	curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	cd $(HOME) && curl -o .zshrc $(github)/bootstrap/master.zshrc

xcode:
	curl -o install-xcode $(github)/bootstrap/master/install-xcode
	chmod +x install-xcode
	bash -c "./install-xcode"

git: xcode
	git config --global github.username chrisaddy
	git config --global user.email chris.william.addy@gmail.com

homebrew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	curl -o Brewfile $(github)/bootstrap/master/Brewfile
	brew bundle

vim:
	rm -rf $(HOME)/.vimrc
	cd $(HOME) && rm -rf vimrc && git clone https://github.com/chrisaddy/vimrc.git
	ln -s $(HOME)/vimrc/.vimrc $(HOME)/.vimrc

go:

node:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash


python:
	pip3 install --upgrade pip
	pip3 install -q -r requirements.txt

rust:
	ls

revert:
	rm Brewfile && touch Brewfile
	brew bundle cleanup --force
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
