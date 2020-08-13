FROM    ubuntu:latest

ENV     USER cmiranda
ENV     PASSWORD cmiranda
ENV     DOTFILES_HOME /home/cmiranda/workspace

# Required for lolcat to work
ENV     PATH /usr/games/:$PATH

# Avoids command line interactions
ARG     DEBIAN_FRONTEND=noninteractive

RUN     apt-get -y update && \
        apt-get -y upgrade && \
        apt-get -y install sudo

RUN     apt-get install -y              \
        git                             \
        curl                            \
        python3                         \
        python3-pip                     \
        software-properties-common      \
        wget                            \
        rsync                           \
        zsh

RUN     groupadd --gid 5000 $USER       \
        && useradd                      \
        --home-dir /home/$USER          \
        --create-home --uid 5000        \
        --gid 5000 --shell /bin/sh      \
        --skel /dev/null $USER          \
        && usermod -aG sudo $USER

RUN     echo "$USER:$PASSWORD" | chpasswd

RUN     mkdir -p $DOTFILES_HOME/dotfiles
ADD     . $DOTFILES_HOME/dotfiles/.

RUN     chmod -R 775 $DOTFILES_HOME 
RUN     chown -R $USER:$USER $DOTFILES_HOME

USER    $USER
WORKDIR $DOTFILES_HOME/dotfiles

# Mocking secrets
# These will be provided by git-secret after revealing secrets
RUN     /bin/bash scripts/tests/mock-secrets.sh $DOTFILES_HOME/dotfiles

RUN     /bin/bash scripts/sync.sh

CMD     ["/usr/bin/zsh"]
