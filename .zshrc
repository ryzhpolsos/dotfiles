# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ryzh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# windows way
alias cls=clear
alias copy=cp
alias move=mv
alias md='mkdir -p'
alias rd='rm -rf'

# path
export PATH=$PATH:/home/ryzh/.local/bin:/opt:/opt/powershell

# prompt
export PS1='%F{green}%n%f@%F{blue}%m%f:%F{#ffff00}%~%f%(!.#.$) '
# export PS1='\e[0;32m\u\e[0m@\e[0;34m\h\e[0m:\e[0;93m\w\e[0m\$ '

# wine
export WINEPREFIX=/home/ryzh/wine/pref1
