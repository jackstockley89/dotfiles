#!/bin/bash

# change directory to repository root
cd "/Users/jack.stockley/repo/jackstockley89/dotfiles"
# check branch if not main do git checkout main
branch = `terrafrom branch`
if [$branch != "main"]; then
  git checkout main 
fi
# git pull on main
git pull

# git checkout -b brewfile-update
git checkout -b brewfile-update

# git rebase main 
git rebase main

# backup Brewfile
mv Brewfile backup_Brewfile

# update Brewfile
brew bundle dump

# git add brewfile
git add ./Brewfile

# git commit 
git commit -m "feat(brew): update brewfile to latest"

# git push 
git push

# git create pull request 
gh pr create -fill