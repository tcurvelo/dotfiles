#!/bin/bash

git submodule init
git submodule update

context=$(dirname $(readlink -f "$0"))

rsync -av \
  --exclude '.git/' \
  --exclude '.gitignore' \
  --exclude 'install.sh' \
  --exclude 'README.rst' \
  "$context"/ ~/

vim +BundleInstall +qall

