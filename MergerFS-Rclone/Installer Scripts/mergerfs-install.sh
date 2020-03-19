#!/bin/bash

if pgrep "mergerfs";
then
    echo "mergerfs is running. Please close all mergerfs instances before proceeding."
    exit
else
    echo "mergerfs is installing/upgrading..."
    mkdir -p "$HOME"/tmp
    wget https://github.com/trapexit/mergerfs/releases/download/2.29.0/mergerfs_2.29.0.debian-stretch_amd64.deb -P "$HOME"/tmp
    dpkg -x "$HOME"/tmp/mergerfs_2.29.0.debian-stretch_amd64.deb "$HOME"/tmp
    mv "$HOME"/tmp/usr/bin/* "$HOME"/bin
    rm -rf "$HOME"/tmp
    echo "Done."
    command -v mergerfs
    mergerfs -v
    echo "Install done. Restart all mergerfs mounts."
    exit
fi