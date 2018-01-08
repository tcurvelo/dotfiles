#!/bin/bash
context=$(dirname $0)
file="FiraCode.zip"

wget \
  -cq --no-check-certificate --directory-prefix=$context \
  "https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/FiraCode.zip" && \
    unzip -x $context/$file -d $context

