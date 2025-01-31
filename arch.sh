#!/bin/sh

export MAIN_PATH="$PWD"

mkdir $HOME/DUMP_FILES
export DUMP_FILES_PATH="$HOME/DUMP_FILES"

source ./bin/bin.sh

# -- my command --
# ./arch --username "user" --password "1234" --hostname mynetdotnet --kernel hardened --settings 0 --target_disk /dev/sda --is_encrypt true --timezone Asia/Manila

input_arguments $@ 

declare -a scripts=(
    load_keyboard_setting
    system_variables 
    populate_keyring 
    set_date 
    partition 
    base_package 
    # -- core ---
    modify_files 
    core_packages 
    start_services     
    user_manage 
    # -- window manager -- #
    window_manager 
    grub_install 
)

add_pause=false

declare -a count=0
for script in ${scripts[@]}; do
    count=$(($count+1))

    $script # excted from functions

   [[ $add_pause == true ]] && read -p "** ${count} - ${script} **"
done