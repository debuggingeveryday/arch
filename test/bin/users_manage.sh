#!/bin/sh

user_manage() {
    arch-chroot /mnt useradd -m -G sys,wheel,users,adm,log -s /bin/bash scrubs

    arch-chroot /mnt echo "root:${password}" | chpasswd
    arch-chroot /mnt echo "scrubs:${password}" | chpasswd
}