#!/bin/sh

source $MAIN_PATH/util/remote.sh

user_manage() {
    remote useradd -m -G sys,wheel,users,adm,log -s /bin/bash scrubs
    cp $MAIN_PATH/bin/user_manage/user_manage.sh /mnt
    remote ./user_manage.sh
}