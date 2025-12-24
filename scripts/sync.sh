#!/usr/bin/env bash

set -e

# Locations
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="../home"
DOTBOT_DIR="../dotbot"
DOTBOT_BIN="bin/dotbot"

# Source UI functions
. "${BASEDIR}/utils/ui.sh" 2>/dev/null || true

# Clone or update dotbot (silently)
if ! [ -d "${BASEDIR}/${DOTBOT_DIR}" ]; then
    git clone git@github.com:anishathalye/dotbot.git "${BASEDIR}/${DOTBOT_DIR}" 2>/dev/null || {
        wget -qO dotbot.zip https://github.com/anishathalye/dotbot/archive/refs/heads/master.zip
        unzip -q dotbot.zip
        mv dotbot-master "${BASEDIR}/${DOTBOT_DIR}"
        rm dotbot.zip
    }
else
    git -C "${BASEDIR}/${DOTBOT_DIR}" pull --quiet 2>/dev/null || true
fi

# Detect machine type
unameOut="$(uname -a)"
MACHINE_TYPE="anonymous"
if [[ "$unameOut" =~ "mini-linux" ]] || [[ "$unameOut" =~ "devbox" ]]; then
    MACHINE_TYPE="server"
elif [[ "$unameOut" =~ "Linux" ]]; then
    MACHINE_TYPE="linux"
elif [[ "$unameOut" =~ "Darwin" ]]; then
    MACHINE_TYPE="macos"
fi

CONFIG_FILE="dotbot.${MACHINE_TYPE}.conf.yaml"
if ! [ -f "${BASEDIR}/$CONFIG_HOME/$CONFIG_FILE" ]; then
    error "ERROR: $CONFIG_FILE does not exist. Aborting sync."
    exit 1
fi

cd "${BASEDIR}"

# Use venv Python if available
PYTHON_BIN="python3"
if [ -f "$HOME/venv/bin/python3" ]; then
    PYTHON_BIN="$HOME/venv/bin/python3"
fi

# Run dotbot
cd "${CONFIG_HOME}"

# Counters
LINKED=0
CREATED=0
REMOVED=0
SKIPPED=0

if [[ "$GUM_AVAILABLE" == "true" ]]; then
    br
    gum style \
        --border double \
        --border-foreground "$BLUE" \
        --padding "0 2" \
        --width 50 \
        --align center \
        --foreground "$BLUE" \
        --bold \
        "DOTFILES SYNC"
    br
    gum style --foreground "$CYAN" --faint "  Machine: $MACHINE_TYPE | Config: $CONFIG_FILE"
    br

    "$PYTHON_BIN" "${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -c "${CONFIG_FILE}" "${@}" 2>&1 | while IFS= read -r line; do
        # Skip noisy lines
        [[ "$line" =~ "antidote:" ]] && continue
        [[ "$line" =~ "Updating bundles" ]] && continue
        [[ "$line" =~ "Waiting for bundle" ]] && continue
        [[ "$line" =~ "Bundle" ]] && continue
        [[ "$line" =~ "fatal:" ]] && continue
        [[ "$line" =~ "Updating antidote" ]] && continue
        [[ "$line" =~ "self-update" ]] && continue
        [[ "$line" =~ "antidote version" ]] && continue
        [[ -z "$line" ]] && continue

        # Style dotbot output
        if [[ "$line" =~ "Creating symlink" ]]; then
            # Extract just the target path
            path=$(echo "$line" | sed 's/.*Creating symlink //' | cut -d' ' -f1)
            gum style --foreground "$GREEN" "  ✓ $path"
        elif [[ "$line" =~ ^Linking ]]; then
            gum style --foreground "$GREEN" "  ✓ $line"
        elif [[ "$line" =~ ^Removing ]]; then
            path=$(echo "$line" | sed 's/Removing //')
            gum style --foreground "$YELLOW" "  ○ $path"
        elif [[ "$line" =~ ^Creating ]] && [[ ! "$line" =~ "symlink" ]]; then
            gum style --foreground "$BLUE" "  + $line"
        elif [[ "$line" =~ ^Cleaning ]]; then
            gum style --foreground "$YELLOW" "  ~ $line"
        elif [[ "$line" =~ "Already linked" ]] || [[ "$line" =~ "exists" ]]; then
            gum style --foreground "$CYAN" --faint "  · $line"
        elif [[ "$line" =~ ^All ]]; then
            br
            gum style \
                --border rounded \
                --border-foreground "$GREEN" \
                --foreground "$GREEN" \
                --padding "0 2" \
                --width 50 \
                "✓ $line"
        elif [[ "$line" =~ "Not linking" ]] || [[ "$line" =~ "Skipping" ]]; then
            gum style --foreground "$YELLOW" --faint "  ⊘ $line"
        else
            gum style --faint "  $line"
        fi
    done

    br
else
    "$PYTHON_BIN" "${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -c "${CONFIG_FILE}" "${@}"
fi

exit 0
