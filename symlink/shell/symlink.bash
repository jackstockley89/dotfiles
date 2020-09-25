#!/bin/bash
#set -x

DOTFILES=$HOME/repo/dotfiles
SYMLIST=symlist.txt

for file in $(cat $SYMLIST)
do
  SYMLINK=$(find $HOME -type l -name .$file -print)
  if [ -L "$SYMLINK" ]; then
    echo "soft link $HOME/.$file already exists"
  else
    echo "soft link $HOME/.$file is missing"
    DIRFILE=$(find $HOME -type f -name .$file -print)
    if [ -f "$DIRFILE" ]; then
      echo "replacing file for symlink"
      rm -rf $HOME/.$file
    fi
    echo "creating symlink"
    ln -s $DOTFILES/$file $HOME/.$file
    echo "$HOME/.$file created"
  fi
done;
