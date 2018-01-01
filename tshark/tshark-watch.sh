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

main(){
    window "wifiwatchdog" "green"
    append "wifiwatchdog is a terminal utility to monitor the local area
    for new wi-fi presences and display information about them via the 802.11
    management frames they emit." "grey"
    addsep
    for f in *.apmac; do
        append_file $f
    done
    addsep
    for f in *.mac; do
        append_file $f
    done
    addsep
}

main_loop 1
