#!/bin/bash

case $BLOCK_BUTTON in
    2) echo "" ;;
esac

/home/dmazuruk/tools/curlfire/curlfire -s 'https://github.com/pulls/review-requested' > /tmp/github

requests_count=$(grep -Pzo "\\d+\\sOpen" /tmp/github | grep -Pzo -m 1 "\\d+" | tr '\0' '\n')

if [[ -z "$requests_count" ]]; then
  requests_count="0"
fi

if [[ "$requests_count" -eq "0" ]]; then
    echo ""
else
    current_day=$(date +"%u")
    current_hour=$(date +"%H")
    if [[ "$current_day" -gt "5" ]] || [[ "${current_hour#0}" -gt "18" ]]; then
        echo ""
    else
        echo "🐱 $requests_count"
    fi
fi

exit 0
