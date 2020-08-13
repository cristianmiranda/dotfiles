#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# See https://int3ractive.com/2018/09/make-the-best-of-MacBook-touchpad-on-Ubuntu.html
ls /usr/share/X11/xorg.conf.d/80-macbook-trackpad.conf && echo 'mtrack & dispad already installed ' && exit 0 || echo 'Installing mtrack & dispad'

cd /tmp

echo 'Installing mtrack...'
git clone https://github.com/p2rkw/xf86-input-mtrack.git
cd xf86-input-mtrack
./configure --with-xorg-module-dir=/usr/lib/xorg/modules
sudo make
sudo make install

sudo adduser "`whoami`" input

# More info on xorg conf files: https://fedoraproject.org/wiki/Input_device_configuration#InputClasses
echo 'Replacing touchpad mapping...'
sudo mkdir -p /usr/share/X11/xorg.conf.d
sudo cp $CURRENT_DIR/custom-config/80-macbook-trackpad.conf /usr/share/X11/xorg.conf.d/.
sudo cp $CURRENT_DIR/custom-config/85-magic-trackpad.conf /usr/share/X11/xorg.conf.d/.

#echo 'Installing dispad...'
#cd ..
#git clone https://github.com/BlueDragonX/dispad.git
#cd dispad
#./configure
#sudo make
#sudo make install
