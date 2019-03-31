CONTEXT := $(abspath $(dir $(MAKEFILE_LIST)))
OS := $(shell uname -s)

ifeq ($(OS), Darwin)
	fonts_dir = /Library/Fonts
else
	fonts_dir = ~/.local/share/fonts
endif
myfont = Fura\ Code\ Regular\ Nerd\ Font\ Complete.ttf


.PHONY: submodules sync fonts vim code

all: submodules sync fonts vim vscode

submodules:
	git submodule init
	git submodule update --remote --rebase

sync:
	rsync -av \
		--exclude '.git/' \
		--exclude '.gitignore' \
		--exclude '.gitkeep' \
		--exclude '*.swp' \
		--exclude 'README.md' \
		--exclude 'Makefile' \
		"$(CONTEXT)/" ~/

fonts: $(fonts_dir)/$(myfont)

$(fonts_dir)/$(myfont):
	wget -cq --no-check-certificate --directory-prefix=/tmp \
		https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/FiraCode.zip \
	&& unzip /tmp/FiraCode.zip $(myfont) -d $(fonts_dir) \
	&& which fc-cache > /dev/null && fc-cache -vf

vim:
	vim +PlugClean +PlugUpdate +UpdateRemotePlugins +qall

vscode:
	for plugin in `cat ~/.config/Code/User/my-plugins.txt`; do \
		(code --install-extension $$plugin &); \
	done
