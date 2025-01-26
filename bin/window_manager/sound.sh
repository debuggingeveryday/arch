#!/bin/sh

sound () {
    pacman -Sy alsa-utils pulseaudio-alsa lib32-alsa-plugins &&
    pulseaudio --start
}