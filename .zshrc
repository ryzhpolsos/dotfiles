clear(){
    printf '\033[2J\033[3J\033[1;1H'
}

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
export PATH=$PATH:/home/ryzh/.local/bin:/opt:/opt/powershell:/usr/lib64/java/bin:/home/ryzh/.dotnet

# prompt
export PS1='%F{green}%n%f@%F{blue}%m%f:%F{#ffff00}%~%f%(!.#.$) '
# export PS1='\e[0;32m\u\e[0m@\e[0;34m\h\e[0m:\e[0;93m\w\e[0m\$ '

# wine
export WINEPREFIX=/home/ryzh/wine/pref1
export WINEDEBUG=-all

# luarocks
eval "$(luarocks path)"

# android sdk
export ANDROID_SDK_ROOT=/opt/android-sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator

# dotnet
export DOTNET_ROOT=/home/ryzh/.dotnet

# proxy

set_proxy(){
    export http_proxy='http://127.0.0.1:2080'
    export https_proxy='http://127.0.0.1:2080'
}

unset_proxy(){
    unset http_proxy
    unset https_proxy
}

# set_proxy

# dotnet magic
# dotnet(){
#     if [ "$1" == "run" ]; then
#         shift
#         command dotnet run --no-restore $@
#     else
#         command dotnet $@
#     fi
# }
