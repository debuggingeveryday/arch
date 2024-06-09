#!/bin/sh

source $MAIN_PATH/bin/grub_install/load_uefi.sh
source $MAIN_PATH/bin/grub_install/load_bios.sh
source $MAIN_PATH/util/remote.sh

grub_install() {
    
    if [[ -z "$kernel" ]]; then
        remote mkinitcpio -p linux-$kernel
    else
        remote mkinitcpio -p linux
    fi

    if [[ "$boot_type" == "UEFI" ]]; then
        load_uefi
    elif [[ "$boot_type" == "BIOS" ]]; then
        load_bios
    fi

    remote grub-mkconfig -o /boot/grub/grub.cfg
}