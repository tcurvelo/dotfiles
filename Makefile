CONTEXT := $(abspath $(dir $(MAKEFILE_LIST)))

.PHONY: all submodules sync fonts vim code

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

fonts:
	~/.local/share/fonts/download.sh
	fc-cache -f

vim:
	vim +PlugClean +PlugUpdate +UpdateRemotePlugins +qall

vscode:
	for plugin in `cat ~/.config/Code/User/my-plugins.txt`; do \
		code --install-extension $$plugin ; \
	done
