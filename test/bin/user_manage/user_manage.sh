#!/bin/sh

source $MAIN_PATH/util/debug.sh

user_manage() {
    arch-chroot /mnt useradd -m -G sys,wheel,users,adm,log -s /bin/bash ${username}
    arch-chroot /mnt /bin/bash -c "echo 'root:${password}' | chpasswd"
    arch-chroot /mnt /bin/bash -c "echo '${username}:${password}' | chpasswd"
}