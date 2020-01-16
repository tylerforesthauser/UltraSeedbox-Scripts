#!/bin/bash

if [ -d "$HOME/.apps/mellow" ]
then
    echo "Upgrading node..."
    npm update -g
    echo "Upgrading mellow..."
    systemctl --user stop mellow.service
    cd "$HOME/.apps/mellow" || exit
    git pull
    npm install --loglevel=silent
    cd "$HOME" || exit
    systemctl --user start mellow.service
    rm -- "$0"
    echo "Done."
    exit
else
    echo "Mellow not found."
    exit
fi