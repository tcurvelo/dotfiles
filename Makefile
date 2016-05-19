CONTEXT := $(abspath $(dir $(MAKEFILE_LIST)))


all: submodules sync fonts vim

submodules:
	git submodule init
	git submodule update --remote --rebase

sync:
	rsync -av \
		--exclude '.git/' \
		--exclude '.gitignore' \
		--exclude '*.swp' \
		--exclude 'README.md' \
		--exclude 'Makefile' \
		"$(CONTEXT)/" ~/

fonts:
	fc-cache -vf ~/.fonts

vim:
	vim +PlugUpdate +qall
