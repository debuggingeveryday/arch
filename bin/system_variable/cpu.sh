#!/bin/sh

if [[ $(lscpu | grep -E "GenuineIntel") ]]; then
    local -r cpu_type="INTEL"
elif [[ $(lscpu | grep -E "AuthenticAMD") ]]; then
    local -r cpu_type="AMD"
else
    local -r cpu_type="--"
fi