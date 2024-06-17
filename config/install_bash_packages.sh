#!/bin/sh

install_bash_packages() {
    git clone https://github.com/jtplaarj/IceCream-Bash.git $MAIN_PATH/bash_modules/IceCream-Bash
    git clone https://github.com/yaacov/argparse-sh.git $MAIN_PATH/bash_modules/argparse-sh
}

load_bash_package() {
    source $MAIN_PATH/bash_modules/argparse-sh/argparse.sh
    source $MAIN_PATH/bash_modules/IceCream-Bash/src/ic.sh
}