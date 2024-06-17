#!/bin/sh

# grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --removable
# grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot

source $MAIN_PATH/util/debug.sh

load_uefi() {
    local -r disk=$(echo "${ARCH_TARGET_DISK}" | sed "s/\// /g")
    local -r disk_name_tag=$(echo "$disk" | awk '{print $1}')
    local -r disk_name_target=$(echo "$disk" | awk '{print $2}')
    local -r disk_target_prefix=""

    arch-chroot /mnt grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot

    if [[ "$ARCH_IS_ENCRYPT" == true ]]; then
        local -r storage_name="shingha"
        local -r volgrp="scrubs"
        local -r new_disk="/${disk_name_tag}/${disk_name_target}${disk_target_prefix}2"
        local -r disk_uuid=$(blkid -s UUID -o value /${disk_name_tag}/${disk_name_target}${disk_target_prefix}2)
        local -r tag="GRUB_CMDLINE_LINUX=\"\""
        local -r value="GRUB_CMDLINE_LINUX=\"cryptdevice=UUID=${disk_uuid}:${storage_name} root=\/dev\/mapper\/${volgrp}-ROOT\""

        arch-chroot /mnt sed -i "s/$tag/$value/g" /etc/default/grub
    fi
}