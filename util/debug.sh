#!/bin/sh

debug() {
    echo "---------------------------------------------------" >> logfile.txt
    $@ >> logfile.txt 2>&1
}