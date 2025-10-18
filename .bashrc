#-------------------------------------------------------------
# Legacy settings for bashrc systems
# Adapted from Linux Mint ones and Ubuntu Budgie init .bashrc
# Some stolen from random Linux users ;-)
#-------------------------------------------------------------
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

ulimit -S -c 0      # Don't want coredumps.
set -o notify
set -o noclobber
set -o ignoreeof
alias ls='ls --color=auto'
alias ll='ls -alF'

#-------------------------------------------------------------
# Fun Stuff: Greeting, motd
# PS1 Settings
#-------------------------------------------------------------
# Legacy PS1 2014-2022
#PS1="\[$(tput bold)\]\[\033[38;5;10m\]\u\[$(tput bold)\]\[\033[38;5;32m\]@\[$(tput bold)\]\[\033[38;5;10m\]\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;32m\]\t\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;32m\][\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;10m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;32m\]]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput bold)\]> \[$(tput sgr0)\]"
export PS1="\[$(tput bold)\]\[\033[38;5;32m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;135m\]\h\[$(tput sgr0)\] \t : \d\n[\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;40m\]\w\[$(tput sgr0)\]] > \[$(tput sgr0)\]"

alias say='echo "$1" | espeak -s 120 2>/dev/null' #This is just a little fun thing for me use.

date
fortune | cowsay -f tux | lolcat -a  -s 100 -F 0.5  -d 5 # Requires fortune (ruby one), cowsay, and lolcat.
