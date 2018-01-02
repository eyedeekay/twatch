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

frames(){
    tshark -n -i "$wifi_interface" "$filter_my_mac" -f "type mgt" \
        > mgt.cap.txt 2>tshark.frames.log &
}

aplist(){
    tshark -n -i "$wifi_interface" -f "type mgt subtype beacon" \
        > beacons.cap.txt 2>tshark.aps.log &
}

macs(){
    grep -io '[0-9a-f:]\{17\}' mgt.cap.txt | sort -u | sed 's|ff:ff:ff:ff:ff:ff||g' | tee out/macs.txt
}

aps(){
    grep -io '[0-9a-f:]\{17\}' beacons.cap.txt | sort -u | sed 's|ff:ff:ff:ff:ff:ff||g' | tee out/routers.txt
}

approbe(){
    ap_mac=$(aps)
    mkdir -p out
    for ap in $ap_mac; do
        echo "Probing for beacon information from $mac"
        output_file=$(echo "$ap" | tr -d ":").apmac
        tshark $shark_defaults -f "ether host $ap" \
            -f "subtype beacon" -c 1 $print_frame_info 2>aps.err | sed 's|ff:ff:ff:ff:ff:ff||g' \
            | sort -u | tee -a "out/$output_file"
            sort -u "out/$output_file" -o "out/$output_file"
    done
}

macprobe(){
    unique_macs=$(macs)
    mkdir -p out
    for mac in $unique_macs; do
        echo "Probing for beacon information from $mac"
        output_file=$(echo "$mac" | tr -d ":").mac
        tshark $shark_defaults -f "ether host $mac" -c 1 \
            $print_frame_info 2> macs.err | sed 's|ff:ff:ff:ff:ff:ff||g' | sort -u | tee -a "out/$output_file"
            sort -u "out/$output_file" -o "out/$output_file"
    done
}

deauth(){
    unique_macs=$(macs)
    ap_mac=$(approbe)
    mkdir -p out
    for ap in $ap_mac; do
        for mac in $unique_macs; do
            echo "Probing for beacon information from $mac"
            output_file=$(echo "$mac" | tr -d ":").deauth
            sudo aireplay-ng -0 1 -a "$ap" -c "$mac" "$wifi_interface" \
                | tee "out/$output_file"
        done
    done
}

spot(){
    tail -f mgt.cap.txt
}

tshark_assist(){
    echo "Aliases for using tshark have been loaded into your shell. They are:
    monitor -put your card into Monitor Mode
    client -put your card into Managed Client Mode
    wlan -check the wireless card's mode
    beacons -capture wireless management frams in mgt.cap.txt
    macs -identify unique mac addresses and list them
    macprobe -identify and gather information about uniqe addresses
    spot -follow mgt.cap.txt output"
}

tshark_kill(){
    for pid in $(ps aux | grep tshark-watch | grep -v grep | awk '{print $2}'); do
        kill "$pid";
    done
}
