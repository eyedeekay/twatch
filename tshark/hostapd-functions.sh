#! /usr/bin/env bash

hostapd_launch(){
    sudo ./hostapd-2.6/hostapd/hostapd-wpe_cli -i wlan0 ./hostapd-2.6/hostapd/hostapd.conf
}
