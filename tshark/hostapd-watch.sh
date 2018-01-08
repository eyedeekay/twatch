#! /usr/bin/env bash

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

if [ -f "$ENV_DIRECTORY/tshark/hostapd-functions.sh" ]; then
    source "$ENV_DIRECTORY/tshark/hostapd-functions.sh"
fi

main(){
    window "Flexo" "red"
    append "Flexo is an evil twin attack monitoring tool for hostapd-wpe_cli"
    endwin

    addsep

    window "Evil Twin Attacks in Progress" "blue" "75%"
    endwin

    col_right

    window "Status" "blue" "25%"
    endwin

    move_down
}

main_loop 1
