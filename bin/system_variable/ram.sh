#!/bin/sh

# ram size
ram_size=$(cat /proc/meminfo | grep MemTotal | awk '$1=="MemTotal:"{print $2}')

ram=$((($ram_size / 1000)/2))

if [[ $ram -gt 0 && $ram -lt 3500 ]]; then
swap_size="2G"
elif [[ $ram -gt 3500 && $ram -lt 7500 ]]; then
swap_size="4G"
elif [[ $ram -gt 7500 && $ram -lt 15500 ]]; then
swap_size="8G"
fi
