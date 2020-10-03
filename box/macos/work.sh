#!/bin/bash

. ${UTILS_PATH}/ui.sh

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ $INSTALL_WORK =~ n|N ]];
then
    warning ">>> Skipping work stuff..."
    exit 0
fi

br
info ">> Cloning repositories..."
br

info ">> Personal..."
WORKSPACE=$HOME/Documents/Work/Workspace
if [ ! -d $WORKSPACE/dikter-utils ]; 				then echo -e "${RED} >> personal/dikter-utils...${NC}" && git clone git@github.com:cristianmiranda/dikter-utils.git $WORKSPACE/dikter-utils; fi
br

info ">> Lille Group..."
WORKSPACE=$HOME/Documents/Work/Workspace_LG
if [ ! -d $WORKSPACE/escribehost ]; 				then echo -e "${RED}>> lg/escribehost...${NC}" && git clone git@github.com:lillegroup/escribehost.git $WORKSPACE/escribehost; fi
if [ ! -d $WORKSPACE/appointment-reminders ]; 	    then echo -e "${RED}>> lg/appointment-reminders...${NC}" && git clone git@github.com:lillegroup/appointment-reminders.git $WORKSPACE/appointment-reminders; fi
if [ ! -d $WORKSPACE/datadictionary ]; 			    then echo -e "${RED}>> lg/datadictionary...${NC}" && git clone git@github.com:lillegroup/datadictionary.git $WORKSPACE/datadictionary; fi
if [ ! -d $WORKSPACE/jenkins-admin ]; 			    then echo -e "${RED}>> lg/jenkins-admin...${NC}" && git clone git@github.com:lillegroup/jenkins-admin.git $WORKSPACE/jenkins-admin; fi
if [ ! -d $WORKSPACE/publisher ]; 				    then echo -e "${RED}>> lg/publisher...${NC}" && git clone git@github.com:lillegroup/publisher.git $WORKSPACE/publisher; fi
if [ ! -d $WORKSPACE/escribe-scan-upload ]; 		then echo -e "${RED}>> lg/escribe-scan-upload...${NC}" && git clone git@github.com:lillegroup/escribe-scan-upload.git $WORKSPACE/escribe-scan-upload; fi
