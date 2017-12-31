#! /usr/bin/env bash

export CONF_FILE=/etc/twatch/global.conf
export ENV_DIRECTORY=/usr/lib/twatch/

if [ -f /etc/twatch/global.conf ]; then
    source /etc/twatch/global.conf
fi

if [ -f global.conf ]; then
    source global.conf
fi

source "$ENV_DIRECTORY/tshark/tshark-functions.sh"

alias assist="tshark_assist"
