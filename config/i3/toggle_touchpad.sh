#!/bin/bash
# Toggle touchpad status
# Using libinput and xinput

# Use xinput list and do a search for touchpads. Then get the first one and get its name.
device="Synaptics TM3289-021"

# If it was activated disable it and if it wasn't disable it
[[ "$(xinput list-props "$device" | grep -P ".*Device Enabled.*\K.(?=$)" -o)" == "1" ]] &&
    xinput disable "$device" ||
    xinput enable "$device"
