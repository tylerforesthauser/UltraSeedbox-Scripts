#!/bin/bash

# Rclone VFS/MergerFS Script by Xan#7777
# Custom rclone binary provided by Fionera#2342

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

echo "Killing all rclone/mergerfs instances..."
    killall rclone
    killall mergerfs

echo "Removing service files and old binaries..."
    cd "$HOME"/.config/systemd/user || exit
    rm rclone*
    rm mergerfs*
    cd "$HOME"/bin || exit
    rm rclone
    rm mergerfs

echo "Installing rclone..."
    mkdir -p "$HOME"/.rclone-tmp
    cd "$HOME"/.rclone-tmp || exit
    wget https://raw.githubusercontent.com/no5tyle/UltraSeedbox-Scripts/master/MergerFS-Rclone/IOWAIT-Fix/rclone%20binary/rclone-1.51.1-linux-amd64.zip
    unzip rclone-1.51.1-linux-amd64.zip
    cp "$HOME"/.rclone-tmp/rclone-1.51.1-linux-amd64/rclone "$HOME"/bin
    cd "$HOME" || exit
    rm -rf "$HOME"/.rclone-tmp
    command -v rclone
    rclone version
echo ""
sleep 2
echo "Done. Installing mergerfs..."
    sleep 2
    mkdir -p "$HOME"/tmp
    wget https://github.com/trapexit/mergerfs/releases/download/2.28.3/mergerfs_2.28.3.debian-stretch_amd64.deb -P "$HOME"/tmp
    dpkg -x "$HOME"/tmp/mergerfs_2.28.3.debian-stretch_amd64.deb "$HOME"/tmp
    mv "$HOME"/tmp/usr/bin/* "$HOME"/bin
    rm -rf "$HOME"/tmp
    command -v mergerfs
    mergerfs -v
echo ""
sleep 2
echo "Done. Downloading service files..."
    sleep 2
    cd "$HOME"/.config/systemd/user || exit
    wget https://raw.githubusercontent.com/no5tyle/UltraSeedbox-Scripts/master/MergerFS-Rclone/IOWAIT-Fix/Service%20Files/rclone-vfs.service
    wget https://raw.githubusercontent.com/no5tyle/UltraSeedbox-Scripts/master/MergerFS-Rclone/Service%20Files/mergerfs.service 
    sed -i "s#/homexx/yyyyy#$HOME#g" "$HOME"/.config/systemd/user/rclone-vfs.service
    sed -i "s#/homexx/yyyyy#$HOME#g" "$HOME"/.config/systemd/user/mergerfs.service

echo "Starting services..."
    systemctl --user daemon-reload
    systemctl --user enable --now rclone-vfs.service
    systemctl --user enable --now mergerfs.service
echo ""
sleep 5
echo ""
echo "Downloading upload script...."
echo "Also removing any existing upload scripts..."
    sleep 2
    cd "$HOME"/scripts || exit
    rm rclone*
    wget https://raw.githubusercontent.com/no5tyle/UltraSeedbox-Scripts/master/MergerFS-Rclone/Upload%20Scripts/rclone-upload.sh
    chmod +x rclone-upload.sh

echo ""
echo "Done."
echo ""
echo "The full path of the upload script is shown below."
echo ""
echo "========================================="
echo "$HOME"/scripts/rclone-upload.sh
echo "========================================="
echo ""
echo "Add this to your crontab by doing crontab -e and add the following (assuming you want daily run)"
echo ""
echo "============================================================"
echo "@daily $HOME/scripts/rclone-upload.sh > /dev/null 2>&1"
echo "============================================================"
echo ""
echo "Your rclone mount is in $HOME/Stuff/Mount and your local folder is in $HOME/Stuff/Local"
echo ""
echo "Your MergerFS Folder is in $HOME/MergerFS"
echo ""
echo "Enjoy"
cd "$HOME" || exit
exit