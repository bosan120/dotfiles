export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
setopt nonomatch
setopt correct

##################################################
# COLOR
##################################################
autoload -U colors
colors


##################################################
# AUTO_CD
##################################################
setopt auto_cd

##################################################
# AUTOCONP
##################################################
# enable
autoload -Uz compinit
compinit
# complist grouping
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''
# Upper letter
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 
zstyle ':completion:*' ignore-parents parent pwd ..
# sudo autocomp
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                       /usr/sbin /usr/bin /sbin /bin
# ps autocomp
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
# add color for comp list
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

##################################################
# PROMPT
##################################################
PROMPT='%k%f%{%}[%D{%H:%M:%S} %h] %n:%F{006}%~%f%# '
#PROMPT='%k%f%{%} Host: %m %{%} %{%} Hist: %h %{%} %{%} PWD: %~ %{%} %{%} Return: %(?.True.False)
#%{%}%{%}%n%f%# '
#RPROMPT='%D{%H:%M:%S}'

##################################################
# ALIAS
##################################################
alias ls='ls -G'
alias ll='ls -laG'
alias l='ls -G'
alias cls='clear'
alias brewup='brew update && brew upgrade'
alias ngrok='~/ngrok'

##################################################
# HISTORY
##################################################
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_all_dups


##################################################
# DIRECTORY STACK
##################################################
setopt auto_pushd
setopt pushd_ignore_dups


##################################################
# LETTER DELETE
##################################################
WORDCHARS=':?_-.[]~=&;!#$%^(){}<>'

export PATH="$HOME/.linuxbrew/bin:$PATH"
export PATH="$HOME/development/flutter/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
export XDG_DATA_DIRS="$HOME/.linuxbrew/share:$XDG_DATA_DIRS"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/bosan/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/bosan/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/bosan/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/bosan/google-cloud-sdk/completion.zsh.inc'; fi

# Override auto-title when static titles are desired ($ title My new title)
title() { export TITLE_OVERRIDDEN=1; echo -en "\e]0;$*\a"}
# Turn off static titles ($ autotitle)
autotitle() { export TITLE_OVERRIDDEN=0 }; autotitle
# Condition checking if title is overridden
overridden() { [[ $TITLE_OVERRIDDEN == 1 ]]; }
# Echo asterisk if git state is dirty
gitDirty() { [[ $(git status 2> /dev/null | grep -o '\w\+' | tail -n1) != ("clean"|"") ]] && echo "*" }

# Show cwd when shell prompts for input.
precmd() {
   if overridden; then return; fi
   cwd=${$(pwd)##*/} # Extract current working dir only
   print -Pn "\e]0;$cwd$(gitDirty)\a" # Replace with $pwd to show full path
}

# Prepend command (w/o arguments) to cwd while waiting for command to complete.
preexec() {
   if overridden; then return; fi
   printf "\033]0;%s\a" "${1%% *} | $cwd$(gitDirty)" # Omit construct from $1 to show args
}
