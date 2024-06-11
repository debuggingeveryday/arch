#!/bin/sh

[[ -f "variable.conf"  ]] && source /variable.conf

useradd -m -G sys,wheel,users,adm,log -s /bin/bash "${USERNAME}"
echo "root:${PASSWORD}" | chpasswd
echo "${USERNAME}:${PASSWORD}" | chpasswd