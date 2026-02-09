#!/bin/sh

source $MAIN_PATH/util/update_env.sh

function system_variables() {
source $MAIN_PATH/bin/system_variable/ram.sh
source $MAIN_PATH/bin/system_variable/wifi.sh
source $MAIN_PATH/bin/system_variable/cpu.sh
source $MAIN_PATH/bin/system_variable/gpu.sh
source $MAIN_PATH/bin/system_variable/verify_boot.sh

[[ "$target_disk" == *nvme* ]] && $disk_target_prefix="p"

declare -A variables

variables=(
    [CPU_TYPE]=$cpu_type 
    [GPU_TYPE]=$gpu_type 
    [RAM_SIZE]=$swap_size
    [BOOT_TYPE]=$boot_type
    [HAS_WIFI]=$has_wifi
)

for item in ${!variables[@]}; do
    export "$key"="${variables[$item]}"
    update_env "$item" "${variables[$item]}"
done
}
