#!/bin/bash

case $BLOCK_BUTTON in
    1) gnome-terminal -- /bin/bash -c 'sudo apt-get update && sudo apt-get upgrade' 1>/dev/null ;;
    3) notify-send "$(apt list --upgradable 2>/dev/null | perl -lane 'if (/(^.+)\//g) {print $1}')" ;;
esac

sudo apt-get update 1>/dev/null
packages_count="$(apt list --upgradable 2>/dev/null | ag '^.+\/' | wc -l)"
if [[ "$packages_count" -eq "0" ]]; then
    echo ""
else
    echo "📦 $packages_count"
fi

exit 0
