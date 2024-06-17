#!/bin/sh

source $MAIN_PATH/util/update_env.sh
source $MAIN_PATH/bin/system_variable/ram.sh
source $MAIN_PATH/bin/system_variable/wifi.sh
source $MAIN_PATH/bin/system_variable/cpu.sh
source $MAIN_PATH/bin/system_variable/gpu.sh
source $MAIN_PATH/bin/system_variable/verify_boot.sh

function system_variables() {
    local -A variables

    variables=(
        [ARCH_CPU_TYPE]=$cpu_type 
        [ARCH_GPU_TYPE]=$gpu_type 
        [ARCH_RAM_SIZE]=$swap_size
        [ARCH_BOOT_TYPE]=$boot_type
        [ARCH_HAS_WIFI]=$has_wifi
    )

    for item in ${!variables[@]}; do
        key="$item"
        value="${variables[$item]}"
        update_env "$item" "${value}"
        export "$key"="$value"
    done
}