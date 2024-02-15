#!/usr/bin/env bash
pow=`sudo cat /sys/class/power_supply/BAT0/power_now`
max=`sudo cat /sys/class/power_supply/BAT0/energy_full`
echo $pow
echo $max
echo "Battery: $((($pow * 1000) / $max)) / 1000"
