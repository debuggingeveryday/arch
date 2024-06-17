#!/bin/sh

# -- split string -- #

encrypt_partition() {
    local -r disk=$(echo "${ARCH_TARGET_DISK}" | sed "s/\// /g")
    local -r disk_name_tag=$(echo "$disk" | awk '{print $1}')
    local -r disk_name_target=$(echo "$disk" | awk '{print $2}')
    local disk_target_prefix=""

    if [[ "$disk_name_target" == "nvme0n1" ]]; then
        disk_target_prefix="p"
    fi
    
    umount -A --recursive /mnt
    swapoff -a
    
    wipefs --all --force /$disk_name_tag/$disk_name_target
    
    sgdisk -Z /$disk_name_tag/$disk_name_target
    sgdisk -a 2048 -o /$disk_name_tag/$disk_name_target
    
    sgdisk -n 1::+300M --typecode=1:ef02 --change-name=1:'BOOT' /$disk_name_tag/$disk_name_target
    sgdisk -n 2::-0 --typecode=2:8e00 --change-name=2:'ROOT' /$disk_name_tag/$disk_name_target
    
    mkfs.fat -F32 /${disk_name_tag}/${disk_name_target}${disk_target_prefix}1

    echo -n "${password}" | cryptsetup -c aes-xts-plain64 -s 512 -h sha384 -i 2500 --use-random luksFormat /${disk_name_tag}/${disk_name_target}${disk_target_prefix}2 -
    echo -n "${password}" | cryptsetup open --type luks /${disk_name_tag}/${disk_name_target}${disk_target_prefix}2 shingha -
    
    pvcreate /$disk_name_tag/mapper/shingha
    vgcreate scrubs /$disk_name_tag/mapper/shingha
    
    lvcreate -l 100%FREE scrubs -n ROOT
    
    mkfs.ext4 /$disk_name_tag/mapper/scrubs-ROOT
    mount /$disk_name_tag/mapper/scrubs-ROOT /mnt
    
    mkdir -p /mnt/boot
    mount /${disk_name_tag}/${disk_name_target}${disk_target_prefix}1 /mnt/boot

    # read -p "check disk /mnt/boot is mounted?"
}