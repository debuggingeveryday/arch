#!/bin/bash

test() {
    if [[ $1 == "check_environment_variables" ]]; then
        echo "--------- TESTING ----------"

        echo "
            ARCH_BOOT_TYPE=$ARCH_BOOT_TYPE
            ARCH_SETTINGS=$ARCH_SETTINGS
            ARCH_HOSTNAME=$ARCH_HOSTNAME
            ARCH_PASSWORD=$ARCH_PASSWORD
            ARCH_TIMEZONE=$ARCH_TIMEZONE
            ARCH_RAM_SIZE=$ARCH_RAM_SIZE
            ARCH_CPU_TYPE=$ARCH_CPU_TYPE
            ARCH_TARGET_DISK=$ARCH_TARGET_DISK
            ARCH_IS_ENCRYPT=$ARCH_IS_ENCRYPT
            ARCH_GPU_TYPE=$ARCH_GPU_TYPE
            ARCH_HAS_WIFI=$ARCH_HAS_WIFI
            ARCH_KERNEL=$ARCH_KERNEL
            ARCH_USERNAME=$ARCH_USERNAME
        "
    fi

    if [[ $1 == "partition" ]]; then
        lsblk 
    fi
}