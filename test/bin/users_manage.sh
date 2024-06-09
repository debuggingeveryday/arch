#!/bin/sh

source $MAIN_PATH/util/remote.sh

user_manage() {
    remote useradd -m -G sys,wheel,users,adm,log -s /bin/bash scrubs
    remote echo "root:${password}" | chpasswd
    remote echo "scrubs:${password}" | chpasswd
}