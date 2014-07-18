#!/bin/bash

context="$(dirname "$(readlink -f "$0")")"

cd "$context"
git submodule init
git submodule update
cd -

rsync -av \
  --exclude '.git/' \
  --exclude '.gitignore' \
  --exclude '*.swp' \
  --exclude 'install.sh' \
  --exclude 'README.rst' \
  "$context/" ~/

fc-cache -vf ~/.fonts
vim +BundleInstall +qall

