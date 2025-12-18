#!/bin/bash

sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker 2>/dev/null
sudo usermod -aG docker $USER
