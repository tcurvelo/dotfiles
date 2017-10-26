#!/bin/bash

for type in Bold Light Medium Regular Retina; do
  wget --no-check-certificate -cqO ~/.local/share/fonts/FiraCode-${type}.ttf \
  "https://raw.githubusercontent.com/tonsky/FiraCode/master/distr/ttf/FiraCode-${type}.ttf"
done
