#!/bin/bash

git submodule init
git submodule update

context=
rsync -av \
  --exclude '.git/' \
  --exclude '.gitignore' \
  --exclude 'install.sh' \
  --exclude 'README.rst' \
  "$(dirname "$(readlink -f "$0")")/" ~/

fc-cache -vf ~/.fonts
vim +BundleInstall +qall

