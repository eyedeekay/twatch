#! /usr/bin/env bash

if [ -f tshark/tshark.conf ]; then
    source tshark.conf
fi

monitor(){
    sudo ifconfig "$wifi_interface" down
    sudo iwconfig "$wifi_interface" mode monitor
    sudo iwconfig "$wifi_interface" channel 6
    sudo ifconfig "$wifi_interface" up
}

beacons(){
    tshark -i "$wifi_interface"
}
