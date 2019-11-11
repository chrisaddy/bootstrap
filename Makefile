github = https://raw.githubusercontent.com/chrisaddy
GOPATH = $(HOME)/go-workspace

mac: git homebrew dotfiles go node python rust bin orgs
	mkdir projects


arch: dotfiles go node python rust bin orgs
	mkdir -p projects
	ln -s ~/dotfiles/.Xmodmap ~/.Xmodmap

zsh:
	curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	sh install.sh
	rm -rf $(HOME)/.zshrc && ln -s $(HOME)/dotfiles/.zshrc $(HOME)/.zshrc

xcode:
	curl -o install-xcode $(github)/bootstrap/master/install-xcode
	chmod +x install-xcode
	bash -c "./install-xcode"

git: xcode
	rm -rf $(HOME)/.gitconfig
	ln -s $(HOME)/dotfiles/.gitconfig $(HOME)/.gitconfig


homebrew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	curl -o Brewfile $(github)/bootstrap/master/Brewfile
	brew bundle cleanup --force

vim:
	rm -rf $(HOME)/.vimrc
	rm -rf $(HOME)/.config/nvim
	mkdir -p $(HOME)/.config/nvim
	ln -s $(HOME)/dotfiles/.vimrc $(HOME)/.config/nvim/init.vim
	ln -s $(HOME)/.config/nvim/init.vim $(HOME)/.vimrc
	nvim +PlugInstall +qall

emacs:
	rm -rf $(HOME)/.emacs.d $(HOME)/.doom.d
	git clone https://github.com/hlissner/doom-emacs $(HOME)/.emacs.d
	$(HOME)/.emacs.d/bin/doom install -y
	ln -s $(HOME)/dotfiles/emacs/config.el $(HOME)/.doom.d/config.el


schedule:
	crontab < $(HOME)/dotfiles/crons

get-dotfiles:
	rm -rf $(HOME)/dotfiles
	cd $(HOME) && git clone git@github.com:chrisaddy/dotfiles.git

dotfiles: get-dotfiles git zsh vim emacs schedule

go:
	mkdir -p $(GOPATH) $(GOPATH)/src $(GOPATH)/pkg $(GOPATH)/bin
	go get github.com/sparrc/gdm

node:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
	curl https://www.npmjs.com/install.sh | sh
	cat node-requirements.txt | xargs npm install -g

python:
	curl -o Pipfile $(github)/bootstrap/master/Pipfile
	pip install pipenv

rust:
	curl https://sh.rustup.rs -sSf | sh -s -- \
		--verbose --default-toolchain=nightly --profile=complete -y

orgs:
	rm -rf $(HOME)/orgs
	cd $(HOME) && git clone git@github.com:chrisaddy/orgs.git

bin:
	rm -rf $(HOME)/bin
	cd $(HOME) && git clone git@github.com:chrisaddy/bin.git


update:
	upgrade_oh_my_zsh
	cd $(HOME)/dotfiles/.vimrc && git pull origin master
	brew bundle
	# npm
	npm install npm@latest -g
	#python
	pip3 install --upgrade pip
	pur -r requirements.txt
	# rust
	rustup self update
	rustup update

backup:
	git add .
	git commit -m "backup $(shell date)"
	git pull origin master
	git push origin master

revert:
	rm Brewfile && touch Brewfile
	brew bundle cleanup --force
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
