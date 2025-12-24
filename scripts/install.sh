#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. "${CURRENT_DIR}/utils/path.sh"
. "${CURRENT_DIR}/utils/ui.sh"

echo "$(date)" > "$LOG_FILE"
echo "======================================" >> "$LOG_FILE"
echo "Dotfiles Installation Log" >> "$LOG_FILE"
echo "======================================" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

sudo -v

br
if [[ "$GUM_AVAILABLE" == "true" ]]; then
    gum style --foreground "$CYAN" --faint "📝 Logs → $LOG_FILE"
else
    info "Logs: $LOG_FILE"
fi
br

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${unameOut}" && exit 1
esac

if [[ $machine == "Mac" ]]; then
    info ">> Installing dependencies for current user ..."
    bash "${DOTFILES_PATH}/box/macos/dependencies.sh" >> "$LOG_FILE" 2>&1
elif [[ $machine == "Linux" ]]; then
    info ">> Installing dependencies for current user ..."
    bash "${CURRENT_DIR}/dependencies.sh" >> "$LOG_FILE" 2>&1
fi

# Re-source ui.sh to pick up gum if it was just installed
. "${CURRENT_DIR}/utils/ui.sh"

bash "${CURRENT_DIR}/reveal-secrets.sh" -f
br

banner ">>> Welcome to cmiranda's dotfiles <<<"
br
info_1 " Author       :" " Cristian Miranda | @crist_miranda"
info_1 " Version      :" " $(cd "${DOTFILES_PATH}"; git describe --abbrev=7 --always --long master)"
br

# Sync dotfiles
ask_caution "Sync dotfiles now?" SYNC_BOX
if [[ $SYNC_BOX =~ y|Y ]]; then
    info ">> Syncing dotfiles..."
    bash "${CURRENT_DIR}/sync.sh"
    success ">> Dotfiles synced!"
fi

# Box selection (stop after first selection - typically only one platform)
available_boxes=($(ls "${DOTFILES_PATH}/box"))
install_box=()
for box in "${available_boxes[@]}"; do
    ask "Setup ${box}?" response
    if [[ $response =~ y|Y ]]; then
        install_box+=("$box")
        break
    fi
done
export install_box

# Installation options (only ask if a box was selected)
if [[ ${#install_box[@]} -gt 0 ]]; then
    ask "Install packages?" INSTALL_PACKAGES && export INSTALL_PACKAGES
    ask "Install extra programs?" INSTALL_PROGRAMS && export INSTALL_PROGRAMS
    ask "Install work stuff?" INSTALL_WORK && export INSTALL_WORK
    ask "Apply config?" APPLY_CONFIG && export APPLY_CONFIG
fi

# Summary
br
if [[ "$GUM_AVAILABLE" == "true" ]]; then
    boxes_list="${install_box[*]:-none}"
    gum style \
        --border double \
        --border-foreground "$BLUE" \
        --padding "1 2" \
        --width 50 \
        "$(gum style --foreground "$BLUE" --bold "Installation Summary")" \
        "" \
        "  Boxes     : ${boxes_list}" \
        "  Packages  : ${INSTALL_PACKAGES:-n}" \
        "  Programs  : ${INSTALL_PROGRAMS:-n}" \
        "  Work      : ${INSTALL_WORK:-n}" \
        "  Config    : ${APPLY_CONFIG:-n}"
else
    info_1 "  Boxes     :" " ${install_box[*]:-none}"
    info_1 "  Packages  :" " ${INSTALL_PACKAGES:-n}"
    info_1 "  Programs  :" " ${INSTALL_PROGRAMS:-n}"
    info_1 "  Work      :" " ${INSTALL_WORK:-n}"
    info_1 "  Config    :" " ${APPLY_CONFIG:-n}"
fi
br

ask_caution "Shall we proceed?" CONTINUE

if [[ $CONTINUE =~ y|Y ]]; then
    br
    banner ">>> Installing <<<"

    for box in "${install_box[@]}"; do
        br
        box_header "$box"
        br
        bash "${DOTFILES_PATH}/box/$box/setup.sh" 2>&1 | while IFS= read -r line; do
            if [[ "$GUM_AVAILABLE" == "true" ]]; then
                gum log --level info "$line"
            else
                echo "$line"
            fi
        done
    done

    br
    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        success "Installation complete!"
        gum style --foreground "$CYAN" --faint "Check $LOG_FILE for detailed output"
    else
        figlet "> Done!" | lolcat 2>/dev/null || info ">>> Done! <<<"
    fi
    br

    ask "Do you want to change the default shell to zsh?" CHANGE_SHELL_TO_ZSH
    if [[ $CHANGE_SHELL_TO_ZSH =~ y|Y ]]; then
        info "Changing default shell to zsh..."
        if chsh -s "$(which zsh)"; then
            success "Shell changed to zsh! Restart your terminal to use it."
        else
            warning "Shell change failed or was cancelled."
        fi
    fi
else
    br
    if [[ "$GUM_AVAILABLE" == "true" ]]; then
        gum style \
            --border double \
            --border-foreground "$RED" \
            --foreground "$RED" \
            --bold \
            --padding "1 4" \
            --width 50 \
            --align center \
            "INSTALLATION ABORTED"
    else
        banner ">>> Aborted <<<"
    fi
    br
    exit 0
fi
