PRIMARY_MONITOR=$(xrandr --query | grep " connected" | grep "DP-" | awk '{print $1}' | head -n 1)
SECONDARY_MONITOR="HDMI-0"

if [ -z "$PRIMARY_MONITOR" ]; then
    echo "No DisplayPort monitor found. Exiting."
    exit 1
fi

xrandr --output "$SECONDARY_MONITOR" --off --output "$PRIMARY_MONITOR" --mode 1920x1080 --primary

