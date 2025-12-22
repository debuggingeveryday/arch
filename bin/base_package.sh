#!/bin/sh

base_package() {
  local type="-${kernel}"
  pacstrap /mnt --noconfirm --needed base base-devel linux linux-firmware grub # (optional) os-prober
  [[ "$boot_type" == "UEFI" ]] && pacstrap /mnt --noconfirm --needed efibootmgr
}

