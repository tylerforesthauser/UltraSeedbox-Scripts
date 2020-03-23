#!/bin/bash

echo "Creating necessary folders..."
    mkdir -p "$HOME"/Stuff
    mkdir -p "$HOME"/Stuff/Local
    mkdir -p "$HOME"/Stuff/Mount
    mkdir -p "$HOME"/MergerFS
    mkdir -p "$HOME"/scripts
    mkdir -p "$HOME"/.config/systemd/user
echo "Stopping service files..."
    systemctl --user disable --now mergerfs.service
    systemctl --user disable --now rclone-vfs.service
    systemctl --user disable --now rclone-normal.service
echo "Removing service files..."
    cd "$HOME"/.config/systemd/user || exit
    rm rclone*
    rm mergerfs*
echo "Installing rclone..."
    mkdir -p "$HOME"/.rclone-tmp
    cd "$HOME"/.rclone-tmp || exit
    wget https://raw.githubusercontent.com/no5tyle/UltraSeedbox-Scripts/master/MergerFS-Rclone/IOWAIT-Fix/rclone%20binary/rclone-1.51.1-linux-amd64.zip
    unzip rclone-1.51.1-linux-amd64.zip
    cp rclone-v*/rclone "$HOME"/bin
    cd "$HOME" || exit
    rm -rf "$HOME"/.rclone-tmp
    command -v rclone
    rclone version
    sleep 2
echo "Done. Installing mergerfs..."
    sleep 3
    mkdir -p "$HOME"/tmp
    wget https://github.com/trapexit/mergerfs/releases/download/2.28.3/mergerfs_2.28.3.debian-stretch_amd64.deb -P "$HOME"/tmp
    dpkg -x "$HOME"/tmp/mergerfs_2.28.3.debian-stretch_amd64.deb "$HOME"/tmp
    mv "$HOME"/tmp/usr/bin/* "$HOME"/bin
    rm -rf "$HOME"/tmp
    command -v mergerfs
    mergerfs -v
    sleep 2
echo "Done. Downloading service files..."
    sleep 3
    cd "$HOME"/.config/systemd/user || exit
    wget https://raw.githubusercontent.com/no5tyle/UltraSeedbox-Scripts/master/MergerFS-Rclone/IOWAIT-Fix/Service%20Files/rclone-vfs.service
    wget https://raw.githubusercontent.com/no5tyle/UltraSeedbox-Scripts/master/MergerFS-Rclone/Service%20Files/mergerfs.service 
    sed -i "s#/homexx/yyyyy#$HOME#g" "$HOME"/.config/systemd/user/rclone-vfs.service
    sed -i "s#/homexx/yyyyy#$HOME#g" "$HOME"/.config/systemd/user/mergerfs.service

echo "Starting services..."
    systemctl --user daemon-reload
    systemctl --user enable --now rclone-vfs.service
    systemctl --user enable --now mergerfs.service

echo "Downloading upload script...."
echo "Also removing any existing upload scripts..."
    sleep 3
    cd "$HOME"/scripts || exit
    rm rclone*
    wget https://raw.githubusercontent.com/no5tyle/UltraSeedbox-Scripts/master/MergerFS-Rclone/Upload%20Scripts/rclone-upload.sh
    chmod +x rclone-upload.sh

echo "Done. The full path of the upload script is shown below."
echo "========================================="
echo "$HOME"/scripts/rclone-upload.sh
echo "========================================="
echo "Add this to your crontab by doing crontab -e and add the following (assuming you want daily run)"
echo "============================================================"
echo "@daily $HOME/scripts/rclone-upload.sh > /dev/null 2>&1"
echo "============================================================"
echo "Enjoy"
cd "$HOME" || exit
exit