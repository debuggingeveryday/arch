#!/bin/sh

source $MAIN_PATH/bin/grub_install/load_uefi.sh
source $MAIN_PATH/bin/grub_install/load_bios.sh

mkinitcpio() {

    if [[ -z "$kernel" ]]; then
        arch-chroot /mnt mkinitcpio -p linux-$kernel
    else
        arch-chroot /mnt mkinitcpio -p linux
    fi
}

grub_mkconfig() {
    arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
}

load_system() {
    if [[ "$boot_type" == "UEFI" ]]; then
        load_uefi
    elif [[ "$boot_type" == "BIOS" ]]; then
        load_bios
    fi
}

grub_install() {
    mkinitcpio
    load_system
    grub_mkconfig
}
