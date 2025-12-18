#!/bin/bash

if ! command -v claude &> /dev/null; then
    curl -fsSL https://claude.ai/install.sh | bash
else
    echo "claude already installed"
fi
