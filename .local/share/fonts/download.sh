#!/bin/bash
os=$(uname -s)
case "$os" in
  Linux*)     dest="~/.local/share/fonts";;
  Darwin*)    dest="/Library/Fonts";;
esac


context=$(dirname $0)
file="FiraCode.zip"

wget \
  -cq --no-check-certificate --directory-prefix=$context \
  https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/FiraCode.zip \
  && unzip \
     $context/$file \
     Fura\ Code\ {Bold,Light,Medium,Regular,Retina}\ Nerd\ Font\ Complete.ttf \
     -d $dest
