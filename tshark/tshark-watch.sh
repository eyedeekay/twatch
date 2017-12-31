#! /usr/bin/env bash

#! /usr/bin/env bash

if [ -f /etc/twatch/global.conf ]; then
    export CONF_FILE=/etc/twatch/global.conf
else
    export CONF_FILE=$(pwd)/global.conf
fi

source "$CONF_FILE"

if [ -f /usr/lib/simple-curses.sh ]; then
    source /usr/lib/simple-curses.sh
elif [ -f /usr/local/lib/simple-curses.sh ]; then
    source /usr/local/lib/simple-curses.sh
elif [ -f "$ENV_DIRECTORY/simple-curses.sh" ]; then
    source "$ENV_DIRECTORY/simple-curses.sh"
elif [ -f bashsimplecurses-1.2/simple-curses.sh ]; then
    echo "using bashsimplecurses-1.2/simple-curses.sh"
    source bashsimplecurses-1.2/simple-curses.sh
else
    echo "bashsimplecurses not found."
    echo "Please run make dep or install systemwide."
    exit 1
fi

