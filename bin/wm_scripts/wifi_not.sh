#!/bin/bash

wifi_icon=/usr/share/icons/Paper/48x48/notifications/nm-device-wireless.svg
connected=0
while true
do
    message=$(nmcli -g ifname |grep "wlp2s0: connected")
    if [ $connected -eq 0 ] && [ -n "$message" ]; then
        dunstify -t 2000 -i $wifi_icon -r 6666 -u normal "Wifi Connected" "$message"
        connected=1
    #elif [ $message -eq "" ]; then
    #    connected=0
    fi
    sleep 5s
done
