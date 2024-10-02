# Naming conventions
# Environment variables or shell variables introduced by the operating system, shell startup scripts, or the shell itself, etc., are usually all in CAPITALS1.
# To prevent your variables from conflicting with these variables, it is a good practice to use lower_case variable names.
#
# https://unix.stackexchange.com/questions/42847/are-there-naming-conventions-for-variables-in-shell-scripts
#
### snippet for sourcing .bash_aliases file if it exists.
# Use this in ~/.bashrc to read file.
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi
#
### copy bashrc and bash aliases command 
#
## this finds relevant files
# fd --hidden "^.?bash(_aliases|rc)$" ~ 
#
## use this from inside vim with ctrl+x ctrl+e on cli
# :r ! fd --hidden "^.?bash(_aliases|rc)$" ~ 
#
## the command should look like this kind of
# cp /home/henrik/.bashrc /home/henrik/programming/docs/vim-bash-settings/linux/bashrc && cp /home/henrik/.bash_aliases /home/henrik/programming/docs/vim-bash-settings/linux/bash_aliases
#
## with bat config
# cp /home/henrik/.bashrc /home/henrik/programming/docs/vim-bash-settings/linux/bashrc && cp /home/henrik/.bash_aliases /home/henrik/programming/docs/vim-bash-settings/linux/bash_aliases && cp /home/henrik/.config/bat/config /home/henrik/programming/docs/vim-bash-settings/linux/bat/config

myuptime () {
	uptime | awk '{ print "Uptime:", $3, $4, $5 }' | sed 's/,//g'
	return;
}


alias volup="amixer sset Master 10%+"
alias voldown="amixer sset Master 10%-"
alias vol="amixer sset Master"

alias brightup="sudo brightnessctl set +10%"
alias brightdown="sudo brightnessctl  set 10%-"
alias bright="sudo brightnessctl set"
alias o="xdg-open"
alias x="exit"

alias tablet="python3 /home/henrik/programming/scripts/scale.py"
alias brownnoise="/home/henrik/programming/vim-bash-settings/linux/scripts/brown_noise.sh"

alias nnn="nnn -e" 
# -e = edit in $EDITOR
# -H = show hidden
alias q="exit"
alias buildgcc="gcc -Wall -g $1 -o a.out"
alias ec="emacsclient -n"
alias lc3="/home/henrik/Documents/t2/machine/LC_3_Simulator/LC3Tools-2.0.2.AppImage"

createLatex() {
	file=$1
	filename="${file%.*}"
	outdir="out-${filename}"
	mkdir -p $outdir && pandoc $file --standalone --output $outdir/$filename.pdf #&& pdflatex -output-directory=$outdir $outdir/$filename.tex
	#find $outdir | rg .*(aux|log)$ | xargs rm
	find $outdir -type f -iname '*.pdf' | xargs xdg-open

}



upgradeAptApps() {
	sudo apt update -y && sudo apt upgrade -y
}

install() {
	sudo apt install $1
}

mkcd() { mkdir -p "$1" && cd "$1"; }

alias glogall='git log --graph --full-history --all --color --oneline'
alias ga='git add'
alias gc='git commit'
alias gpush='git push'
alias gpull='git pull'

# Full info and hidden files
alias lah='ls -lah'

alias cpscreenshot='cp "$(fd . ~/Pictures/Screenshots/ -a | tail -1)"'

alias foxit='/home/henrik/.installedPrograms/foxitsoftware/foxitreader/FoxitReader.sh'




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

alias History="history-no-lines | tac | sortKeepOrder | fzf --height=50% --border"

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
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging always'"

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

alias clip='tr --delete "\n" | xclip -sel clipboard'

light(){
	MIN=100
	MAX=`cat /sys/class/backlight/intel_backlight/max_brightness`
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
	sudo sh -c "echo $VAL > /sys/class/backlight/intel_backlight/brightness"
	echo "brightness is $VAL, $(((VAL*100)/$MAX))%"
}
