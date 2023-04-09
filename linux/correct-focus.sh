#!/bin/bash
#
# Notification that asks if I am focusing on correct thing
# Only runs while isStudying is true
#
# Use this to make notify-send visible when running from crontab.
# * * * * * XDG_RUNTIME_DIR=/run/user/$(id -u) /home/henrik/programming/docs/productivity/correct-focus.sh

XDG_RUNTIME_DIR=/run/user/$(id -u)
source /home/henrik/.bashrc


if [[ isStudying -eq 0 ]]; then
	echo "O:$(pwd) notify-send:  $(date)" >> /home/henrik/programming/docs/productivity/script.log
	notify-send --urgency critical --icon info "Mindful. Present. Now." \
		"Låt dig inte distraheras min vän.\
		\rLivet är kort.\
		\rTa vara på din tid, din familj och allt annat."

else
	echo "X:$(pwd) not-studying: $(date)" >> /home/henrik/programming/docs/productivity/script.log
fi

