#!/bin/sh

# if wireless device exist
if [[ $(grep -E "Wireless" <<< $(lspci)) || $(grep -E "Wireless" <<< $(lsusb)) ]]; then
    local -r has_wifi=yes
else
    local -r has_wifi=--
fi