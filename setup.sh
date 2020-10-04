#!/bin/bash

for file in .??*
do
  [ "$file" = ".git" ] && continue
  [ "$file" = ".gitignore" ] && continue

  ln -sfnv $HOME/dotfiles/$file $HOME/$file
done

ln -sfnv $HOME/dotfiles/.vim/colors $HOME/.vim/colors
ln -sfnv $HOME/dotfiles/.vim/indent $HOME/.vim/indent
