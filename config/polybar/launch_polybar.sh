#!/usr/bin/env sh

# Terminate already running bar instances
pkill -9 polybar

#launch bar
echo "---" | tee -a /tmp/polybar.log
polybar main >>/tmp/polybar.log 2>&1 &

echo "bar launched"
