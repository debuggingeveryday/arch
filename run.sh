#!/bin/sh

./install_bash_modules.sh

./arch.sh --username "user" \
 --password "1234" \
 --hostname mynetdotnet \
 --kernel lts \
 --settings 0 \
 --target_disk /dev/sda \
 --is_encrypt true \
 --timezone Asia/Manila \