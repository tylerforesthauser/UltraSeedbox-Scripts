#!/bin/bash

if pgrep "mergerfs";
then
    echo "mergerfs is running. Please close all mergerfs instances before proceeding."
    exit
else
    echo "mergerfs is installing/upgrading..."
    mkdir -p "$HOME"/tmp
    wget https://github.com/trapexit/mergerfs/releases/download/2.28.3/mergerfs_2.28.3.debian-stretch_amd64.deb -P "$HOME"/tmp
    dpkg -x "$HOME"/tmp/mergerfs_2.28.3.debian-stretch_amd64.deb "$HOME"/tmp
    mv "$HOME"/tmp/usr/bin/* "$HOME"/bin
    rm -rf "$HOME"/tmp
    echo "Done."
    command -v mergerfs
    mergerfs -v
    exit
fi