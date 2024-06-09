#!/bin/sh

echo "root:${password}" | chpasswd
echo "scrubs:${password}" | chpasswd