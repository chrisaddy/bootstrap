artifacts = https://raw.githubusercontent.com/chrisaddy/bootstrap/master/

mac: git homebrew zsh vim go node python

zsh:
	curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	cd $(HOME) && curl -o .zshrc $(artifacts).zshrc
xcode:
	curl -o install-xcode $(artifacts)install-xcode
	chmod +x install-xcode
	./install-xcode

git: xcode
	git config --global github.username chrisaddy
	git config --global user.email chris.william.addy@gmail.com

homebrew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	curl -o Brewfile $(artifacts)Brewfile
	brew bundle

vim:
	cd $(HOME) && curl -o .vimrc $(artifacts).vimrc

go:
	ls

node:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
	export NVM_DIR="$HOME/.nvm" && \
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
	nvm install node


python:
	pip3 install --upgrade pip
	pip3 install -q -r requirements.txt

rust:
	ls
