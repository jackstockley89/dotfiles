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
    SYMDIR=$(find $HOME -type d -name .$file -print)
    SYMFILE=$(find $HOME -type f -name .$file -print)
    if [ -f "$SYMFILE" ]; then
      echo "replacing file for symlink"
    elif [ -d "$SYMDIR" ]; then
      echo "replacing directory for symlink"
    fi
    rm -rf $HOME/.$file
    echo "creating symlink"
    ln -s $DOTFILES/$file $HOME/.$file
    echo "$HOME/.$file created"
  fi
done;
