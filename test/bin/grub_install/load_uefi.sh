#!/bin/sh

# grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --removable
# grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot

load_uefi() {
    arch-chroot /mnt grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot

    if [[ "$is_encrypt" == true ]]; then
        arch-chroot /mnt export storage_name="shingha"
        arch-chroot /mnt export volgrp="scrubs"
        arch-chroot /mnt export new_disk="/dev/${target_disk}${target_disk_prefix}2"
        arch-chroot /mnt export disk_id=$(blkid | grep "${new_disk}" | cut -d' ' -f2 | cut -d'=' -f2 | sed -e 's/"//g')
        arch-chroot /mnt export tag="GRUB_CMDLINE_LINUX=\"\""
        arch-chroot /mnt export value="GRUB_CMDLINE_LINUX=\"cryptdevice=UUID=$disk_id:$storage_name root=\/dev\/mapper\/$volgrp-ROOT\""
        arch-chroot /mnt sed -i "s/$tag/$value/g" /etc/default/grub
    fi
}