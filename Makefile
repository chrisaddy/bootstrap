github = https://raw.githubusercontent.com/chrisaddy
GOPATH = $(HOME)/go-workspace

mac: git homebrew dotfiles go node python

zsh:
	curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	ln -s $(HOME)/dotfiles/.zshrc $(HOME)/.zshrc

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
	ln -s $(HOME)/dotfiles/.vimrc $(HOME)/.vimrc
	nvim +PlugInstall +qall

dotfiles: zsh vim
	rm -rf $(HOME)/dotfiles
	cd $(HOME) && git clone git@github.com:chrisaddy/dotfiles.git


go:
	mkdir -p $(GOPATH) $(GOPATH)/src $(GOPATH)/pkg $(GOPATH)/bin
	go get github.com/sparrc/gdm

node:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
	curl https://www.npmjs.com/install.sh | sh


python:
	pip3 install --upgrade pip
	pip3 install -q -r requirements.txt

rust:
	curl https://sh.rustup.rs -sSf | sh -s -- \
		--verbose --default-toolchain=nightly --profile=complete -y
	source $(HOME)/.cargo/env


update:
	cd $(HOME)/vimrc && git pull origin master
	brew bundle
	# node
	npm install npm@latest -g
	#python
	pip3 install --upgrade pip
	pur -r requirements.txt
	# rust
	rustup self update
	rustup update

revert:
	rm Brewfile && touch Brewfile
	brew bundle cleanup --force
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
