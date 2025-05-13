#!/bin/bash

i3-msg "workspace number $(echo {1..20} | tr ' ' '\n' | grep -vxFf <(i3-msg -t get_workspaces | jq '.[].num' | tr ' ' '\n') | head -n 1); move workspace to output $(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).output')"
