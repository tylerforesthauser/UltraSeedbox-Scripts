#!/bin/bash

if pgrep "rclone";
then
    echo "Rclone is running. Please close all rclone instances before proceeding."
    exit
else
    echo "Rclone is stopped. Proceeding..."
    sleep 3
fi

if pgrep "mergerfs";
then
    echo "mergerfs is running. Please close all mergerfs instances before proceeding."
    exit
else
    mkdir -p "$HOME"/.rclone-tmp
    cd "$HOME"/.rclone-tmp || exit
    wget -O rclone-v1.50.2-linux-amd64.zip https://downloads.rclone.org/v1.50.2/rclone-v1.50.2-linux-amd64.zip
    unzip rclone-v1.50.2-linux-amd64.zip
    cp rclone-v*/rclone "$HOME"/bin
    cd "$HOME" || exit
    rm -rf "$HOME"/.rclone-tmp
    command -v rclone
    rclone version
    mkdir -p "$HOME"/tmp
    wget https://github.com/trapexit/mergerfs/releases/download/2.28.3/mergerfs_2.28.3.debian-stretch_amd64.deb -P "$HOME"/tmp
    dpkg -x "$HOME"/tmp/mergerfs_2.28.3.debian-stretch_amd64.deb "$HOME"/tmp
    mv "$HOME"/tmp/usr/bin/* "$HOME"/bin
    rm -rf "$HOME"/tmp
    command -v mergerfs
    mergerfs -v
    exit
fi