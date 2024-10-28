myuptime () {
	uptime | awk '{ print "Uptime:", $3, $4, $5 }' | sed 's/,//g'
}


alias volup="amixer sset Master 10%+"
alias voldown="amixer sset Master 10%-"
alias vol="amixer sset Master"

alias brightup="sudo brightnessctl set +10%"
alias brightdown="sudo brightnessctl  set 10%-"
alias bright="sudo brightnessctl set"
alias o="xdg-open"
alias x="exit"

alias nnn="nnn -e" 
alias ec="emacsclient -n"

mkcd() { mkdir -p "$1" && cd "$1"; }

history-no-lines() {
history|awk '{$1="";print substr($0,2)}'
}
alias pretty-path="echo $PATH | sed 's/\:/\n/g'"


#extract all archives!
extract () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)  tar xvjf $1 && cd $(basename "$1" .tar.bz2) ;;
			*.tar.gz)   tar xvzf $1 && cd $(basename "$1" .tar.gz) ;;
			*.tar.xz)   tar Jxvf $1 && cd $(basename "$1" .tar.xz) ;;
			*.bz2)      bunzip2 $1 && cd $(basename "$1" /bz2) ;;
			*.rar)      unrar x $1 && cd $(basename "$1" .rar) ;;
			*.gz)       gunzip $1 && cd $(basename "$1" .gz) ;;
			*.tar)      tar xvf $1 && cd $(basename "$1" .tar) ;;
			*.tbz2)     tar xvjf $1 && cd $(basename "$1" .tbz2) ;;
			*.tgz)      tar xvzf $1 && cd $(basename "$1" .tgz) ;;
			*.zip)      unzip $1 && cd $(basename "$1" .zip) ;;
			*.Z)        uncompress $1 && cd $(basename "$1" .Z) ;;
			*.7z)       7z x $1 && cd $(basename "$1" .7z) ;;
			*)      echo "don't know how to extract '$1'..." ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

# sort but keep order
sortKeepOrder () {
	awk '!x[$0]++'
}

Hlp () {
	CUSTOMCMD="$1 --help | bat --paging always"
	echo $CUSTOMCMD
	eval $CUSTOMCMD
}

Tldr () {
	CUSTOMCMD="tldr $1 | bat --paging always"
	echo $CUSTOMCMD
	eval $CUSTOMCMD
}

alias n="nvim"

function kssh ()
{
	if [[ "$TERM" == "xterm-kitty" ]]; then
		kitten ssh "$@" 
	else
		ssh "$@"
	fi
}
function fman() {
    man -k . | fzf -q "$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man | col -bx | bat -l man -p --color always' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}

function fv() {
	rg --color=always --line-number --no-heading --smart-case "${*:-}" |
	  fzf --ansi \
              --reverse \
	      --color "hl:-1:underline,hl+:-1:underline:reverse" \
	      --delimiter : \
	      --preview 'bat --color=always {1} --highlight-line {2}' \
	      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
	      --bind 'enter:become(vim {1} +{2})'
}
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias clip='xclip -sel clipboard'

light() {
    MIN=20
    # Find the longest backlight path within /sys/class/backlight
    BACKLIGHT_PATH=$(find /sys/class/backlight/ | awk '{ print length, $0 | "sort -nr | head -1" }' | cut -d' ' -f2-)

    if [ -z "$BACKLIGHT_PATH" ]; then
        echo "Backlight path not found."
        return 1
    fi

    MAX=$(cat "$BACKLIGHT_PATH/max_brightness")
    VAL=$1

    if [ "$#" -ne 1 ]; then
        echo "Illegal number of parameters"
        echo "Usage: light <$MIN - $MAX>"
        return 1
    fi

    if [[ $* == *--help* ]]; then
        echo "Usage: light <MIN - MAX>"
        echo "MIN: $MIN"
        echo "MAX: $MAX"
        return 0
    fi

    if [[ $1 -lt $MIN ]]; then
        VAL=$MIN
    elif [[ $1 -gt $MAX ]]; then
        VAL=$MAX
    fi

    sudo sh -c "echo $VAL > $BACKLIGHT_PATH/brightness"
    echo "Brightness is $VAL, $(((VAL*100)/$MAX))%"
}

