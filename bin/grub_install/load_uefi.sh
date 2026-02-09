#!/bin/sh

# grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --removable
# grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot

load_uefi() {
    arch-chroot /mnt grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot

    IFS="/"
    read -a disk <<< $target_disk
    
    disk_name_tag="${disk[1]}"
    disk_name_target="${disk[2]}"
    [[ "$target_disk" == *nvme* ]] && disk_target_prefix="p"

    storage_name="shingha"
    volgrp="scrubs"
    new_disk="/${disk_name_tag}/${disk_name_target}${disk_target_prefix}2"
    disk_uuid=$(blkid -s UUID -o value /${disk_name_tag}/${disk_name_target}${disk_target_prefix}2)
    tag="GRUB_CMDLINE_LINUX=\"\""
    value="GRUB_CMDLINE_LINUX=\"cryptdevice=UUID=${disk_uuid}:${storage_name} root=\/dev\/mapper\/${volgrp}-ROOT\""

    arch-chroot /mnt sed -i "s/$tag/$value/g" /etc/default/grub
}
