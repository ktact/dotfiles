#!/bin/bash

# Include
source packages.sh
source utils.sh

# Link some files
function link_files() {
  for file in .??*
  do
    [ "$file" = ".git" ] && continue
    [ "$file" = ".gitignore" ] && continue

    ln -sfnv $HOME/dotfiles/$file $HOME/$file > /dev/null
  done

  success "Dotfiles deployment is complete"

  return 0
}

link_files || die "Failed to deploy dotfiles"

# Install packages
sudo apt install -y vim tmux
install_docker       || die "Failed to install docker"
install_fzf          || die "Faild to install fzf"
install_deno         || die "Failed to install deno"
install_npm_packages || die "Failed to install npm packages"

# Add a settings to .bashrc
echo 'alias docker-purge="docker stop $(docker ps -q -a) && docker container prune && docker rmi $(docker images -q) -f"' >> $HOME/.bashrc || die "Failed to set alias docker-purge"
echo 'source ~/.git-prompt.sh' >> $HOME/.bashrc || die "Failed to source .git-prompt.sh"
echo 'export PS1=\"\[\033[1;32m\]\u\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\] \$ \"' >> $HOME/.bash_profile || die "Failed to set PS1"
cat << "EOF" >> $HOME/.bashrc
alias fgv='__fgv'

function __fgv() {
  if [ -z "$1" ]; then
    echo "Usage: fgv {SEARCH_PATTERN}"
    return 1
  fi

  # Recursively grep with the given pattern in the current directory | fzf
  selected_search_result=`grep -Rn '$1' . 2>/dev/null | fzf`

  # Display the line of the selected file.
  vi `echo '$selected_search_result' | awk -F ":" '{ print $1 " +" $2 }'`
}
EOF

success "All settings are now complete!"
