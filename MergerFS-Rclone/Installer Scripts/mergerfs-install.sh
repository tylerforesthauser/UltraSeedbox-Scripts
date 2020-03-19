#!/bin/bash

mgversion="$(curl -s https://api.github.com/repos/trapexit/mergerfs/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"

if pgrep "mergerfs";
then
    echo "mergerfs is running. Please close all mergerfs instances before proceeding."
    exit
else
    echo "mergerfs is installing/upgrading..."
    mkdir -p "$HOME"/tmp
    wget https://github.com/trapexit/mergerfs/releases/download/${mgversion}/mergerfs_${mgversion}.debian-stretch_amd64.deb -O "$HOME"/tmp/mergerfs.deb
    dpkg -x "$HOME"/tmp/mergerfs.deb "$HOME"/tmp
    mv "$HOME"/tmp/usr/bin/* "$HOME"/bin
    rm -rf "$HOME"/tmp
    echo "Done."
    command -v mergerfs
    mergerfs -v
    echo "Install done. Restart all mergerfs mounts."
    exit
fi