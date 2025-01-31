#!/bin/sh

eww_bar () {
    sudo pacman -Sy --noconfirm --needed rust libdbusmenu-glib libdbusmenu-gtk3 &&

    git clone https://github.com/elkowar/eww $DUMP_FILES_PATH/eww-bar &&
    cd $DUMP_FILES_PATH/eww-bar &&
    cargo build --release --no-default-features --features x11 &&
    cd target/release &&
    chmod +x $DUMP_FILES_PATH/eww-bar/eww &&

    sudo cp .$DUMP_FILES_PATH/eww-bar/eww /usr/local/bin &&

    cd ~/ &&

    mkdir -p $DUMP_FILES_PATH/.config/eww &&
    git clone https://github.com/debuggingeveryday/widgets.git $DUMP_FILES_PATH/.config/eww/widgets &&

    echo "
    $(cd $DUMP_FILES_PATH/Desktop/widgets && ./eww.sh) &
    " >> ~/.bash_profile
}