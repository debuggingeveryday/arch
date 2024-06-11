#!/bin/sh

populate_keyring() {
    pacman-key --init
    pacman-key --populate
}