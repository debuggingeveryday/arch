#!/bin/sh

source $MAIN_PATH/bin/partition/encrypt.sh
source $MAIN_PATH/bin/partition/normal.sh

partition() {
    if [[ "$is_encrypt" == true ]]; then
        encrypt_partition
    else
        normal_partition
    fi
}