#!/bin/bash

plugindir=~/.config/plex/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/

if [ ! -d "$HOME/.config/plex/" ];
then
    echo "Plex is not installed. Exiting..."
    exit
fi

echo "Installing WebTools..."
cd "$plugindir" || exit
git clone https://github.com/ukdtom/WebTools.bundle.git
app-plex restart
sleep 15
echo "Webtools installed!"
exit