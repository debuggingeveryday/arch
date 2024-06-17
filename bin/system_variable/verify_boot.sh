#!/bin/sh

if [[ -d "/sys/firmware/efi" ]]; then
    local -r boot_type="UEFI"
else
    local -r boot_type="BIOS"
fi
