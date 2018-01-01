#! /usr/bin/env bash
killa(){
    for pid in $(ps aux | grep tshark-watch | grep -v grep | awk '{print $2}'); do
        kill "$pid";
    done
}
killa
