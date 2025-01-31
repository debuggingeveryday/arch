#!/bin/sh

source $MAIN_PATH/bin/window_manager/sound.sh
source $MAIN_PATH/bin/window_manager/eww_bar.sh
source $MAIN_PATH/bin/window_manager/bspwm_sxhkd.sh
source $MAIN_PATH/bin/window_manager/alacritty_ligature.sh
source $MAIN_PATH/bin/window_manager/background.sh

window_manager () {
    bspwm_sxhkd
}