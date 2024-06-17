#!/bin/sh

base_package() {
    if [[ -n "${ARCH_KERNEL}" ]]; then
        local -r type="-${ARCH_KERNEL}"
    else
        local -r type=""
    fi

    pacstrap /mnt --noconfirm --needed base base-devel linux${type} linux${type}-headers linux-firmware grub # (optional) os-prober 
    [[ "$ARCH_BOOT_TYPE" == "UEFI" ]] && pacstrap /mnt --noconfirm --needed efibootmgr
}