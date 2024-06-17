#!/bin/sh

source $MAIN_PATH/bin/partition/encrypt.sh
source $MAIN_PATH/bin/partition/normal.sh
source $MAIN_PATH/util/debug.sh

partition() {
    if [[ "$ARCH_IS_ENCRYPT" == true ]]; then
        encrypt_partition
    else
        normal_partition
    fi
}