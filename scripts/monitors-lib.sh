#!/usr/bin/env bash
# monitors-lib.sh: shared code for the monitor layout scripts.
#
# Monitors are found by the model name stored in the monitor itself (its EDID),
# not by port, so moving a cable from HDMI-0 to DP-4 doesn't break anything.
# A mode a monitor lacks falls back to its preferred mode, at the fastest rate.
#
# Every script takes:  -n, --dry-run   print the xrandr command instead of running it
#                      -l, --list      show connected monitors and their names

# Part of the monitor names (any case; see --list). Override in the environment.
MAIN=${MAIN:-T24i}        # Lenovo T24i-30: primary, on the left
SECOND=${SECOND:-VG249}   # ASUS VG249Q1A: on the right
TV=${TV:-}                # empty: the TV is any screen that is neither of the above

die() { echo "$(basename "$0"): $*" >&2; exit 1; }

# Monitor name from an EDID hex dump. It sits in one of four 18-byte
# descriptors (at byte 54, 72, 90, 108) that start with 000000fc00.
edid_name() {
    local hex=$1 i
    for i in 54 72 90 108; do
        if [[ ${hex:i*2:10} == 000000fc00 ]]; then
            xxd -r -p <<<"${hex:i*2+10:26}" | head -n 1
            return
        fi
    done
}

# --- What is connected ---------------------------------------------------
QUERY=$(xrandr --query) || die "xrandr failed (is DISPLAY set?)"
ALL=()                # every output, e.g. (DP-0 DP-1 HDMI-0 ...)
CONNECTED=()          # outputs with a monitor, e.g. (DP-0 DP-4)
declare -A NAME=()    # output -> monitor name, e.g. [DP-4]="ASUS VG249Q1A"

reading_edid=0
while IFS= read -r line; do
    if [[ $line =~ ^([^[:space:]]+)\ (dis)?connected ]]; then
        out=${BASH_REMATCH[1]}
        ALL+=("$out")
        [[ -z ${BASH_REMATCH[2]} ]] && CONNECTED+=("$out")
    elif [[ $line == *EDID:* ]]; then
        reading_edid=1 hex=""
    elif ((reading_edid)) && [[ $line =~ ^[[:space:]]+([0-9a-f]+)$ ]]; then
        hex+=${BASH_REMATCH[1]}
    elif ((reading_edid)); then
        reading_edid=0
        NAME[$out]=$(edid_name "$hex")
    fi
done < <(xrandr --verbose)

((${#CONNECTED[@]})) || die "no monitors connected"

# --- Finding monitors ----------------------------------------------------
# monitor_named TEXT: connected output whose monitor name contains TEXT.
monitor_named() {
    local o
    [[ -n $1 ]] || return 0
    for o in "${CONNECTED[@]}"; do
        [[ ${NAME[$o],,} == *"${1,,}"* ]] && { echo "$o"; return; }
    done
}

# main_monitor: the MAIN monitor, or else the first connected one.
main_monitor() {
    local o
    o=$(monitor_named "$MAIN")
    echo "${o:-${CONNECTED[0]}}"
}

# any_except OUTPUT...: first connected output not in the list.
any_except() {
    local o
    for o in "${CONNECTED[@]}"; do
        [[ " $* " == *" $o "* ]] || { echo "$o"; return; }
    done
}

# --- Modes ---------------------------------------------------------------
# rates OUTPUT MODE: refresh rates OUTPUT offers for MODE, fastest first.
rates() {
    awk -v o="$1" -v m="$2" '
        /^[^ ]/ { output = $1 }
        output == o && $1 == m { for (i = 2; i <= NF; i++) if ($i + 0 > 0) print $i + 0 }
    ' <<<"$QUERY" | sort -rn
}

# preferred_mode OUTPUT: the mode xrandr marks with "+".
preferred_mode() {
    awk -v o="$1" '/^[^ ]/ { output = $1 } output == o && $1 != o && /\+/ { print $1; exit }' <<<"$QUERY"
}

# --- Building the layout -------------------------------------------------
ON=()     # outputs to turn on
ARGS=()   # xrandr arguments for them

# use OUTPUT MODE [XRANDR ARGS...]: turn OUTPUT on at MODE, or at its preferred
# mode if it doesn't have MODE.
use() {
    local out=$1 mode=$2
    shift 2
    [[ -n $(rates "$out" "$mode") ]] || mode=$(preferred_mode "$out")
    ON+=("$out")
    ARGS+=(--output "$out" --mode "$mode" --rate "$(rates "$out" "$mode" | head -n 1)" "$@")
}

# apply: turn every other output off and run xrandr (or print it with --dry-run).
apply() {
    local o cmd=(xrandr)
    for o in "${ALL[@]}"; do
        [[ " ${ON[*]} " == *" $o "* ]] || cmd+=(--output "$o" --off)
    done
    cmd+=("${ARGS[@]}")
    for o in "${ON[@]}"; do echo "on: $o (${NAME[$o]:-unknown})"; done
    if ((DRY_RUN)); then echo "${cmd[*]}"; else "${cmd[@]}"; fi
}

# --- Options -------------------------------------------------------------
DRY_RUN=0
case ${1:-} in
    "") ;;
    -n | --dry-run) DRY_RUN=1 ;;
    -l | --list)
        for o in "${CONNECTED[@]}"; do echo "$o: ${NAME[$o]:-unknown}"; done
        exit 0
        ;;
    *) die "usage: $(basename "$0") [-n|--dry-run] [-l|--list]" ;;
esac
