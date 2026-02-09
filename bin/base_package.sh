#!/bin/sh

base_package() {
    [[ "$kernel_headers" != "--" ]] && type="-${kernel_headers}"
    pacstrap /mnt --noconfirm --needed base base-devel linux${type} linux${type}-headers linux-firmware grub # (optional) os-prober 
    [[ "$boot_type" == "UEFI" ]] && pacstrap /mnt --noconfirm --needed efibootmgr
}
