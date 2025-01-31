#!/bin/sh

bspwm_sxhkd() {
    pacstrap /mnt --noconfirm --needed bspwm sxhkd xorg-xinit xorg-server xorg-xinit dunst ly alacritty dmenu neovim &&
    read -p "install packages"

    # copy config
    arch-chroot /mnt install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc /mnt/home/$username/.config/bspwm/bspwmrc && 
    arch-chroot /mnt install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc /mnt/home/$username/.config/sxhkd/sxhkdrc &&
    ls -la /mnt/home/$username/.config
    read -p "install bspwm sxhkd"
    
    arch-chroot /mnt cp /etc/X11/xinit/xinitrc /mnt/home/$username/.xinitrc &&
    ls -la /mnt/home/$username/.xinitrc
    read -p "copy xinit to home"

    cp -f $DUMP_FILES_PATH/window-manager/file_config/sxhkdrc /mnt/home/$username/.config/sxhkd/sxhkdrc &&
    cp -f $DUMP_FILES_PATH/window-manager/file_config/bspwmrc /mnt/home/$username/.config/bspwm/bspwmrc &&
    read -p "copying files"

    # enable service ly
    arch-chroot /mnt systemctl enable ly.service &&
    read -p "run services"

    # modify
    arch-chroot /mnt echo "
    bspwm &
    sxhkd &
    dusnt
    " >> ~/.xinitrc
    read -p "append script in xinit file"
}