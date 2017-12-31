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

wlan(){
    sudo iwconfig wlan0
}

beacons(){
    tshark -n -i "$wifi_interface" "$filter_my_mac" -f "subtype probereq" > probes.cap 2>tshark.log &
    spot
}

macs(){
    grep -io '[0-9a-f:]\{17\}' probes.cap | sort -u
}

macprobe(){
    unique_macs=$(macs)
    for mac in $unique_macs; do
        echo "Probing for beacon information from $mac"
        output_file=$(echo "$mac" | tr -d ":").mac
        tshark -n -i "$wifi_interface" -f "ether host $mac" -f "subtype probereq" -c 1 | tee "$output_file"
    done
}

spot(){
    tail -f probes.cap
}

tshark_assist(){
    echo "Aliases for using tshark have been loaded into your shell. They are:"
    echo " monitor -put your card into Monitor Mode"
    echo " client -put your card into Managed Client Mode"
    echo " wlan -check the wireless card's mode"
    echo " beacons -capture wireless management frams in probes.cap"
    echo " macs -identify unique mac addresses and list them"
    echo " macprobe -identify and gather information about uniqe addresses"
    echo " spot -follow probes.cap output"
}
