

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
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
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
    if [[ ${EUID} == 0 ]] ; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
    else
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h \w\a\]$PS1"
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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

#if [ -x /usr/bin/mint-fortune ]; then
#     /usr/bin/mint-fortune
#fi

#cd+ls -al 
alias cls="cdls"
function cdls(){ clear ; cd "$@" && ls; }

#clear + ls
alias cl="clearls"
function clearls(){ clear && ls; }

# BASH PS1
PS1="\[\033[01;36m\]\w \[\e[01;31m\]>\[\e[m\] \[\033[00m\]"


#PS1="\033]0;Terminal\007"$PS1

#PS1="\[\e[01;31m\]$\[\e[m\] \[\033[00m\]"
#run bashrc ez
alias runbashrc=". ~/.bashrc"

#fast CD command
alias dcd="quickCD"
function quickCD(){ 
dirName=( $(find /home/ohman/ -name "$@" 2>&1 | grep -v "Permission denied") ); 
count=0;
if [ ${#dirName[*]} -gt 1 ]
then
	for element in "${dirName[@]}"; do
		count=$((count+1))
		echo $element "($count)"
	done
read var1
var1=$var1-1;
cd "${dirName[$var1]}"
else 
	cd "${dirName[(0)]}";
	if [ 1 -gt ${#dirName[*]} ]
	then
	echo "Whops.."
	fi
fi

} #cd "${dirName}";} #&


set -o vi

alias py="python"

# nvim to default editor in ranger
export EDITOR=nvim

alias omega="ssh root@omega-b64b.local"

#alias ogcc="~/omegaStuff/source/staging_dir/toolchain-mipsel_24kc_gcc-5.4.0_musl-1.1.16/bin/mipsel-openwrt-linux-gcc"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# export PATH=$PATH:/home/ohman/go/bin
# export PATH=$PATH:/home/ohman/.local/bin
# export PATH=$PATH:/home/ohman/Ac6/SystemWorkbench
# export PATH=$PATH:/home/ohman/.gem/ruby/2.6.0/bin
# export PATH=$PATH:/home/ohman/progStuff/esp/xtensa-esp32-elf/bin
# export IDF_PATH=~/progStuff/esp/esp-idf

alias ch="python /home/ohman/progStuff/pyStuff/spellcheck.py"
alias pas="python /home/ohman/progStuff/pyStuff/passGen.py"
alias 328check="sudo avrdude -B 5 -c usbasp -p m328 "
alias 328burn="sudo avrdude -B 5 -c usbasp -p m328 -U flash:w:rune.hex"
alias 328compile="sudo avr-gcc -mmcu=atmega328 -Wall "$@" -o rune.hex"
alias hack="cat /dev/urandom | hexdump -C | grep 'ca fe'"
alias xclip="xclip -selection c"
alias p="sudo pacman"
alias searchWord="rg '' | fzf -e"
alias away="~/.screenlayout/away.sh"
alias home="~/.screenlayout/home.sh"
alias cc_args="python ~/progStuff/cc_args.py"
alias se_keys="setxkbmap se; exec xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape';"
alias us_keys="setxkbmap us; exec xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape';"
alias asdf="cht.sh --shell"
alias bt="py ~/progStuff/pyStuff/bluetooth.py"
alias jabjab="bt c jabra"
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias open='xdg-open'
alias c='clear'


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --hidden  --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_DEFAULT_OPTS='--reverse'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

function rgvim(){
  file=($(fd -H | fzf --preview 'cat {}'));
  if [ 1 -gt ${#file[*]} ]
    then
	echo "Aborted.."
  else
    nvim $file
  fi
}
bind -x '"\C-p": rgvim ;'

function rgemacs(){
  file=($(fd -H | rofi -theme doom -dmenu -p open));
  if [ 1 -gt ${#file[*]} ]
    then
	echo "Aborted.."
  else
    emacsclient $file &
  fi
}


function kp(){
  proc=($(ps -e | rg " " | fzf));
  kill ${proc[0]};
  echo ${proc[3]} killed
}

function autoCd(){
  cd;
  dir=($(fd -t d -p ~/ | fzf));
  if [ 1 -gt ${#dir[*]} ]
    then
	echo "Aborted.."
  else
    cd $dir;
    cl;
  fi
}
bind -x '"\C-o": autoCd ;'

function openPdf(){
  cd;
  pdf=($(fd -t f .pdf | fzf));
  if [ 1 -gt ${#pdf[*]} ]
    then
	echo "Aborted.."
  else
    nohup zathura $pdf & disown; exit;
  fi
}
bind -x '"\C-f": openPdf ;'

bind -x '"\C-k": searchWord ;'

function bu(){
  cp -r ~/progStuff /run/media/ohman/backup/archFiles/;
  cp -r ~/bgImages /run/media/ohman/backup/archFiles/;
  cp -r ~/UU /run/media/ohman/backup/archFiles/;
  cp -r ~/.colors /run/media/ohman/backup/archFiles/;
  cp -r ~/go /run/media/ohman/backup/archFiles/;
  cp -r ~/.vim /run/media/ohman/backup/archFiles/;
  cp -r ~/.config /run/media/ohman/backup/archFiles/;
  cp -r ~/.themes /run/media/ohman/backup/archFiles/;
  cp -r ~/.Xdefaults /run/media/ohman/backup/archFiles/;
  cp -r ~/.bashrc /run/media/ohman/backup/archFiles/;
  cp -r ~/.bash_profile /run/media/ohman/backup/archFiles/;
  cp -r ~/.fdignore /run/media/ohman/backup/archFiles/;
  cp -r ~/.doom.d /run/media/ohman/backup/archFiles/;
}
function bu2(){
  cp -r ~/bgImages /run/media/ohman/backup/archFiles/;
  cp -r ~/.colors /run/media/ohman/backup/archFiles/;
  cp -r ~/go /run/media/ohman/backup/archFiles/;
  cp -r ~/.vim /run/media/ohman/backup/archFiles/;
  cp -r ~/.config /run/media/ohman/backup/archFiles/;
  cp -r ~/.themes /run/media/ohman/backup/archFiles/;
  cp -r ~/.Xdefaults /run/media/ohman/backup/archFiles/;
  cp -r ~/.bashrc /run/media/ohman/backup/archFiles/;
  cp -r ~/.bash_profile /run/media/ohman/backup/archFiles/;
  cp -r ~/.fdignore /run/media/ohman/backup/archFiles/;
  cp -r ~/.doom.d /run/media/ohman/backup/archFiles/;
}

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'







