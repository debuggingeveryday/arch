#!/bin/sh

if [[ -d "/sys/firmware/efi" ]]; then
    declare -r boot_type="UEFI"
else
    declare -r boot_type="BIOS"
fi
