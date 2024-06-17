#!/bin/sh

# define gpu type
if [[ $(lspci | grep -E "NVIDIA|GeForce") ]]; then
    local -r gpu_type="NVIDIA"
elif [[ $(lspci | grep -E "Radeon|AMD") ]]; then
    local -r gpu_type="AMD"
elif [[ $(lspci | grep -E "Integrated Graphics Controller") ]]; then
    local -r gpu_type="INTEL_GRAPHICS"
elif [[ $(lspci | grep -E "Intel Corporation UHD") ]]; then
    local -r gpu_type="INTEL_UHD"
else
    local -r gpu_type="--"
fi
