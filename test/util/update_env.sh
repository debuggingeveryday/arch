#!/bin/bash

update_env() {
    variable=$1
    old_value=$(cat .env | grep "$variable" | cut -d'=' -f2)
    new_value=$2

    if [[ -f ".env" ]]; then
        if  [[ $( cat .env | grep "$variable=" ) ]]; then
            sed -i "s|'$variable=$old_value'|$variable=$new_value|g" .env
        else
            echo "$variable=$new_value" >> .env
        fi
    else
        echo "$1=$2" >> .env
    fi
}