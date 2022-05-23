#!/bin/bash

# Docker
sudo apt-get -y install docker.io docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER
