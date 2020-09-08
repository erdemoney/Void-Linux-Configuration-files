#!/bin/bash

lock="󰌾	lock"
logout="󰍃	logout"
suspend="󰏤	suspend"
hibernate="󰤄	hibernate"
reboot="󰦛	reboot"
shutdown="󰤆	shutdown"

options="$lock\n$logout\n$suspend\n$hibernate\n$reboot\n$shutdown"
selected=$(echo -e "$options"| rofi -config "~/.config/rofi/powerprompt.rasi" -dmenu -p "choose action")

case $selected in
    $lock)
        $LOCKER
    ;;
    $logout)

    ;;
    $suspend)
        sudo zzz
    ;;
    $hibernate)
        sudo ZZZ
    ;;
    $reboot)
        sudo reboot
    ;;
    $shutdown)
        sudo poweroff
    ;;
esac
