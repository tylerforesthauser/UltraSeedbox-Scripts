#!/bin/bash
#USB Mellow Uninstaller
#Written by Alpha#5000

echo "Stopping Mellow..."
systemctl --user stop mellow

echo "Removing Files..."
rm -rf "$HOME/.apps/mellow"

echo "Removing Service..."
rm "$HOME/.config/systemd/user/mellow.service"
systemctl --user daemon-reload

echo "Cleaning Up..."

rm -- "$0"

echo "Done!"
