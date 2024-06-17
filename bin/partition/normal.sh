#!/bin/sh

# -- split string -- #
source $MAIN_PATH/util/debug.sh

normal_partition() {
    local -r disk=$(echo "${ARCH_TARGET_DISK}" | sed "s/\// /g")
    local -r disk_name_tag=$(echo "$disk" | awk '{print $1}')
    local -r disk_name_target=$(echo "$disk" | awk '{print $2}')
    local disk_target_prefix=""

    if [[ "$disk_name_target" == "nvme0n1" ]]; then
        disk_target_prefix="p"
    fi

    umount -a
    umount -A --recursive /mnt
    swapoff -a
    wipefs --all --force /$disk_name_tag/$disk_name_target

    sgdisk -Z /$disk_name_tag/$disk_name_target
    sgdisk -a 2048 -o /$disk_name_tag/$disk_name_target

    sgdisk -n 1::+512M --typecode=1:ef00 --change-name=1:'BOOT' /$disk_name_tag/$disk_name_target
    # sgdisk -n 2::-0 --typecode=2:8300 --change-name=2:'ROOT' /dev/sda -- pc bonbon desktop
    sgdisk -n 2::-0 --typecode=2:8304 --change-name=2:'ROOT' /$disk_name_tag/$disk_name_target

    mkfs.fat -F32 /${disk_name_tag}/${disk_name_target}${disk_target_prefix}1
    mkfs.ext4 /${disk_name_tag}/${disk_name_target}${disk_target_prefix}2

    mount /${disk_name_tag}/${disk_name_target}${disk_target_prefix}2 /mnt

    mkdir -p /mnt/boot
    mount /${disk_name_tag}/${disk_name_target}${disk_target_prefix}1 /mnt/boot

}