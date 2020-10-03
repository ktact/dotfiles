#!/bin/bash

DOT_FILES=(.vimrc .tmux.conf)

for file in ${DOT_FILES[@]}
do
    ln -sfn $HOME/dotfiles/$file $HOME/$file
done

ln -sfn $HOME/dotfiles/.vim/colors $HOME/.vim/colors
ln -sfn $HOME/dotfiles/.vim/indent $HOME/.vim/indent
