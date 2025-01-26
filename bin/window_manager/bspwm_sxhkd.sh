#!/bin/sh

bspwm_sxhkd() {
    pacman -Sy bspwm sxhkd xorg-xinit xorg-server xorg-xinit dunst ly alacritty dmenu neovim &&

    # copy config
    install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc $HOME/.config/bspwm/bspwmrc && 
    install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc $HOME/.config/sxhkd/sxhkdrc &&
    cp /etc/X11/xinit/xinitrc ~/.xinitrc &&
    cp -f $HOME/window-manager/file_config/sxhkdrc ~/.config/sxhkd/sxhkdrc &&
    cp -f $HOME/window-manager/file_config/bspwmrc ~/.config/bspwm/bspwmrc &&

    # enable service ly
    systemctl enable ly.service &&

    # modify
    echo "
    bspwm &
    sxhkd &
    dusnt
    " >> ~/.xinitrc
}