#!/bin/bash

DOTFILES=$HOME/repo/dotfiles
SYMLIST=symlist.txt

for file in $(cat $SYMLIST)
do
  SYMNAME=$(find $HOME -type l -name $file -print)
  if [ -L "$SYMNAME" ]; then
    echo "$HOME/$file already exists"
  else
    echo "$HOME/$file missing"
    echo "creating symlink"
    ln -s $DOTFILES/$file $HOME/$file
    echo "$HOME/$file created"
  fi
done;

