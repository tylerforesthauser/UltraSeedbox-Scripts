#!/bin/bash

lock_file="$HOME/rclone.lock"
name=rclone

trap 'rm -f "$lock_file"; exit 0' SIGINT SIGTERM
if [ -e "$lock_file" ]
then
    echo "$name is already running."
    exit
else
    touch "$lock_file"
    "$HOME"/bin/rclone move "$HOME"/Stuff/Local/ gdrive: --config="$HOME"/.config/rclone/rclone.conf --drive-chunk-size 128M --tpslimit 4 --drive-acknowledge-abuse=true -vvv --delete-empty-src-dirs --fast-list --bwlimit=8M --drive-stop-on-upload-limit true --use-mmap --transfers=2 --checkers=4 --log-file "$HOME"/scripts/rclone-sync.log
    rm -f "$lock_file"
    trap - SIGINT SIGTERM
    exit
fi