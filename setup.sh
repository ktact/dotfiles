#!/bin/bash

# Include
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
}

link_files || die "Failed to deploy dotfiles"

# Install packages

function install_docker() {
  if ! has "docker"; then
    # Setup the repository
    ## 1. Update the apt package index and install packages to allow apt to use a repository over HTTPS:
    sudo apt-get update > /dev/null
    sudo apt-get install \
      ca-certificates \
      curl \
      gnupg > /dev/null
    ## 2. Add Docker's official GPG key:
    sudo mkdir -m 0755 -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg > /dev/null
    ## 3. Set up the repository:
    echo \
      "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      \"$(. /etc/os-release && echo \"$VERSION_CODENAME\")\" stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    # Install Docker Engine
    sudo apt-get update > /dev/null
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin > /dev/null

    success "Docker installation is complete"
  fi

  return 0
}

install_docker || die "Failed to install docker"

function install_fzf() {
  if ! has "fzf"; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf > /dev/null
    yes | ~/.fzf/install > /dev/null
  echo '[ -f ~/.fzf.bash ] && source ~/.fzf.bash' >> $HOME/.bashrc

    success "fzf instllation is complete"
  fi

  return 0
}

install_fzf || die "Faild to install fzf"

function install_deno() {
  if ! has "deno"; then
    curl -fsSL https://deno.land/x/install/install.sh | sh
    cat << "EOF" >> $HOME/.bashrc
export DENO_INSTALL=$HOME/.deno
export PATH=$DENO_INSTALL/bin:$PATH
EOF

    success "Deno installation is complete"
  fi

  return 0
}

install_deno || die "Failed to install deno"

function install_npm_packages() {
  if has "npm"; then
    echo "Install npm packages..."

    sudo npm i -g git-split-diffs > /dev/null

    success "npm packages installation is complete"
  fi

  return 0
}

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
