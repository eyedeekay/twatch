#! /usr/bin/env bash

#! /usr/bin/env bash

if [ -f /etc/twatch/global.conf ]; then
    export CONF_FILE=/etc/twatch/global.conf
else
    export CONF_FILE=$(pwd)/global.conf
fi

source "$CONF_FILE"

if [ -f /usr/lib/simple_curses.sh ]; then
    echo "using /usr/local/lib/simple_curses.sh"
    source /usr/lib/simple_curses.sh
elif [ -f /usr/local/lib/simple_curses.sh ]; then
    echo "using /usr/local/lib/simple_curses.sh"
    source /usr/local/lib/simple_curses.sh
elif [ -f "$ENV_DIRECTORY/simple_curses.sh" ]; then
    source "$ENV_DIRECTORY/simple_curses.sh"
elif [ -f bashsimplecurses-1.2/simple_curses.sh ]; then
    echo "using bashsimplecurses-1.2/simple_curses.sh"
    source bashsimplecurses-1.2/simple_curses.sh
else
    echo "bashsimplecurses not found."
    echo "Please run make dep or install systemwide."
    exit 1
fi

if [ -f "$ENV_DIRECTORY/tshark/tshark-functions.sh" ]; then
    source "$ENV_DIRECTORY/tshark/tshark-functions.sh"
fi

tagged_mac_list(){
    c=1
    echo "m0" "Me:_$my_mac_address" on
    if [ -f out/macs.txt ]; then
        for line in $(cat out/macs.txt); do
            echo "m$c" "$line" off
            c=$((c+1))
        done
    fi
    if [ -f out/routers.txt ]; then
        for line in $(cat out/routers.txt); do
            echo "m$c" "$line" off
            c=$((c+1))
        done
    fi
}

build_list(){
    dialog --timeout 10 --buildlist "Known/Unknown Devices" 0 0 0 $(tagged_mac_list)
}

mac_loop(){
    while true; do
        build_list
        sleep 10
    done
}

#build_list
mac_loop
