### Bashrc
### Author : Shane Case <deakons@gmail.com>

# ======================
# **********************
# Init environment
# **********************
# ======================

# Check for an interactive session
[ -z "$PS1" ] && return

### Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.bash/.bash_colors ]; then
	. ~/.bash/.bash_colors
fi

# Debian -- if support 256 color terminal
if [ -e /lib/terminfo/x/xterm-256color ]; then
        export TERM='xterm-256color'
else
        export TERM='xterm-color'
fi

case $(uname -s) in
	Linux)
		eval `dircolors ~/.bash/.trapd00r_colors`
		;;
esac


# =====================
# *********************
# Shell Variables
# *********************
# =====================

case $(uname -s) in
	Darwin)
		export PATH=$PATH:/opt/local/bin
		;;	
	*)
		export PATH=$PATH:/bin:/sbin:/usr/sbin:/usr/bin:/usr/local/bin
		export PATH=$PATH:/usr/local/sbin:/home/shane/bin:.
		;;
esac

export HISTSIZE=1000
export HISTFILESIZE=2000
export PATH=$PATH:/bin:/sbin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:/home/shane/bin:.
export EDITOR=vim
export HISTCONTROL=ignoredups
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'
export GREP_COLOR="1;32"


# =====================
# *********************
# Config Options
# *********************
# =====================


shopt -s histappend 	# Append to history rather than overwrite
shopt -s cdspell	# Correct spelling in cd command


# =====================
# *********************
# Bash functions
# *********************
# =====================


# Debian -- show recent apt activity
function apt-history(){
      case "$1" in
        install)
              cat /var/log/dpkg.log | grep 'install '
              ;;
        upgrade|remove)
              cat /var/log/dpkg.log | grep $1
              ;;
        rollback)
              cat /var/log/dpkg.log | grep upgrade | \
                  grep "$2" -A10000000 | \
                  grep "$3" -B10000000 | \
                  awk '{print $4"="$5}'
              ;;
        *)
              cat /var/log/dpkg.log
              ;;
      esac
}

# Delete a line from known_hosts

# ====================
# ********************
# Prompt (PS1)
# ********************
# ====================

# Display current git branch in PS1 prompt
if [ -f /usr/bin/git ] 
then
	function parse_git_branch {
	    local dir=. head
	    until [ "$dir" -ef / ]; do
	        if [ -f "$dir/.git/HEAD" ]; then
	            head=$(< "$dir/.git/HEAD")
	            if [[ $head == ref:\ refs/heads/* ]]; then
	                git_branch="${head#*/*/}"
	            elif [[ $head != '' ]]; then
	                git_branch='detached'
	            else
	                git_branch='unknown'
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

# Old Prompt
#PS1="${BBlack}┌─[${BYellow}\A${BBlack}]-[${BGreen}\h${BBlack}]-[${BCyan}\j${BBlack}]-${BBlack}[${BCyan}\$retval${BBlack}]-[${BCyan}\w${BBlack}]-[${BCyan}\$(/bin/ls -A1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lAh | /bin/grep -m 1 total | /bin/sed 's/total //')b${BBlack}]--${BGreen}\$git_branch${BBlack}\n"

#PS1="\n${Blue}\342\224\214($(if [[ ${EUID} == 0 ]]; then echo -ne '${BRed}\h'; else echo -e '${BGreen}\h'; fi)\[\033[0;34m\])\$([[ \$? != 0 ]] && echo \"\342\224\200(\[\033[0;31m\]\342\234\227\[\033[0;34m\])\")\342\224\200(\[\033[1;33m\]\A\[\033[0;34m\])\[\033[0;34m\]\342\224\200(\[\033[1;35m\]\j\[\033[0;34m\])\[\033[0;34m\]\342\224\200(\[\033[1;32m\]\$(ls -1 | wc -l | sed 's: ::g'    ) files, \$(ls -sh | head -n1 | sed 's/total//')b\[\033[0;34m\])\342\224\200(\[\033[1;33m\]\[\033[1;33m\]\$git_branch\[\033[0;34m\])\n\342\224\224\342\224\200(\[\033[1;32m\]\w\[\033[0;34m\])\342\224\200> \[\033[0m\]"
PS1="\n${Blue}\342\224\214($(if [[ ${EUID} == 0 ]]; then echo -ne '${BRed}\h'; else echo -e '${BGreen}\h'; fi)\[\033[0;34m\])\$([[ \$? != 0 ]] && echo \"\342\224\200(\[\033[0;31m\]\342\234\227\[\033[0;34m\])\")\342\224\200(\[\033[1;33m\]\A\[\033[0;34m\])\[\033[0;34m\]\342\224\200(\[\033[1;35m\]\j\[\033[0;34m\])\[\033[0;34m\]\342\224\200(\[\033[1;32m\]\$(ls -1 | wc -l | sed 's: ::g'    ) files, \$(ls -sh | head -n1 | sed 's/total//')b\[\033[0;34m\])\[\033[1;33m\]\[\033[1;33m\]\$git_branch\\n\342\224\224\342\224\200(\[\033[1;32m\]\w\[\033[0;34m\])\342\224\200> \[\033[0m\]"


# ====================
# ********************
# Aliases
# ********************
# ====================


case $(uname -s) in
	Darwin)
		alias ls="ls -hFG"
		;;	
	Linux)
		alias ls='ls -pFH --color=auto --group-directories-first'
		;;
esac

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CFl'
alias make="time make"
alias ps='ps o user,pid,psr,%cpu,%mem,args axf --cols 120'
alias psg='ps | grep'
alias grep='grep --color=auto'
alias rsync='rsync -ravz --progress'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get -V upgrade'

if [ -f /usr/bin/valgrind ] 
then
	alias valgrind='valgrind -v --leak-check=full'
fi

if [ -f /usr/bin/dfc ]
then
	alias df='dfc -W'
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
