#!/bin/bash

cd $(dirname "$0")

FILES=$(ls -a | egrep -v '(^.$|^..$|bootstrap.sh|.git|README.rst)')

echo $FILES

if [ "$FILES" != "" ] 
then 
	cp -r -s $FILES ~/
fi

