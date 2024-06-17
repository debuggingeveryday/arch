#!/bin/sh

if [[ $(lscpu | grep -E "GenuineIntel") ]]; then
    declare -r cpu_type="INTEL"
elif [[ $(lscpu | grep -E "AuthenticAMD") ]]; then
    declare -r cpu_type="AMD"
else
    declare -r cpu_type="--"
fi
