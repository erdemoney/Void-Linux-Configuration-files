#!/bin/bash

### Config ###
notification_interval=1000
check_interval=5
low_battery_threshold=25
hibernate_percentage=5
battery_icon="/usr/share/icons/Paper/48x48/notifications/notification-battery-low.svg"

function notify {
    battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)
    if [ "$battery_percentage" -lt "$hibernate_percentage" ]; then
        echo "dead"
        #sudo ZZZ # must have ZZZ as NOPASSWD in sudoers file
    fi
    if [ "$battery_percentage" -le "$1" ]; then
        dunstify -t 2000 -i $battery_icon -r 7777 -u critical "Battery is low" "only $battery_percentage% left"
        sleep "$notification_interval"
    fi
}

while true
do
    if [ "$(cat /sys/class/power_supply/BAT0/status | grep -o Discharging)" == "Discharging" ];
        then
        notify $low_battery_threshold
        sleep "$check_interval"
    fi
sleep 5s
done
