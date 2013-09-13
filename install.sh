#!/bin/bash

rsync -av \
      --exclude '.git/' --exclude 'install.sh' --exclude 'README.rst' \
      $(dirname "$0")  ~/

