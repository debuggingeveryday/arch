
background () {
    pacman -Sy feh
    
    mkdir -p $HOME/feh
    cp $MAIN_PATH/window_manager/file_config/background/background-1.jpg $HOME/feh/background.jpg

    echo "
        feh --bg-scale $HOME/feh/background.jpg
        " >> ~/.bash_profile
}