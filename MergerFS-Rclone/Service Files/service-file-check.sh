#!/bin/bash

echo "What do you want to do?"
echo "1) Show ExecStart"
echo "2) Show ExecStop"
echo "3) Execute ExecStart"
echo "4) Exit"
read -r -p "Select an option: " option

case $option in
  1)
    input="y"
    while [ "$input" = "y" ]
    do
    cat "$HOME"/.config/systemd/user/rclone-vfs.service | sed -n '/^ExecStart=/,$p' | sed -n '/^ExecStop=/q;p' | sed 's/^ExecStart=//g'
    done
    ;;
  2)
    input="y"
    while [ "$input" = "y" ]
    do
    cat "$HOME"/.config/systemd/user/rclone-vfs.service | sed -n '/^ExecStop=/,$p' | sed -n '/^Restart=/q;p' | sed 's/^ExecStop=//g'
    done
    ;;
  3)
    input="y"
    while [ "$input" = "y" ]
    do
    cat "$HOME"/.config/systemd/user/rclone_vfs.service | sed -n '/^ExecStart=/,$p' | sed -n '/^ExecStop=/q;p' | sed 's/^ExecStart=//g' | bash
    done
    ;;
  4)
    exit
    ;;
esac