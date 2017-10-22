#!/bin/bash

for type in Bold Light Medium Regular Retina; do
  wget -q -O ~/.local/share/fonts/FiraCode-${type}.ttf \
  "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true";
done
