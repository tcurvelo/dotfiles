CONTEXT := $(abspath $(dir $(MAKEFILE_LIST)))
OS := $(shell uname -s)

ifeq ($(OS), Darwin)
	fonts_dir = /Library/Fonts
else
	fonts_dir = ~/.local/share/fonts
endif
myfont = JetBrainsMono-Medium.ttf


.PHONY: submodules sync fonts vim

all: submodules sync vscode

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
	mkdir -p $(fonts_dir); \
	fontfile="JetBrainsMono-2.242.zip"; \
	wget -cq --no-check-certificate --directory-prefix=/tmp \
		https://download.jetbrains.com/fonts/$$fontfile \
	&& unzip -j /tmp/$$fontfile 'fonts/ttf/*' -d $(fonts_dir) \
	&& which fc-cache > /dev/null && fc-cache -vf

vim:
	vim +PlugClean +PlugUpdate +UpdateRemotePlugins +qall
