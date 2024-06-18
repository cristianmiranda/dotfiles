#!/bin/bash

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 21.0.2-graal
sdk install ant
sdk install maven 3.8.8
sdk install mvnd 0.7.1
