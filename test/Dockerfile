FROM ubuntu:22.04

RUN apt-get update && \
    apt install -y software-properties-common && \
    add-apt-repository ppa:jonathonf/vim && \
    apt-get update && \
    apt install -y git vim curl tmux wget unzip sudo apt-utils

ARG username=ubuntu

#RUN groupadd -g 1000 ${username} && useradd --create-home --shell /bin/bash --uid 1000 --gid 1000 ${username}
RUN echo "root:root" | chpasswd && \
    adduser --disabled-password --gecos "" "${username}" && \
    echo "${username}:${username}" | chpasswd && \
    mkdir -p /etc/sudoers.d && \
    echo "%${username}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${username} && \
    echo 0440 /etc/sudoers.d/${username}

USER ${username}

RUN mkdir -p /home/${username}/dotfiles/.vim && mkdir /home/${username}/dotfiles/.tmux
COPY setup.sh /home/${username}/dotfiles
COPY packages.sh /home/${username}/dotfiles
COPY utils.sh /home/${username}/dotfiles
COPY .tmux.conf /home/${username}/dotfiles
COPY .tmux /home/${username}/dotfiles/.tmux
COPY .vimrc /home/${username}/dotfiles
COPY .vim/ /home/${username}/dotfiles/.vim
COPY .git-prompt.sh /home/${username}
RUN chown ${username}:${username} /home/${username}

WORKDIR /home/${username}/dotfiles
