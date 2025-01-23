#!/bin/bash

PRIMARY_MONITOR=$(xrandr --query | grep " connected" | grep "DP-" | awk '{print $1}' | head -n 1)
SECONDARY_MONITOR="HDMI-0"

if [ -z "$PRIMARY_MONITOR" ]; then
    echo "No DisplayPort monitor found. Exiting."
    exit 1
fi

xrandr --output "$SECONDARY_MONITOR" --mode 1360x768 --pos 0x0 --rotate normal --output "$PRIMARY_MONITOR" --mode 1920x1080 --pos 1360x0 --rotate normal --left-of "$SECONDARY_MONITOR"
