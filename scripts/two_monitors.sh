#!/usr/bin/env bash
# Lenovo (primary) on the left, ASUS on the right.
# Without the ASUS, any other connected screen goes on the right.
. "$(dirname "$(readlink -f "$0")")/monitors-lib.sh"

main=$(main_monitor)
second=$(monitor_named "$SECOND")
[[ -z $second || $second == "$main" ]] && second=$(any_except "$main")

use "$main" 1920x1080 --primary
[[ -n $second ]] && use "$second" 1920x1080 --right-of "$main"
apply
