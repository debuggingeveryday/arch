#!/bin/sh

<<<<<<< Updated upstream
declare -r disk=$($MAIN_PATH/util/split_string.sh $target_disk)

echo "${disk[@]}"

# umount -A --recursive /mnt
# swapoff -a
# wipefs --all --force /dev/${TARGET_DISK}

# sgdisk -Z /dev/${TARGET_DISK}
# sgdisk -a 2048 -o /dev/${TARGET_DISK}

# sgdisk -n 1::+300M --typecode=1:ef02 --change-name=1:'BOOT' /dev/${TARGET_DISK}
# sgdisk -n 2::-0 --typecode=2:8e00 --change-name=2:'ROOT' /dev/${TARGET_DISK}
=======
TARGET_DISK=$1
PASSWORD=$2
TARGET_DISK_PREFIX=""

# umount -A --recursive /mnt
umount -a
swapoff -a
wipefs --all --force ${TARGET_DISK}

sgdisk -Z ${TARGET_DISK}
sgdisk -a 2048 -o ${TARGET_DISK}

sgdisk -n 1::+300M --typecode=1:ef02 --change-name=1:'BOOT' ${TARGET_DISK}
sgdisk -n 2::-0 --typecode=2:8e00 --change-name=2:'ROOT' ${TARGET_DISK}

mkfs.fat -F32 ${TARGET_DISK}1

echo -n "${PASSWORD}" | cryptsetup -c aes-xts-plain64 -s 512 -h sha384 -i 2500 --use-random luksFormat ${TARGET_DISK}${TARGET_DISK_PREFIX}2 -
echo -n "${PASSWORD}" | cryptsetup open --type luks ${TARGET_DISK}${TARGET_DISK_PREFIX}2 shingha -
>>>>>>> Stashed changes

# mkfs.fat -F32 /dev/${TARGET_DISK}1

# echo -n "${PASSWORD}" | cryptsetup -c aes-xts-plain64 -s 512 -h sha384 -i 2500 --use-random luksFormat /dev/${TARGET_DISK}${TARGET_DISK_PREFIX}2 -
# echo -n "${PASSWORD}" | cryptsetup open --type luks /dev/${TARGET_DISK}${TARGET_DISK_PREFIX}2 shingha -

# pvcreate /dev/mapper/shingha
# vgcreate scrubs /dev/mapper/shingha

<<<<<<< Updated upstream
# lvcreate -l 100%FREE scrubs -n ROOT

# mkfs.ext4 /dev/mapper/scrubs-ROOT
# mount /dev/mapper/scrubs-ROOT /mnt

# mkdir /mnt/boot
# mount /dev/${TARGET_DISK}${TARGET_DISK_PREFIX}1 /mnt/boot
=======
mkdir /mnt/boot
mount ${TARGET_DISK}${TARGET_DISK_PREFIX}1 /mnt/boot
>>>>>>> Stashed changes
