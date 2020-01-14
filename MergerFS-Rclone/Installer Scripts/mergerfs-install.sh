#!/bin/bash
mkdir -p ~/tmp
wget https://github.com/trapexit/mergerfs/releases/download/2.28.3/mergerfs_2.28.3.debian-stretch_amd64.deb -P ~/tmp
dpkg -x ~/tmp/mergerfs_2.28.3.debian-stretch_amd64.deb ~/tmp
mv ~/tmp/usr/bin/* ~/bin
rm -rf ~/tmp
which mergerfs
mergerfs -v
