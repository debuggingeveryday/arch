#!/bin/sh

source $MAIN_PATH/util/remote.sh

load_bios() {
    remote grub-install /dev/sda
}