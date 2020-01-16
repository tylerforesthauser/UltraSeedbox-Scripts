#!/bin/bash
#USB Mellow Installer
#Written by Alpha#5000

IP=$(curl -s "https://ipinfo.io/ip")
PORT=$(( 11000 + (($UID - 1000) * 50) + 30))

if [ ! -d "$HOME/.nvm" ]
then
    echo "Installing Node..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm install 13.6.0 --latest-npm
    nvm alias default 13.6.0
    nvm use default
else
    echo "Node already installed. Skipping..."
fi

echo "Installing Mellow..."
git clone "https://github.com/v0idp/Mellow.git" "$HOME/.apps/mellow"
cd "$HOME/.apps/mellow" || exit
npm install --loglevel=silent

echo "Configuring Mellow..."
sed -i "s/5060/$PORT/g" "$HOME/.apps/mellow/src/WebServer.js"

echo "Installing Service..."
echo "[Unit]
Description=Mellow
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=on-failure
RestartSec=10
WorkingDirectory=$HOME/.apps/mellow
ExecStart=$(command -v node) src/index.js

[Install]
WantedBy=default.target" >> "$HOME/.config/systemd/user/mellow.service"
systemctl --user daemon-reload
systemctl --user enable mellow

loginctl enable-linger "$USER"

echo "Starting Mellow..."
systemctl --user start mellow

echo "Downloading Upgrade and Uninstall scripts..."
cd "$HOME" || exit
wget https://raw.githubusercontent.com/no5tyle/UltraSeedbox-Scripts/master/Mellow/mellow-uninstall.sh
wget https://raw.githubusercontent.com/no5tyle/UltraSeedbox-Scripts/master/Mellow/mellow-upgrade.sh
chmod +x mellow-uninstall.sh
chmod +x mellow-upgrade.sh

echo "Cleaning Up..."
rm -- "$0"

printf "\033[0;32mDone!\033[0m\n"
echo "Access your Mellow installation at http://$IP:$PORT"
echo "Run ./mellow-upgrade.sh to upgrade."
echo "Run ./mellow-uninstall.sh to uninstall."