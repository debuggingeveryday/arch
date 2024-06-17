#!/bin/sh

source $MAIN_PATH/util/update_env.sh

input_arguments () {

    # @username :string
    # @password :string
    # @hostname :string
    # @kernel :enum['linux','linux-lts','linux-hardened']
    # @settings :integer
    # - 0: ['xorg', 'bspwm']
    # @disk :enum['{sd*}', '{nvme0n*p*}']
    # @encrypt-drive :boolean
    # @timezone :enum['{Region}/{Capital}']
    # @swap :boolean

    # ** System variables **
    # @gpu_type :enum['nvidia', 'amd', 'intel']
    # @ram_size :int
    # @cpu_type :enum['amd', 'intel']
    # @battery :boolean


    # [Optional] Set script description
    set_description "This is a simple script that greets the user."

    # Define an argument
    define_arg "username" "" "Enter a username" "string" "true"
    define_arg "password" "" "Enter a password" "string" "true"
    define_arg "hostname" "" "Enter a hostname" "string" "true"
    define_arg "kernel" "" "Enter a hostname" "string" "false"
    define_arg "settings" "0" "Enter a settings" "integer" "true"
    define_arg "target_disk" "" "Enter a target disk" "string" "true"
    define_arg "is_encrypt" "" "Enter a encrypt" "string" "true"
    define_arg "timezone" "" "Enter a timezone" "string" "true"

    # [Optional] Check for -h and --help
    check_for_help "$@"

    # show_help $@

    # Parse the arguments
    parse_args "$@"

    # Store to config

    local -A variables

    variables=(
        [USERNAME]=$username 
        [PASSWORD]=$password 
        [HOSTNAME]=$hostname 
        [KERNEL]=$kernel 
        [SETTINGS]=$settings 
        [TARGET_DISK]=$target_disk 
        [IS_ENCRYPT]=$is_encrypt 
        [TIMEZONE]=$timezone
    )

    for item in ${!variables[@]}; do
        if [[ -n "$item" ]]; then
            update_env "$item" "${variables[$item]}"
        else
            update_env "$item" "--"
        fi
    done
}