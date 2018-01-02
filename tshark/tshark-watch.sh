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

scan(){
    rm -f "stopscan"
    while [ ! -f "stopscan" ]; do
        approbe 1>/dev/null 2>/dev/null
        macprobe 1>/dev/null 2>/dev/null
        sleep 10
    done
    killall tshark
    rm -f "stopscan"
}

scan &

main(){
    window "wifiwatchdog" "green"
    append "wifiwatchdog is a terminal utility to monitor the local area
    for new wi-fi presences and display information about them via the 802.11
    management frames they emit." "grey"
    endwin

    addsep

    window "Known Access Points" "magenta"
    for f in $(find out/ -name *.apmac); do
        append_file "$f"
    done
    endwin

    addsep

    window "Known Clients and Probing AP's" "red"
    for f in $(find out/ -name *.mac); do
        append_file "$f"
    done
    endwin

    addsep

    window "Unique MAC Addresses observed" "yellow" "50%"
    append_file out/macs.txt
    endwin

    col_right

    window "MAC Addreses of nearby AP's" "cyan" "50%"
    append_file out/routers.txt
    endwin

}

main_loop 1
