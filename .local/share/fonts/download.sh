#!/bin/bash

for type in Bold Light Medium Regular Retina; do
  wget \
    -cq \
    --no-check-certificate \
    --directory-prefix=$(dirname $0) \
    "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/FiraCode/${type}/complete/Fura%20Code%20${type}%20Nerd%20Font%20Complete%20Mono.otf"

done
