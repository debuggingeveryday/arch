#!/bin/sh

# -- split string -- #

encrypt_partition() {
    IFS="/"
    read -a disk <<< $target_disk
    
    disk_name_tag="${disk[1]}"
    disk_name_target="${disk[2]}"
    
    umount -A --recursive /mnt
    swapoff -a
    
    wipefs --all --force /$disk_name_tag/$disk_name_target
    
    sgdisk -Z /$disk_name_tag/$disk_name_target
    sgdisk -a 2048 -o /$disk_name_tag/$disk_name_target
    
    sgdisk -n 1::+300M --typecode=1:ef02 --change-name=1:'BOOT' /$disk_name_tag/$disk_name_target
    sgdisk -n 2::-0 --typecode=2:8e00 --change-name=2:'ROOT' /$disk_name_tag/$disk_name_target
    
    echo -n "${password}" | cryptsetup -c aes-xts-plain64 -s 512 -h sha384 -i 2500 --use-random luksFormat /${disk_name_tag}/${disk_name_target}${disk_target_prefix}2 -
    echo -n "${password}" | cryptsetup open --type luks /${disk_name_tag}/${disk_name_target}${disk_target_prefix}2 shingha -
    
    pvcreate /$disk_name_tag/mapper/shingha
    vgcreate scrubs /$disk_name_tag/mapper/shingha
    
    lvcreate -l 100%FREE scrubs -n ROOT
    
    mkfs.ext4 /$disk_name_tag/mapper/scrubs-ROOT
    mount /$disk_name_tag/mapper/scrubs-ROOT /mnt
    
    mkdir /mnt/boot
    mount /${disk_name_tag}/${disk_name_target}${disk_target_prefix}1 /mnt/boot
}