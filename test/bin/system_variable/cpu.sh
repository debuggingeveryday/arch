#!/bin/sh

if [[ $(lscpu | grep -E "GenuineIntel") ]]; then
    cpu_type="INTEL"
elif [[ $(lscpu | grep -E "AuthenticAMD") ]]; then
    cpu_type="AMD"
else
    cpu_type="--"
fi