mac: git vim homebrew go python rust

xcode:
	./install-xcode

git: xcode
	git config --global github.username chrisaddy
	git config --global user.email chris.william.addy@gmail.com

homebrew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew bundle

vim:
	curl -o $(HOME)/.vimrc https://raw.githubusercontent.com/chrisaddy/vimrc/master/.vimrc

go:
	ls

python:
	pip3 install --upgrade pip
	pip3 install -q -r requirements.txt

rust:
	mkdir rust && cd rust && curl -o Makefile https://raw.githubusercontent.com/PistonDevelopers/rust-empty/master/Makefile && make
	rm -rf rust
