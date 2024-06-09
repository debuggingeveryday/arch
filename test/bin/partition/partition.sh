#!/bin/sh

partition() {
    $is_encrypt=$2
    if [[ $is_encrypt ]]; then
        $MAIN_PATH/bin/partition/encrypt.sh
    else
        $MAIN_PATH/bin/partition/normal.sh
    fi
}