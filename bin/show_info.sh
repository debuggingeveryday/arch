#!/bin/sh

check_environment_variables() {
    printenv | grep -w -E "^ARCH_[A-Z_\=]+"
    # read -p ""
}
