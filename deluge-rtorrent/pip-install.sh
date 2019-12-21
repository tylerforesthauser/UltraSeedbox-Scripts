#!/bin/bash
python3 <(curl https://bootstrap.pypa.io/get-pip.py) --user
which pip2
which pip3
sed -i -e 's#PATH="$HOME/bin:$PATH"#PATH="$HOME/bin:$HOME/.local/bin:$PATH"#g' ~/.profile
source .profile
exit
