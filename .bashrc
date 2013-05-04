### Bashrc
### Author : Shane Case <deakons@gmail.com>

# Check for an interactive session
[ -z "$PS1" ] && return

### Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.bash/.bash_colors ]; then
	. ~/.bash/.bash_colors
fi

### Environment Setup

# Do not post duplicates to bash history
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


export PATH=$PATH:/bin:/sbin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:~/.bin:.
export EDITOR=vim

export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'
export GREP_COLOR="1;32"

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

PROMPT_COMMAND="parse_return_value;parse_git_branch"

# Trim working directory to only show up previous two directories
export PROMPT_DIRTRIM=2

PS1="${BBlack}┌─[${Cyan}\A${BBlack}]-[${Cyan}\h${BBlack}]-[${Cyan}\j${BBlack}]-${BBlack}[${Cyan}\$retval${BBlack}]-[${Cyan}\w${BBlack}]-[${Cyan}\$(/bin/ls -A1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lAh | /bin/grep -m 1 total | /bin/sed 's/total //')b${BBlack}]-${BGreen}\$git_branch${BBlack}--\n"

# If copied to /root, show # instead
if [ "`id -u`" -eq 0 ]; then
       PS1=$PS1${BBlack}└─"${Red}[#] > ${Color_Off}"
     else
       PS1=$PS1${BBlack}└─"${BGreen}[$] > ${Color_Off}"
fi

# Directory colors
LS_COLORS='rs=00;32:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=01;42:ow=01;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.zip=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.cpio=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.avi=01;35:*.flv=01;35:*.pdf=00;32:*.ps=00;32:*.txt=00;32:*.patch=00;32:*.diff=00;32:*.log=00;32:*.tex=00;32:*.doc=00;32:*.mid=00;36:*.midi=00;36:*.mp3=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36'
export LS_COLORS

### End Prompt

### Aliases

alias ls='ls -pFHX --color=auto --group-directories-first'
alias ll='ls -l'
alias la='ls -Al'
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
