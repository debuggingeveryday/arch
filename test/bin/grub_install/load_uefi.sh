#!/bin/sh

# grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --removable
# grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot

source $MAIN_PATH/util/remote.sh

load_uefi() {
    remote grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot

    if [[ "$is_encrypt" == true ]]; then
        remote export storage_name="shingha"
        remote export volgrp="scrubs"
        remote export new_disk="/dev/${target_disk}${target_disk_prefix}2"
        remote export disk_id=$(blkid | grep "${new_disk}" | cut -d' ' -f2 | cut -d'=' -f2 | sed -e 's/"//g')
        remote export tag="GRUB_CMDLINE_LINUX=\"\""
        remote export value="GRUB_CMDLINE_LINUX=\"cryptdevice=UUID=$disk_id:$storage_name root=\/dev\/mapper\/$volgrp-ROOT\""
        remote sed -i "s/$tag/$value/g" /etc/default/grub
    fi
}