
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Colored grep results

alias grep='grep --color=auto'


# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

#---------------------------------------------------------------------------------------------
# CUSTOM USER ALIAS DEFINITIONS


# hint... use wrapper function to gain greater control over passing args to alias commands
# alias reverse_args='f(){ echo "$4 $3 $2 $1"; unset -f f; }; f'




# alarm variable/command (use with eval command)
alarm_10_reps='i=0; while [[ $i -lt 10 ]]; do echo -ne "\a"; sleep .3; echo -ne "\a"; i=$((i+=1)); done'


# Timer Alias -
alias timer15m='sleep 900; eval "$alarm_10_reps"'
alias timer10m='sleep 600; eval "$alarm_10_reps"'
alias timer5m='sleep 300; eval "$alarm_10_reps"'
alias timer2m='sleep 120; eval "$alarm_10_reps"'
alias timer1m='sleep 60; eval "$alarm_10_reps"'
alias timer120='sleep 120; eval "$alarm_10_reps"'
alias timer60='sleep 60; eval "$alarm_10_reps"'
alias timer30='sleep 30; eval "$alarm_10_reps"'
alias timer='f(){ sleep "$1"m; eval "$alarm_10_reps"; unset -f f; }; f'

# Dog and Hound
alias dog='cat -n' #provides numbered output for cat command using -n flag
alias hound='grep -ni' # grep with numbered line number output for searching source code for keywords


# Terminal ease-of-use aliases
alias cls='clear && ls' # Great command. Clears terminal and lists files in current dir
alias clls='clear && ls -lG'
alias clas='clear && ls -aG'
alias cllas='clear && ls -laG'


# git definitions
alias all_in='git add -A; git commit; git push'



# Active terminal refresh and list contents in real time "perpertual clear and list"
alias pcls='while [ 1 ]; do cls; sleep 1; done'
alias pclls='while [ 1 ]; do clls; sleep 1; done'
alias pclas='while [ 1 ]; do clas; sleep 1; done'
alias pcllas='while [ 1 ]; do cllas; sleep 1; done'


# colorize diff output - requires colordiff program
alias diff='colordiff'


# History search aliases
alias tailhist='history | tail -n $1'
alias histgrep='history | grep -i $1'
alias histcount='history | grep -ic $1'

# Modify permissions
alias authorize='sudo chmod +766'
alias deauthorize='sudo chmod -777' # password-locks file

# emacs alias definition
alias enw='emacs -nw'
alias anthomacs='emacs -nw -bg color-20 -fg yellow'





#---------------------------------------------------------------------------------------------

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



# USER ADDED - Github cli autocompletion feature
eval "$(gh completion -s bash)"


# ANSI color escape sequence variable assignments

white="\e[0;37m"
reset="\e[0m"



# User modified PS1 variables

# Standard propmt but with prefixed timestamp in white text:
# PS1="${white} (\t) ${reset}"$PS1

# Same as above prompt but with postfixed timestamp instead of prefixed
# PS1=$PS1"${white}(\t):${reset}"


# There was an odd problem with the below PS1 variable change
# \e[1;33m\u@\h\e[0m\e[1;36m:\e[0m\e[1;31m\w\e[0m$ \e[1;37m(\t)\e[0m


# Recolorized standard prompt
PS1="(\t) \[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "



# Add golang binaries to PATH

export PATH=$PATH:/usr/local/go/bin
