#!/bin/sh
case $BLOCK_BUTTON in
    3) notify-send "$(nordvpn status)"
esac

connection=$(nordvpn status | awk 'Status":" {status=$2} END{if(status=="Disconnected") {printf("%s", "LG")} else {printf("%s", "NordVPN")}}')
nmcli -t connection show --active | awk -v con="$connection" -F ':' '
/tun[:digit:]/{vpn="VPN"} /vpn/{name=$1}
END{if(vpn) { printf("<span color=\"%s\">%s %s</span>", "#00FF00", vpn, "(" con ")") } else { printf("<span color=\"%s\">%s</span>", "#FF0000", "VPN") }}'
