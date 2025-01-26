#!/bin/sh

eww_bar () {
    sudo pacman -Sy rust libdbusmenu-glib libdbusmenu-gtk3 &&

    git clone https://github.com/elkowar/eww $HOME/eww-bar &&
    cd $HOME/eww-bar &&
    cargo build --release --no-default-features --features x11 &&
    cd target/release &&
    chmod +x $HOME/eww-bar/eww &&

    sudo cp .$HOME/eww-bar/eww /usr/local/bin &&

    cd ~/ &&

    mkdir -p $HOME/.config/eww &&
    git clone https://github.com/debuggingeveryday/widgets.git $HOME/.config/eww/widgets &&

    echo "
    $(cd $HOME/Desktop/widgets && ./eww.sh) &
    " >> ~/.bash_profile &&
}