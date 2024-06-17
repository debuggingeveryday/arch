#!/bin/sh

# if wireless device exist
if [[ $(grep -E "Wireless" <<< $(lspci)) || $(grep -E "Wireless" <<< $(lsusb)) ]]; then
    declare -r has_wifi=yes
else
    declare -r has_wifi=--
fi