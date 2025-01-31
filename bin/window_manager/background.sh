
background () {
    pacman -Sy --noconfirm --needed feh
    
    mkdir -p $DUMP_FILES_PATH/feh
    cp $MAIN_PATH/window_manager/file_config/background/background-1.jpg $DUMP_FILES_PATH/feh/background.jpg

    echo "
        feh --bg-scale $DUMP_FILES_PATH/feh/background.jpg
        " >> ~/.bash_profile
}