#!/bin/sh

source $MAIN_PATH/bin/grub_install/load_uefi.sh
source $MAIN_PATH/bin/grub_install/load_bios.sh

mkinitcpio() {
    if [[ -n "$ARCH_KERNEL" ]]; then
        arch-chroot /mnt mkinitcpio -p linux-$ARCH_KERNEL
    else
        arch-chroot /mnt mkinitcpio -p linux
    fi
}

grub_mkconfig() {
    arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
}

load_system() {
    if [[ "$ARCH_BOOT_TYPE" == "UEFI" ]]; then
        load_uefi
    elif [[ "$ARCH_BOOT_TYPE" == "BIOS" ]]; then
        load_bios
    fi
}

grub_install() {
    mkinitcpio
    load_system
    grub_mkconfig
}
