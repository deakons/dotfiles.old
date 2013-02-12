### Bashrc
### Author : Shane Case <deakons@gmail.com>

### Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

### Bash prompt color codes

# Reset
Color_Off='\[\033[0m\]'       	# Reset

# Regular Colors
Black='\[\033[0;30m\]'        	# Black
Red='\[\033[0;31m\]'          	# Red
Green='\[\033[0;32m\]'        	# Green
Yellow='\[\033[0;33m\]'       	# Yellow
Blue='\[\033[0;34m\]'         	# Blue
Purple='\[\033[0;35m\]'       	# Purple
Cyan='\[\033[0;36m\]'         	# Cyan
White='\[\033[0;37m\]'        	# White

# Bold
BBlack='\[\033[1;30m\]'         # Black
BRed='\[\033[1;31m\]'  	        # Red
BGreen='\[\033[1;32m\]'         # Green
BYellow='\[\033[1;33m\]'      	# Yellow
BBlue='\[\033[1;34m\]'        	# Blue
BPurple='\[\033[1;35m\]'      	# Purple
BCyan='\[\033[1;36m\]'        	# Cyan
BWhite='\[\033[1;37m\]'       	# White

# Underline
UBlack='\[\033[4;30m\]'         # Black
URed='\[\033[4;31m\]'         	# Red
UGreen='\[\033[4;32m\]'         # Green
UYellow='\[\033[4;33m\]'        # Yellow
UBlue='\[\033[4;34m\]'         	# Blue
UPurple='\[\033[4;35m\]'        # Purple
UCyan='\[\033[4;36m\]'         	# Cyan
UWhite='\[\033[4;37m\]'         # White

# Background
On_Black='\[\033[40m\]'         # Black
On_Red='\[\033[41m\]'         	# Red
On_Green='\[\033[42m\]'         # Green
On_Yellow='\[\033[43m\]'        # Yellow
On_Blue='\[\033[44m\]'         	# Blue
On_Purple='\[\033[45m\]'        # Purple
On_Cyan='\[\033[46m\]'         	# Cyan
On_White='\[\033[47m\]'         # White

# High Intensity
IBlack='\[\033[0;90m\]'         # Black
IRed='\[\033[0;91m\]'         	# Red
IGreen='\[\033[0;92m\]'         # Green
IYellow='\[\033[0;93m\]'        # Yellow
IBlue='\[\033[0;94m\]'         	# Blue
IPurple='\[\033[0;95m\]'        # Purple
ICyan='\[\033[0;96m\]'         	# Cyan
IWhite='\[\033[0;97m\]'         # White

# Bold High Intensity
BIBlack='\[\033[1;90m\]'        # Black
BIRed='\[\033[1;91m\]'         	# Red
BIGreen='\[\033[1;92m\]'        # Green
BIYellow='\[\033[1;93m\]'       # Yellow
BIBlue='\[\033[1;94m\]'         # Blue
BIPurple='\[\033[1;95m\]'       # Purple
BICyan='\[\033[1;96m\]'         # Cyan
BIWhite='\[\033[1;97m\]'        # White


# High Intensity backgrounds
On_IBlack='\[\033[0;100m\]'     # Black
On_IRed='\[\033[0;101m\]'       # Red
On_IGreen='\[\033[0;102m\]'     # Green
On_IYellow='\[\033[0;103m\]'    # Yellow
On_IBlue='\[\033[0;104m\]'      # Blue
On_IPurple='\[\033[0;105m\]'    # Purple
On_ICyan='\[\033[0;106m\]'      # Cyan
On_IWhite='\[\033[0;107m\]'     # White

### End Color Codes

### Environment Setup

# Do not post duplicates to bash history
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Check for an interactive session
[ -z "$PS1" ] && return

export PATH=$PATH:/bin:/sbin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:/home/shane/.bin:.
export EDITOR=vim

# Colorful man pages
if [ -f /usr/bin/most ]
then
	export PAGER=most
fi

### End Environment Setup

### Prompt (PS1)

# Display current git branch in PS1 prompt
if [ -f /usr/bin/git ] 
then
	function parse_git_branch {
	    local dir=. head
	    until [ "$dir" -ef / ]; do
	        if [ -f "$dir/.git/HEAD" ]; then
	            head=$(< "$dir/.git/HEAD")
	            if [[ $head == ref:\ refs/heads/* ]]; then
	                git_branch="-(${head#*/*/})"
	            elif [[ $head != '' ]]; then
	                git_branch='-(detached)'
	            else
	                git_branch='-(unknown)'
	            fi
	            return
	        fi
	        dir="../$dir"
	    done
	    git_branch=''
	}
else 
	function parse_git_branch {
	return
	}
fi

# Show return value as ok/fail
function parse_return_value {
	if [ $? -eq 0 ]
	then
		retval="ok"
	else
		retval="fail"
	fi
}

PROMPT_COMMAND="parse_return_value;parse_git_branch;"

# Trim working directory to only show up previous two directories
export PROMPT_DIRTRIM=2

#PS1="${BGreen}--${BCyan}[\A]${Color_Off}-${BBlue}[\h]${Color_Off}-${BGreen}[\w]${Color_Off}-${BPurple}\$retval${BYellow}\$git_branch${BGreen}--${Color_Off}\n"
#PS1="${BBlack}--[${BBlue}\A${BBlack}]-[${BBlue}\h${BBlack}]-[${BBlue}\j${BBlack}]-${BBlack}[${BBlue}\$retval${BBlack}]-[${BBlue}\w${BBlack}]${BGreen}\$git_branch${BBlack}--${Color_Off}\n
PS1="${BBlack}--[${BBlue}\A${BBlack}]-[${BBlue}\h${BBlack}]-[${BBlue}\j${BBlack}]-${BBlack}[${BBlue}\$retval${BBlack}]-[${BBlue}\w${BBlack}]-[${BBlue}\$(/bin/ls -A1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lAh | /bin/grep -m 1 total | /bin/sed 's/total //')b${BBlack}]-${BGreen}\$git_branch${BBlack}--${Color_Off}\n"

# If copied to /root, show # instead
if [ "`id -u`" -eq 0 ]; then
       PS1=$PS1"${BRed}# > ${Color_Off}"
     else
       PS1=$PS1"${BGreen}$ > ${Color_Off}"
fi

# Directory colors
#LS_COLORS='di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=01;42:ow=01;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.zip=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.cpio=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.avi=01;35:*.flv=01;35:*.pdf=00;32:*.ps=00;32:*.txt=00;32:*.patch=00;32:*.diff=00;32:*.log=00;32:*.tex=00;32:*.doc=00;32:*.mid=00;36:*.midi=00;36:*.mp3=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36'
#export LS_COLORS

### End Prompt

### Aliases

alias ls='ls -pH --color=auto --group-directories-first'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CFl'
alias make="time make"
alias ps='ps faux'
alias psg='ps | grep'
alias grep='grep -n --color=auto'
alias rsync='rsync -ravz --progress'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f /usr/bin/colordiff ]
then
	alias diff='colordiff'
fi

if [ -f /usr/bin/valgrind ] 
then
	alias valgrind='valgrind -v --leak-check=full'
fi

if [ -f /usr/bin/colorgcc ]
then
	alias gcc='colorgcc'
fi

if [ -f /usr/bin/colormake ]
then
	alias make='colormake'
fi

### End Aliases

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
