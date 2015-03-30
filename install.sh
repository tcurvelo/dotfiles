#!/bin/bash

context="$(dirname "$(readlink -f "$0")")"

cd "$context"
git submodule init
git submodule update
git submodule foreach git pull origin master
cd -

rsync -av \
  --exclude '.git/' \
  --exclude '.gitignore' \
  --exclude '*.swp' \
  --exclude 'install.sh' \
  --exclude 'README.rst' \
  "$context/" ~/

fc-cache -vf ~/.fonts
vim +NeoBundleInstall +qall

if [ "$(find ~/.vim/bundle/YouCompleteMe -name 'ycm_client_support.so')" == "" ]
then
  cd ~/.vim/bundle/YouCompleteMe && ./install.sh && cd -
fi

