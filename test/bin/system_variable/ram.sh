#!/bin/sh

# ram size
total_ram=$(cat /proc/meminfo | grep MemTotal | awk '$1=="MemTotal:"{print $2}')
