#! /usr/bin/env bash

source "$HOME/.bashrc"
#source "$HOME/.profile"

PS1="$Blue\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[$Blue\342\234\227$Blue]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)$Blue]\342\224\200[\[\033[0;32m\]\w$Blue]
$Blue\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\] $(__git_ps1 "(%s)")$Red:twatch ->$Green "

export CONF_FILE=/etc/twatch/global.conf
export ENV_DIRECTORY=/usr/lib/twatch/

if [ -f /etc/twatch/global.conf ]; then
    source /etc/twatch/global.conf
fi

if [ -f global.conf ]; then
    source global.conf
fi

source "$ENV_DIRECTORY/tshark/tshark-functions.sh"
source "$ENV_DIRECTORY/tshark/hostapd-functions.sh"

alias assist="assist_vars; tshark_assist; hostapd_assist"

wifiwatchdog(){
    mkdir -p out
    aplist
    frames
    tmux new-window "$ENV_DIRECTORY/tshark/tshark-watch.sh"
    tmux split-window -v "$ENV_DIRECTORY/tshark/mac-watch.sh"
}

evilflexo(){
    "$ENV_DIRECTORY/tshark/hostapd-watch.sh" 2>err
}

alias help="assist"

alias exit="rm -rf out.last; mv out out.last; make clean; tshark_kill; exit"
