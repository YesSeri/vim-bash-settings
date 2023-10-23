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

runit() {
	rest="${@:1}"
	eval $($rest | fzf --reverse)

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


# pick files with extension as argument
filepick-extension() {
fd -e $1 | fzf --preview='head -$LINES {}' -m | paste -s -d " "
}
alias zim='fzf --multi --print0 | xargs --no-run-if-empty -0 -o vim'
alias fdext='fd . -e'
alias py='python3'


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

# rgi(){
# 	INITIAL_QUERY=""
# 	RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
# 	FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" 
# 	fzf --bind "change:reload:$RG_PREFIX {q} || true" --ansi --disabled --query "$INITIAL_QUERY" --layout=reverse
# }

# alias fzfprev="fd --max-depth 1 | fzf -m --preview 'bat --color always {}' --preview-window right:70%"

# alias n="nvim"
