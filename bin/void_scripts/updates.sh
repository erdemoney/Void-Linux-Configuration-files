#! /bin/bash

update_icon=/usr/share/icons/Paper/48x48/status/software-update-available.png

swupdates=$(xbps-install -nSu | wc -l)
if [ $swupdates -ne 0 ]; then
    dunstify -t 2000 -i $update_icon -r 4444 -u normal "Updates available" "$swupdates system updates available"
fi

fwupdmgr refresh
fwupdmgr get-updates &> /tmp/fwupd.log
fwupdates=$(grep -v "latest available firmware version" /tmp/fwupd.log |grep -v "no available firmware updates" |wc -l)
if [ $fwupdates -ne 0 ]; then
    dunstify -t 2000 -i $update_icon -r 3333 -u normal "Updates available" "$update firmware updates available"
fi
