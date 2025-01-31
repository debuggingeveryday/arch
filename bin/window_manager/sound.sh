#!/bin/sh

sound () {
    pacman -Sy --noconfirm --needed alsa-utils pulseaudio-alsa lib32-alsa-plugins &&
    pulseaudio --start
}