#!/bin/bash

# NVM (Node + npm)
curl -so- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# nvm install node # Needs to be executed manually
mkdir -p ~/.config/configstore
sudo chown -R $(whoami) ~/.config/configstore

# Load NVM and install node and npm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

nvm install node
