#!/usr/bin/env bash
# ASUS on the left, Lenovo (primary) on the right.
# Without the ASUS, any other connected screen goes on the left.
. "$(dirname "$(readlink -f "$0")")/monitors-lib.sh"

main=$(main_monitor)
second=$(monitor_named "$SECOND")
[[ -z $second || $second == "$main" ]] && second=$(any_except "$main")

use "$main" 1920x1080 --primary
[[ -n $second ]] && use "$second" 1920x1080 --left-of "$main"
apply
