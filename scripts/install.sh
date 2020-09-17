#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. ${CURRENT_DIR}/utils/path.sh
. ${CURRENT_DIR}/utils/ui.sh

echo `date` > $LOG_FILE 
sudo -v

br
separator 57
br

info ">> Installing dependencies for current user and root ..."
bash ${CURRENT_DIR}/dependencies.sh >> $LOG_FILE 2>&1
sudo bash ${CURRENT_DIR}/dependencies.sh >> $LOG_FILE 2>&1

br
info ">> Revealing secrets ..."
bash ${CURRENT_DIR}/secrets.sh

br
banner ">>> Welcome to cmiranda's dotfiles <<<"
br
info_1 " Author       :" " Cristian Miranda | @crist_miranda"
info_1 " Version      :" " $(cd ${DOTFILES_PATH}; git describe --abbrev=7 --always --long master)"
br
separator 57
br

#
# Sync box
#
br
ask_caution "Sync dotfiles now?" SYNC_BOX
br
if [[ $SYNC_BOX =~ y|Y ]]; then
    bash ${CURRENT_DIR}/sync.sh
fi
br

declare -A install_box=()
for box in $(ls ${DOTFILES_PATH}/box); do
	ask "Setup ${box}?" install_box[$box]
done;
export install_box

br
ask "Install packages?" INSTALL_PACKAGES && export INSTALL_PACKAGES
ask "Install extra programs?" INSTALL_PROGRAMS && export INSTALL_PROGRAMS
ask "Install work stuff?" INSTALL_WORK && export INSTALL_WORK
ask "Apply config?" APPLY_CONFIG && export APPLY_CONFIG
br
ask_caution "Shall we proceed?" CONTINUE
br

if [[ $CONTINUE =~ y|Y ]];
then

    banner "           >>> Continue <<<           "
    br

    for box in $(ls ${DOTFILES_PATH}/box); do
        if [[ ${install_box[$box]} =~ n|N ]]; then
            br
            warning ">>> Skipping box: ${box}..."
            br
        else
            br
            figlet "> ${box} <" | lolcat
            br
            bash ${DOTFILES_PATH}/box/$box/setup.sh
        fi
    done;

    # This is now handled by Duplicati 

    # separator 57
    # br
    # ask "Do you want to restore some data for this box?" RESTORE_DATA_FOR_BOX
    # if [[ $RESTORE_DATA_FOR_BOX =~ y|Y ]];
    # then
    #     ask_2 "Type the box to be restored: [linux/server/rpi]" RESTORE_BOX && export RESTORE_BOX
    #     sudo $HOME/bin/backuper --restore $RESTORE_BOX
    # fi
    # br

    separator 57
    br
    figlet "> Done!" | lolcat
    br
    separator 57
    br

    ask "Do you want to change the default shell to zsh?" CHANGE_SHELL_TO_ZSH
    if [[ $CHANGE_SHELL_TO_ZSH =~ y|Y ]];
    then
        info "Changing default shell to /usr/bin/zsh ..."
        chsh -s $(which zsh)
        zsh
    fi
    
else

    banner "            >>> Aborted <<<           "
    exit 0

fi
