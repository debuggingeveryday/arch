#!/bin/sh

load_bios() {
    arch-chroot /mnt grub-install /dev/sda
}