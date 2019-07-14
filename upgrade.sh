#!/bin/bash

base_dir="$HOME/.vim/pack/dist/start"
cd $base_dir
for i in $base_dir/* ; do
    if [ -d "$i" ]; then
        echo "$i"
        cd $i && git pull origin master
        cd $base_dir
    fi
done
