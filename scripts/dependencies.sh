#!/bin/bash

yay -Syu

yay -S git-secret figlet lolcat

pip3 list --format=columns | grep setuptools || pip3 install setuptools
pip3 list --format=columns | grep click || pip3 install click
pip3 list --format=columns | grep PyYAML || pip3 install PyYAML
