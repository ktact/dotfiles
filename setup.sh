#!/bin/bash

for file in .??*
do
  [ "$file" = ".git" ] && continue
  [ "$file" = ".gitignore" ] && continue

  ln -sfnv $HOME/dotfiles/$file $HOME/$file
done

ln -sfnv $HOME/dotfiles/.vim/colors $HOME/.vim/colors
ln -sfnv $HOME/dotfiles/.vim/indent $HOME/.vim/indent

echo "source ~/.git-prompt.sh" >> ~/.bashrc
echo "export PS1='\[\033[1;32m\]\u\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\] \$ '" >> ~/.bash_profile

has() {
  type "$1" > /dev/null 2>&1
}

if has "npm"; then
  echo "Install npm packages..."

  sudo npm i -g git-split-diffs

  echo "$(tput setaf 2)Install npm packages complete. ✔︎$(tput sgr0)"
fi
