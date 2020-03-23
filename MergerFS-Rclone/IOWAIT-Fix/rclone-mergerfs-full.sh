#!/bin/bash

if pgrep "rclone" && pgrep "mergerfs";
then
    echo "Rclone and/or mergerfs is running. Please close all instances before proceeding."
    echo "Make sure all apps that are connected to MergerFS are stopped before running this again"
    exit
else
    echo "Continuing installation..."
    sleep 2
fi

echo "Creating necessary folders..."
    mkdir -p "$HOME"/Stuff
    mkdir -p "$HOME"/Stuff/Local
    mkdir -p "$HOME"/Stuff/Mount
    mkdir -p "$HOME"/MergerFS
    mkdir -p "$HOME"/scripts
    mkdir -p "$HOME"/.config/systemmd/user
echo "Stopping service files..."
    systemctl --user disable --now rclone-vfs.service
    systemctl --user disable --now rclone-normal.service
    systemctl --user disable --now mergerfs.service
echo "Removing service files..."
    cd "$HOME"/.config/systemd/user || exit
    rm rclone*
    rm mergerfs
echo "Installing rclone..."
    mkdir -p "$HOME"/.rclone-tmp
    cd "$HOME"/.rclone-tmp || exit
    wget -O rclone-v1.50.2-linux-amd64.zip https://raw.githubusercontent.com/no5tyle/UltraSeedbox-Scripts/master/MergerFS-Rclone/IOWAIT-Fix/rclone/rclone-1.51.1-linux-amd64.zip
    unzip rclone-1.51.1-linux-amd64.zip
    cp rclone-v*/rclone "$HOME"/bin
    cd "$HOME" || exit
    rm -rf "$HOME"/.rclone-tmp
    command -v rclone
    rclone version
echo "Done. Installing mergerfs..."
    sleep 3
    mkdir -p "$HOME"/tmp
    wget https://github.com/trapexit/mergerfs/releases/download/2.28.3/mergerfs_2.28.3.debian-stretch_amd64.deb -P "$HOME"/tmp
    dpkg -x "$HOME"/tmp/mergerfs_2.28.3.debian-stretch_amd64.deb "$HOME"/tmp
    mv "$HOME"/tmp/usr/bin/* "$HOME"/bin
    rm -rf "$HOME"/tmp
    command -v mergerfs
    mergerfs -v
echo "Done. Downloading service files..."
    sleep 3
    wget https://raw.githubusercontent.com/no5tyle/UltraSeedbox-Scripts/master/MergerFS-Rclone/IOWAIT-Fix/Service%20Files/rclone-vfs.service "$HOME"/.config/systemd/user
    wget https://raw.githubusercontent.com/no5tyle/UltraSeedbox-Scripts/master/MergerFS-Rclone/Service%20Files/mergerfs.service "$HOME"/.config/systemd/user

echo "Done. Edit the rclone-vfs systemd file according to the absolute path."
echo "Displayed below is your seedbox's absolute path."
echo "==============="
echo "$HOME"
echo "==============="
echo "Replace all /homexx/yyyyy with $HOME"
echo "Make sure you replace those only or service file will fail."
echo "Once that's done, save it by doing CTRL + O"
echo "Then exit by doing CTRL + X."
echo "Installation will continue..."
sleep 5
nano "$HOME"/.config/systemd/user/rclone-vfs.service

echo "Done. Edit the meergerfs systemd file according to the absolute path."
echo "Displayed below is your seedbox's absolute path."
echo "==============="
echo "$HOME"
echo "==============="
echo "Replace all /homexx/yyyyy with $HOME"
echo "Make sure you replace those only or service file will fail."
echo "Once that's done, save it by doing CTRL + O"
echo "Then exit by doing CTRL + X."
echo "Installation will continue..."
sleep 5
nano "$HOME"/.config/systemd/user/mergerfs.service

echo "Starting services..."
    systemctl --user daemon-reload
    systemctl --user enable --now rclone-vfs.service
    systemctl --user enable --now mergerfs.service

echo "Downloading upload script...."
echo "Also removing any existing upload scripts..."
    cd "$HOME"/scripts || exit
    rm rclone*
    wget https://raw.githubusercontent.com/no5tyle/UltraSeedbox-Scripts/master/MergerFS-Rclone/Upload%20Scripts/rclone-upload.sh
    chmod +x rclone-upload.sh

echo "Done. The full path of the upload script is shown below. Add this to your crontab."
echo "========================="
echo "$HOME"/scripts/rclone-upload.sh
echo "========================="
echo "Enjoy"
exit