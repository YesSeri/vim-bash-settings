# eval "$(starship init bash)"
#
# one monitor
alias monitor1='xrandr --output "DP-2" --primary --output "HDMI-0" --off'
# setup extend monitor
alias monitor2extend='xrandr --output "DP-2" --mode 1920x1080 --primary --output "HDMI-0" --mode 1920x1080 --left-of "DP-2"'
# setup mirror monitor
alias monitor2mirror='xrandr --output "DP-2" --mode 1920x1080 --primary --output "HDMI-0" --mode 1920x1080 --same-as "DP-2"'
