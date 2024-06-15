#!/bin/bash

source utils.sh

function install_docker() {
  if ! has "docker"; then
    # Setup the repository
    ## 1. Update the apt package index and install packages to allow apt to use a repository over HTTPS:
    sudo apt-get update > /dev/null
    sudo apt-get install \
      ca-certificates \
      curl > /dev/null
    ## 2. Add Docker's official GPG key:
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    ## 3. Set up the repository:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    # Install Docker Engine
    sudo apt-get update > /dev/null
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin > /dev/null
    # Start Docker
    sudo systemctl enable docker
    sudo systemctl start docker

    success "Docker installation is complete"
  fi

  return 0
}

function install_fzf() {
  if ! has "fzf"; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf > /dev/null
    yes | ~/.fzf/install > /dev/null
  echo '[ -f ~/.fzf.bash ] && source ~/.fzf.bash' >> $HOME/.bashrc

    success "fzf instllation is complete"
  fi

  return 0
}

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

function install_npm_packages() {
  if has "npm"; then
    echo "Install npm packages..."

    sudo npm i -g git-split-diffs > /dev/null

    success "npm packages installation is complete"
  fi

  return 0
}
