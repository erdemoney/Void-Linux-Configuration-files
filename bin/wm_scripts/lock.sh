#! /bin/bash
if [ $(grep -r "RUNNING" /proc/asound | wc -l) -eq 0 ]; then
	betterlockscreen -l
fi
