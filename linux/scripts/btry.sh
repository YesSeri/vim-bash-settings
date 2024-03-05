#!/bin/bash

# Define the device name, default is usually 'battery_BAT0'
DEVICE_NAME='battery_BAT0'

# Define the path to the UPower device
PATH_PREFIX='/org/freedesktop/UPower/devices'
DEVICE_PATH="$PATH_PREFIX/$DEVICE_NAME"

# Gather information about the battery device
INFORMATION=$(upower -i "$DEVICE_PATH"  2> /dev/null)

# Extract the battery percentage
PERCENTAGE=$(awk '/percentage/ {print $NF}' <<< $INFORMATION)

# Print the battery percentage
echo "Battery Level: $PERCENTAGE%"
