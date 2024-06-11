#!/bin/sh

# -- split string -- #

normal_partition() {
    IFS="/"
    read -a disk <<< $target_disk

    disk_name_tag="${disk[1]}"
    disk_name_target="${disk[2]}"

    umount -a
    umount -A --recursive /mnt
    swapoff -a
    wipefs --all --force /$disk_name_tag/$disk_name_target

    sgdisk -Z /$disk_name_tag/$disk_name_target
    sgdisk -a 2048 -o /$disk_name_tag/$disk_name_target

    sgdisk -n 1::+512M --typecode=1:ef00 --change-name=1:'BOOT' /$disk_name_tag/$disk_name_target
    # sgdisk -n 2::-0 --typecode=2:8300 --change-name=2:'ROOT' /dev/sda -- pc bonbon desktop
    sgdisk -n 2::-0 --typecode=2:8304 --change-name=2:'ROOT' /$disk_name_tag/$disk_name_target

    mkfs.fat -F32 /${disk_name_tag}/${disk_name_target}1
    mkfs.ext4 /${disk_name_tag}/${disk_name_target}2

    mount /${disk_name_tag}/${disk_name_target}2 /mnt

    mkdir -p /mnt/boot
    mount /${disk_name_tag}/${disk_name_target}1 /mnt/boot

}