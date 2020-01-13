#!/bin/bash

if pgrep "rclone";
then
    echo "Rclone is running. Please close all rclone instances before proceeding."
    exit
else
    echo "Installing/Upgrading rclone stable..."
    mkdir -p "$HOME"/.rclone-tmp
    cd "$HOME"/.rclone-tmp || exit
    wget -O rclone-current-linux-amd64.zip https://downloads.rclone.org/rclone-current-linux-amd64.zip
    unzip rclone-current-linux-amd64.zip
    cp rclone-v*/rclone ~/bin
    cd "$HOME" || exit
    rm -rf "$HOME"/.rclone-tmp
    echo "Done."
    command -v rclone
    rclone version
fi