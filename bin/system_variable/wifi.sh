#!/bin/sh

# if wireless device exist
if [[ $(grep -E "Wireless" <<< $(lspci)) || $(grep -E "Wireless" <<< $(lsusb)) ]]; then
    has_wifi=yes
fi