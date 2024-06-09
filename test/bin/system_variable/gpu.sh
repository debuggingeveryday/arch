#!/bin/sh

# define gpu type
if [[ $(lspci | grep -E "NVIDIA|GeForce") ]]; then
    gpu_type="NVIDIA"
elif [[ $(lspci | grep -E "Radeon|AMD") ]]; then
    gpu_type="AMD"
elif [[ $(lspci | grep -E "Integrated Graphics Controller") ]]; then
    gpu_type="INTEL_GRAPHICS"
elif [[ $(lspci | grep -E "Intel Corporation UHD") ]]; then
    gpu_type="INTEL_UHD"
else
    gpu_type="--"
fi