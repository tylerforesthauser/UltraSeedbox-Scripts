#!/bin/bash

if pgrep "rclone";
then
    echo "Rclone is running. Please close all rclone instances before proceeding."
    exit
else
    echo "Installing/Upgrading to rclone 1.50.2..."
    mkdir -p "$HOME"/.rclone-tmp
    cd "$HOME"/.rclone-tmp || exit
    wget -O rclone-v1.50.2-linux-amd64.zip https://downloads.rclone.org/rclone-v1.50.2-linux-amd64.zip
    unzip rclone-v1.50.2-linux-amd64.zip
    cp rclone-v*/rclone ~/bin
    cd "$HOME" || exit
    rm -rf "$HOME"/.rclone-tmp
    echo "Done. Start"
    command -v rclone
    rclone version
fi