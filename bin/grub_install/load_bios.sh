#!/bin/sh

load_bios() {
    local -r disk=$(echo "${ARCH_TARGET_DISK}" | sed "s/\// /g")
    local -r disk_name_tag=$(echo "$disk" | awk '{print $1}')
    local -r disk_name_target=$(echo "$disk" | awk '{print $2}')

    arch-chroot /mnt grub-install /${disk_name_tag}/${disk_name_target}
}