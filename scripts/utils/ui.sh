#!/bin/bash

# Gum-based UI functions for dotfiles installer
# Falls back to basic ANSI colors if gum is not available

# Check if gum is available
if command -v gum &> /dev/null; then
    GUM_AVAILABLE=true
else
    GUM_AVAILABLE=false
fi

# Colors (ANSI 256 for gum, ANSI escape codes for fallback)
export BLUE="39"
export CYAN="51"
export YELLOW="226"
export RED="196"
export GREEN="82"

# Fallback ANSI escape codes
export ANSI_BLUE='\e[34m'
export ANSI_CYAN='\033[0;36m'
export ANSI_YELLOW='\e[33m'
export ANSI_RED='\033[0;31m'
export ANSI_GREEN='\033[0;32m'
export ANSI_BOLD='\e[1m'
export ANSI_NC='\033[0m'
export ANSI_BG_BLUE='\e[104m'
export ANSI_BLACK='\e[30m'

# Banner with double border
banner() {
    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        gum style \
            --border double \
            --border-foreground "$BLUE" \
            --padding "1 4" \
            --width 50 \
            --align center \
            --foreground "$BLUE" \
            --bold \
            "$1"
    else
        local string="         $1          "
        local separator=""
        for (( c=1; c<=${#string}; c++ )); do
            separator+=" "
        done
        echo -e "${ANSI_BG_BLUE}${ANSI_BLACK}${separator}${ANSI_NC}"
        echo -e "${ANSI_BG_BLUE}${ANSI_BLACK}${string}${ANSI_NC}"
        echo -e "${ANSI_BG_BLUE}${ANSI_BLACK}${separator}${ANSI_NC}"
    fi
}

# Horizontal separator
separator() {
    local width=${1:-57}
    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        gum style --width "$width" --background "$BLUE" " "
    else
        local sep=""
        for (( c=1; c<=$width; c++ )); do
            sep+=" "
        done
        echo -e "${ANSI_BG_BLUE}${ANSI_BLACK}${sep}${ANSI_NC}"
    fi
}

# Info message (blue)
info() {
    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        gum log --level info "$1"
    else
        echo -e "${ANSI_BLUE}${1}${ANSI_NC}"
    fi
}

# Info with label (cyan bold + value)
info_1() {
    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        echo "$(gum style --foreground "$CYAN" --bold "$1")$2"
    else
        echo -e "${ANSI_CYAN}${ANSI_BOLD}${1}${ANSI_NC}${2}"
    fi
}

# Warning message (yellow)
warning() {
    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        gum log --level warn "$1"
    else
        echo -e "${ANSI_YELLOW}${1}${ANSI_NC}"
    fi
}

# Error message (red)
error() {
    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        gum log --level error "$1"
    else
        echo -e "${ANSI_RED}${1}${ANSI_NC}"
    fi
}

# Success message (green with checkmark)
success() {
    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        gum style --foreground "$GREEN" --bold "✓ $1"
    else
        echo -e "${ANSI_GREEN}${ANSI_BOLD}✓ ${1}${ANSI_NC}"
    fi
}

# Blank line
br() {
    echo ""
}

# Yes/No confirmation prompt
ask() {
    local prompt="$1"
    local var_name="$2"

    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        if gum confirm --prompt.foreground="$CYAN" "$prompt"; then
            eval "$var_name=y"
        else
            eval "$var_name=n"
        fi
    else
        echo -ne "${ANSI_CYAN} >> $prompt [y/n]: ${ANSI_NC}"
        read -r "$var_name"
    fi
}

# Free text input prompt
ask_2() {
    local prompt="$1"
    local var_name="$2"

    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        local result
        result=$(gum input --prompt.foreground="$CYAN" --placeholder "$prompt")
        eval "$var_name=\"$result\""
    else
        echo -ne "${ANSI_CYAN} >> $prompt: ${ANSI_NC}"
        read -r "$var_name"
    fi
}

# Caution confirmation prompt (red)
ask_caution() {
    local prompt="$1"
    local var_name="$2"

    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        if gum confirm --prompt.foreground="$RED" "$prompt"; then
            eval "$var_name=y"
        else
            eval "$var_name=n"
        fi
    else
        echo -ne "${ANSI_RED} >> $prompt [y/n]: ${ANSI_NC}"
        read -r "$var_name"
    fi
}

# Multi-select from options (returns selected items, one per line)
select_boxes() {
    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        gum choose --no-limit --cursor.foreground="$CYAN" --selected.foreground="$GREEN" "$@"
    else
        # Fallback: ask for each option
        local selected=()
        for opt in "$@"; do
            ask "Setup ${opt}?" response
            if [[ $response =~ y|Y ]]; then
                selected+=("$opt")
            fi
        done
        printf '%s\n' "${selected[@]}"
    fi
}

# Single select from options
select_one() {
    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        gum choose --cursor.foreground="$CYAN" "$@"
    else
        # Fallback: simple select
        PS3="Select an option: "
        select opt in "$@"; do
            echo "$opt"
            break
        done
    fi
}

# Spinner wrapper for long operations
with_spinner() {
    local title="$1"
    shift

    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        gum spin --spinner dot --title "$title" --spinner.foreground="$BLUE" -- "$@"
    else
        echo -e "${ANSI_BLUE}${title}${ANSI_NC}"
        "$@"
    fi
}

# Box header (for section titles)
box_header() {
    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        gum style \
            --border rounded \
            --border-foreground "$CYAN" \
            --padding "0 2" \
            --foreground "$CYAN" \
            --bold \
            "> $1 <"
    else
        figlet "> ${1} <" | lolcat 2>/dev/null || echo -e "${ANSI_CYAN}${ANSI_BOLD}>>> ${1} <<<${ANSI_NC}"
    fi
}

# Styled text output
styled() {
    local color="$1"
    shift
    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        gum style --foreground "$color" "$@"
    else
        echo "$@"
    fi
}
