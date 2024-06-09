#!/bin/sh

source $MAIN_PATH/bin/grub_install/load_uefi.sh
source $MAIN_PATH/bin/grub_install/load_bios.sh

grub_install() {
    
    if [[ -z "$kernel" ]]; then
        arch-chroot /mnt mkinitcpio -p linux-$kernel
    elif
        arch-chroot /mnt mkinitcpio -p linux
    fi

    if [[ "$boot_type" == "UEFI" ]]; then
        load_uefi
    elif [[ "$boot_type" == "BIOS" ]]; then
        load_bios
    fi

    arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
}