FROM ubuntu:22.04
RUN apt-get update && apt install -y software-properties-common && add-apt-repository ppa:jonathonf/vim && apt-get update && apt install -y git vim curl tmux wget unzip

RUN groupadd -g 1000 ubuntu && useradd --create-home --shell /bin/bash --uid 1000 --gid 1000 ubuntu
USER ubuntu
WORKDIR /home/ubuntu

RUN git clone https://github.com/ktact/dotfiles.git
#RUN wget --no-check-certificate https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh
