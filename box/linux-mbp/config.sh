#!/bin/bash

. ${UTILS_PATH}/ui.sh

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ $APPLY_CONFIG =~ n|N ]];
then
    warning ">>> Skipping config..."
    exit 0
fi

# See https://medium.com/@petrstepanov/a-macos-like-keyboard-remap-on-ubuntu-linux-cae1d108a97
info ">> Replacing custom keymaps..."
sudo cp $CURRENT_DIR/custom-config/keymap /usr/share/X11/xkb/symbols/pc

# See https://mensfeld.pl/2018/08/ubuntu-18-04-disable-screen-on-lid-close/
info '>> Preventing suspend on close lid...'
sudo cp $CURRENT_DIR/custom-config/logind.conf /etc/systemd/logind.conf
info '>> Turn off screen on close lid...'
sudo cp $CURRENT_DIR/custom-config/lm_lid /etc/acpi/events/lm_lid
sudo cp $CURRENT_DIR/custom-config/lid.sh /etc/acpi/lid.sh
sudo chmod +x /etc/acpi/lid.sh

info '>> Holding linux kernel upgrades...'
for i in $(dpkg -l "*$(uname -r)*" | grep kernel | awk '{print $2}'); do echo $i hold | sudo dpkg --set-selections; done

info ">>> Switching to integrated GPU"
sudo bash $CURRENT_DIR/scripts/gpu/gpu-switch/gpu-switch -i

echo ''
echo 'Aborting rest of the process. Please use rEFInd and install stuff manually.'
echo ''
echo '>> Pending tweaks to be executed manually:'
echo '>> - echo "blacklist amdgpu" > /etc/modprobe.d/blacklist-amdgpu.conf'
echo '>> - cp $CURRENT_DIR/custom-config/brcmfmac43602-pcie.txt /lib/firmware/brcm/.'
echo '>> - cp $CURRENT_DIR/custom-config/brcmfmac43602-pcie.txt /lib/firmware/brcm/brcmfmac43602-pcie.Apple\ Inc-MacBookPro13,3.txt'
echo '>> - Audio    - https://github.com/cristianmiranda/dotfiles/blob/master/linux/docs/MacbookPro2016.md#audio'
echo '>> - Touchbar - https://github.com/cristianmiranda/dotfiles/blob/master/linux/docs/MacbookPro2016.md#touchbar'
echo ''
exit 0;

# ########################################################################################################

echo 'Blacklisting dGPU (amdgpu)...'
echo "blacklist amdgpu" > /etc/modprobe.d/blacklist-amdgpu.conf

echo 'Spoofing macOS...'
mkdir -p /boot/efi/EFI/custom
cp $CURRENT_DIR/scripts/gpu/apple_set_os.efi /boot/efi/EFI/custom/.

ALREADY_SPOOFED=`grep -i apple_set_os.efi /etc/grub.d/40_custom`
if ! [[ $ALREADY_SPOOFED =~ apple_set_os.efi ]];
then
    echo 'Writing spoof lines into grub...'

    echo "search --no-floppy --set=root --label EFI" >> /etc/grub.d/40_custom
    echo 'chainloader (${root})/EFI/custom/apple_set_os.efi' >> /etc/grub.d/40_custom
    echo "boot" >> /etc/grub.d/40_custom
    
    echo 'Updating grub...'
    update-grub
fi

echo 'Switching to integrated GPU...'
$CURRENT_DIR/scripts/gpu/gpu-switch/gpu-switch -i

echo 'Patching brcmfmac43602-pcie firmware...'
cp $CURRENT_DIR/custom-config/brcmfmac43602-pcie.txt /lib/firmware/brcm/.
cp $CURRENT_DIR/custom-config/brcmfmac43602-pcie.txt /lib/firmware/brcm/brcmfmac43602-pcie.Apple\ Inc-MacBookPro13,3.txt

echo ''
echo '>> Pending tweaks to be executed manually:'
echo '>> - Audio    - https://github.com/cristianmiranda/dotfiles/blob/master/linux/docs/MacbookPro2016.md#audio'
echo '>> - Touchbar - https://github.com/cristianmiranda/dotfiles/blob/master/linux/docs/MacbookPro2016.md#touchbar'
echo ''
echo 'DONE!'
