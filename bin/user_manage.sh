#!/bin/sh

source $MAIN_PATH/util/debug.sh

user_manage() {
    arch-chroot /mnt useradd -m -G sys,wheel,users,adm,log -s /bin/bash ${ARCH_USERNAME}
    arch-chroot /mnt /bin/bash -c "echo 'root:${ARCH_PASSWORD}' | chpasswd"
    arch-chroot /mnt /bin/bash -c "echo '${ARCH_USERNAME}:${ARCH_PASSWORD}' | chpasswd"
}