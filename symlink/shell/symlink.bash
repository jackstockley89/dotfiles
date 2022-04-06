#!/bin/bash
#set -x

DOTFILES=$HOME/repo/dotfiles
SYMLIST=symlist.txt
normal="$(tput sgr0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"

for file in $(cat $SYMLIST)
do
  SYMLINK=$(find $HOME -maxdepth 1 -type l -name .$file -print)
  if [ -L "$SYMLINK" ]; then
    echo -e "soft link $HOME/.$file ${green}already exists${normal}"
  else
    echo -e "soft link $HOME/.$file ${red}is missing${normal}"
    SYMDIR=$(find $HOME -maxdepth 1 -type d -name .$file -print)
    SYMFILE=$(find $HOME -maxdepth 1 -type f -name .$file -print)
    if [ -f "$SYMFILE" ]; then
      echo -e "${green}replacing file for symlink${normal}"
    elif [ -d "$SYMDIR" ]; then
      echo -e "${green}replacing directory for symlink${normal}"
    fi
    rm -rf $HOME/.$file
    echo -e "${green}creating symlink${normal}"
    ln -s $DOTFILES/$file $HOME/.$file
    echo -e "$HOME/.$file ${green}created${normal}"
  fi
done;
