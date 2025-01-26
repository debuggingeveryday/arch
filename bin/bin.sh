#!/bin/sh

source $MAIN_PATH/bin/input_argument.sh
source $MAIN_PATH/bin/system_variable/system_variable.sh
source $MAIN_PATH/bin/populate_keyring.sh
source $MAIN_PATH/bin/set_date.sh
source $MAIN_PATH/bin/partition/partition.sh
source $MAIN_PATH/bin/base_package.sh
source $MAIN_PATH/bin/core.sh
source $MAIN_PATH/bin/grub_install/grub_install.sh
source $MAIN_PATH/bin/user_manage/user_manage.sh
source $MAIN_PATH/bin/keyboard.sh

# -- WINDOW MANAGER -- #
source $MAIN_PATH/bin/window_manager/bspwm_sxhkd.sh
source $MAIN_PATH/bin/window_manager/eww_bar.sh
source $MAIN_PATH/bin/window_manager/background.sh
source $MAIN_PATH/bin/window_manager/alacritty_legasture.sh
source $MAIN_PATH/bin/window_manager/sound.sh