#!/bin/bash

# Get the active outputs (screens) and store them in an array
readarray -t active_outputs < <(i3-msg -t get_outputs | jq -r 'map(select(.active == true) | .name)')

# Find a workspace that is not displayed on any screen
unused_workspace=$(echo {1..20} | tr ' ' '\n' | grep -vxFf <(i3-msg -t get_workspaces | jq -r '.[].num' | tr ' ' '\n') | head -n 1)

# Apply the workspace change to each screen
for output in "${active_outputs[@]}"
do
    # Skip empty or invalid entries
    if [[ -z "$output" || "$output" == "[" || "$output" == "]" ]]; then
        continue
    fi

    # Calculate the workspace number for this screen
    workspace_to_switch=$((unused_workspace++))

    # Uncomment to enable actual workspace switching
    i3-msg "focus output $output" && i3-msg "workspace number $workspace_to_switch"
done
