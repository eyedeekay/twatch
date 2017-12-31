#! /usr/bin/env bash

if [ -f tshark/tshark.conf ]; then
    source tshark/tshark.conf
fi

monitor(){
    sudo ifconfig "$wifi_interface" down && \
        echo "Brought $wifi_interface down"
    sudo iwconfig "$wifi_interface" mode monitor && \
        echo "Put $wifi_interface into monitor mode"
    sudo ifconfig "$wifi_interface" up && \
        echo "Brought $wifi_interface back up"
    sudo iwconfig "$wifi_interface" channel 6 && \
        echo "Setting $wifi_interface to channel 6"
}

client(){
    sudo ifconfig "$wifi_interface" down && \
        echo "Brought $wifi_interface down"
    sudo iwconfig "$wifi_interface" mode managed && \
        echo "Put $wifi_interface into managed client mode"
    sudo ifconfig "$wifi_interface" up && \
        echo "Brought $wifi_interface back up"
    sudo iwconfig "$wifi_interface" channel 6 && \
        echo "Set $wifi_interface to channel 6"
}

beacons(){
    tshark -n -i "$wifi_interface" subtype probereq
}

