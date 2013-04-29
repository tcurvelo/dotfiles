#!/bin/bash

rsync -av \
      --exclude '.git/' --exclude 'bootstrap.sh' --exclude 'README.rst' \
      $(dirname "$0")  ~/


#Create buildout cache directories
if [ ! -d /var/cache/buildout/eggs ] || [ ! -d /var/cache/buildout/dlcache ]
then 
    sudo mkdir -p /var/cache/buildout/eggs
    sudo mkdir -p /var/cache/buildout/dlcache
    sudo -E chown -R $USER /var/cache/buildout/ -R
fi

