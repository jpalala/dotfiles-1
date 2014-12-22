# Include this file by putting the following in your ~/.bashrc:
#
# SUPER_BASHRC="$HOME/dotfiles/.bashrc"
# [ -f $SUPER_BASHRC ] && . $SUPER_BASHRC

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export GIT_PS1_SHOWDIRTYSTATE=1

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export TERM="xterm-256color"
# at the least, LC_COLLATE affects "ls" sort order case-sensitivity
export LC_COLLATE=C

export SITES="/etc/nginx/sites-available"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
    if [[ $GIT_PS1_ENABLED ]]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    fi
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

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

alias sudo='sudo '
alias lx='ls -lahp'
alias vi='vim'
alias vim='vim -p'
alias sdr='sudo shutdown -r now'
alias sdh='sudo shutdown -h now'
alias find='find -H'
alias bc='bc -l'
alias kibitz='kibitz -noescape'
alias irssi='TZ="America/Los_Angeles" irssi'
alias screen_size='terminal_size'
alias terminal_size='echo $(tput cols)x$(tput lines)'
alias php-xdebug='php -dxdebug.remote_enable=On -dxdebug.remote_handler=dbgp -dxdebug.remote_host=localhost -dxdebug.remote_port=9000 -dxdebug.remote_autostart=On'
alias art='php artisan'

# git shortcuts
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias ga='git add'
alias gci='git commit'
alias glg='git log --oneline --graph --decorate --all'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias gbr='git branch'
alias gbn='git rev-parse --abbrev-ref HEAD'
alias gpo='git push -u origin `gbn`'

# Way Generators shortcuts
alias g:m='php artisan generate:model'
alias g:mod='g:m'
alias g:c='php artisan generate:controller'
alias g:v='php artisan generate:view'
alias g:s='php artisan generate:seed'
alias g:mig='php artisan generate:migration'
alias g:r='php artisan generate:resource'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -d /etc/bash_completion.d ]; then
    for file in /etc/bash_completion.d/* ; do
        source "$file"
    done
fi

if [ -d ~/bash_completion.d ]; then
    for file in ~/bash_completion.d/* ; do
        source "$file"
    done
fi

export EDITOR="/usr/bin/vim"
export MAILDIR="~/Maildir"

if [ $SSH_TTY ] && [ ! $WINDOW ]; then
	SCREENLIST=`screen -ls | grep 'Attached'`
	if [ $? -eq "0" ]; then
		echo -e "Screen is already running and attached:\n ${SCREENLIST}"
	else
		cd /www
		screen -U -R
	fi
fi
