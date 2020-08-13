#!/bin/bash

# Saving layout
# ➜ i3-save-tree --workspace 1 > ~/.config/i3/layouts/workspace-1.json
#
# Restoring layout
#➜ i3-msg "workspace 4; append_layout  ~/.config/i3/layouts/workspace-4.json"

MONITORS=`xrandr --listmonitors | grep "+" | wc -l`

# Move to workspace
i3-msg "workspace number $1"

if [[ $1 -eq 1 ]]; then
    i3-msg 'append_layout ~/.config/i3/layouts/mail.json'
    thunderbird &
    terminator --command 'htop; bash'
fi

if [[ $1 -eq 2 ]]; then
    firefox &
fi

if [[ $1 -eq 3 ]]; then
    /usr/local/firefox_dev/firefox &
fi

if [[ $1 -eq 4 ]]; then
    intellij-idea-ultimate &
fi

if [[ $1 -eq 5 ]]; then
    if [[ "$MONITORS" == "2" ]]; then
        i3-msg 'append_layout ~/.config/i3/layouts/dual/msg.json'
        riot-web &
        telegram-desktop &
        walc &
        #discord &
    else
        i3-msg 'append_layout ~/.config/i3/layouts/personal_msg.json'
        telegram-desktop &
        walc &
    fi
fi

if [[ $1 -eq 6 ]]; then
    i3-msg 'append_layout ~/.config/i3/layouts/work_msg.json'
    riot-web &
    discord &
fi

if [[ $1 -eq 7 ]]; then
    spotify &
fi
