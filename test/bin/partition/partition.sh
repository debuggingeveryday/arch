#!/bin/sh

partition() {
    if [[ "$is_encrypt" == true ]]; then
        $MAIN_PATH/bin/partition/encrypt.sh $target_disk $password
    else
        $MAIN_PATH/bin/partition/normal.sh $target_disk
    fi
}