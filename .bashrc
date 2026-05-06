clear(){
    printf '\033[2J\033[3J\033[1;1H'
}

# windows way
alias cls=clear
alias copy=cp
alias move=mv
alias md='mkdir -p'
alias rd='rm -rf'

# path
export PATH=$PATH:/home/ryzh/.local/bin:/opt:/opt/7z

# prompt
export PS1='\e[0;32m\u\e[0m@\e[0;34m\h\e[0m:\e[0;93m\w\e[0m\$ '

# wine
export WINEPREFIX=/home/ryzh/wine/pref1
