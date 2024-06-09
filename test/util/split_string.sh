#!/bin/sh

IFS="/"
split_string=$1

read -a array <<< $split_string
echo "${array[@]}"