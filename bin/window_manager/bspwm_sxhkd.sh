#!/bin/sh

bspwm_sxhkd() {
    pacstrap /mnt --noconfirm --needed bspwm sxhkd xorg-xinit xorg-server xorg-xinit dunst ly alacritty dmenu neovim &&

    # copy config
    install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc $DUMP_FILES_PATH/.config/bspwm/bspwmrc && 
    install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc $DUMP_FILES_PATH/.config/sxhkd/sxhkdrc &&
    
    cp /etc/X11/xinit/xinitrc ~/.xinitrc &&
    cp -f $DUMP_FILES_PATH/window-manager/file_config/sxhkdrc ~/.config/sxhkd/sxhkdrc &&
    cp -f $DUMP_FILES_PATH/window-manager/file_config/bspwmrc ~/.config/bspwm/bspwmrc &&

    # enable service ly
    systemctl enable ly.service &&

    # modify
    echo "
    bspwm &
    sxhkd &
    dusnt
    " >> ~/.xinitrc
}