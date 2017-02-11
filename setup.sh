#!/bin/bash

DOT_FILES=(.vimrc)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

ln -s $HOME/dotfiles/.vim/colors $HOME/.vim/colors
ln -s $HOME/dotfiles/.vim/indent $HOME/.vim/indent
