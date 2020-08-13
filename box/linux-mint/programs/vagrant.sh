#!/bin/bash

# Virtual Box 6.1
sudo apt-get -y install virtualbox-6.1

# Vagrant 2.2.9
cd /tmp
wget https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_linux_amd64.zip
unzip vagrant_2.2.9_linux_amd64.zip
sudo mv vagrant /usr/local/bin/.

vagrant plugin install vagrant-disksize
