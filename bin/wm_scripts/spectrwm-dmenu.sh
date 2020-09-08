#!/bin/bash

# this script is in the path such that the native iconify feature of spectrwm
# (which is hard-coded to use dmenu) will use this script instead to run rofi, filter out
# all scrachpad apps (denoted by window titles starting with "__") and remove the id from
# the end of windows titles in the uniconify menu (i.e. Firefox.23456 -> Firefox)

# TODO 
# - truncate long names
# - dont show when empty
#
# caveats
# - breaks change WS name

grep -v "^__" | \
sed -e 's/\.[0-9]\+//' | \
rofi -dmenu -config "~/.config/rofi/spectrwm_uniconify.rasi" 
