#!/bin/bash

rsync -av \
      --exclude '.git/' --exclude 'bootstrap.sh' --exclude 'README.rst' \
      $(dirname "$0")  ~/

