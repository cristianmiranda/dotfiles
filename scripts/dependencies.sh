#!/bin/bash

export DPKG_PAGER=cat

#
# git-secret - https://git-secret.io/
#
dpkg -l git-secret
if [ $? -ne 0 ]; then
    echo "deb https://dl.bintray.com/sobolevn/deb git-secret main" | sudo tee -a /etc/apt/sources.list
    wget -qO - https://api.bintray.com/users/sobolevn/keys/gpg/public.key | sudo apt-key add -
    sudo apt-get update && sudo apt-get -y install git-secret
fi

#
# python dependencies
#
dpkg -l python3 python3-pip
if [ $? -ne 0 ]; then
    sudo apt-get -y install python3 python3-pip
fi

pip3 list --format=columns | grep setuptools || pip3 install setuptools
pip3 list --format=columns | grep click || pip3 install click
pip3 install -U PyYAML

#
# yq - https://mikefarah.gitbook.io/yq/
#
dpkg -l yq
if [ $? -ne 0 ]; then
    sudo add-apt-repository -y ppa:rmescandon/yq
    sudo apt update
    sudo apt-get -y install yq
fi

#
# Pretty logs 
#
dpkg -l figlet lolcat
if [ $? -ne 0 ]; then
    sudo apt-get install -y figlet lolcat
fi
