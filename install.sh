#!/bin/bash

git submodule init
git submodule update

rsync -av \
  --exclude '.git/' \
  --exclude '.gitignore' \
  --exclude 'install.sh' \
  --exclude 'README.rst' \
  $(dirname "$0")  ~/

vim +BundleInstall +qall

