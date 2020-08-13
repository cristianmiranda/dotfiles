
### Remaster Linux ISO:
* https://nixaid.com/linux-on-macbookpro/
* https://www.techrepublic.com/article/how-to-create-a-custom-ubuntu-iso-with-cubic/

### Useful links:
* https://www.maketecheasier.com/install-dual-boot-ubuntu-mac/
* https://www.rodsbooks.com/refind/bootcoup.html#efibootmgr
* https://github.com/Dunedan/mbp-2016-linux
* https://github.com/Dunedan/mbp-2016-linux/issues/6#issuecomment-387526390
* https://gist.github.com/roadrunner2/1289542a748d9a104e7baec6a92f9cd7#keyboardtouchpadtouchbar

NOTE: I forked all repos, so if they don't exist anymore, I have them :)

# On macOS

1. Turn off System Integrity Protection in macOS
Cmd + R while booting, then open terminal
```bash
crsutil disable
reboot
```
2. Create partition and install linux

# On Linux

## Intel Iris Graphics

1. Use apple_set_os.efi from https://github.com/0xbb/apple_set_os.efi/issues/20#issuecomment-557352747 (https://github.com/0xbb/apple_set_os.efi/files/3877561/apple_set_os.zip) or use refind
2. Update grub (don't forget `sudo update-grub`)
```bash
sudo su

# Blacklist amdgpu
sudo echo "blacklist amdgpu" > /etc/modprobe.d/blacklist-amdgpu.conf

# Use refind as boot manager
apt-get install refind
nano /boot/EFI/efi/refind/refind.conf
# Uncomment spoof_ox_... 10.9 line

# If not using refind
# Download https://github.com/0xbb/apple_set_os.efi/files/3877561/apple_set_os.zip
# Uncompress and place in /boot/efi/EFI/custom
mkdir -p /boot/efi/EFI/custom
mv apple_set_os.efi /boot/efi/EFI/custom/.
nano /etc/grub.d/40_custom

# Add the following lines:
search --no-floppy --set=root --label EFI
chainloader (${root})/EFI/custom/apple_set_os.efi
boot

# Update grub
update-grub

# Switch to integrated GPU
cd
git clone https://github.com/0xbb/gpu-switch
cd gpu-switch
sudo ./gpu-switch -i

sudo reboot
```

## WIFI

https://bugzilla.kernel.org/show_bug.cgi?id=193121#c62

```bash
cp brcmfmac43602-pcie.txt /lib/firmware/brcm/.
cp brcmfmac43602-pcie.txt /lib/firmware/brcm/brcmfmac43602-pcie.Apple\ Inc.-MacBookPro13,3.txt

# Support suspend/hibernate
# See more @ https://bugs.launchpad.net/ubuntu/+source/broadcom-sta/+bug/1765036
echo 'SUSPEND_MODULES="brcmfmac"' | sudo tee -a /etc/pm/config.d/unload_brcmfmac
sudo chmod 777 /etc/pm/config.d/unload_brcmfmac

# Reseting module
sudo service network-manager restart
sudo rmmod brcmfmac && sudo modprobe brcmfmac

# Powering off / on the module
# https://bugzilla.kernel.org/show_bug.cgi?id=196019#c6

sudo su
lspci | grep -i broad
03:00.0 Network controller: Broadcom Inc. and subsidiaries BCM43602 802.11ac Wireless LAN SoC (rev 02)

echo 1 > /sys/bus/pci/devices/0000\:03\:00.0/remove
sleep 1
echo 1 > /sys/bus/pci/rescan

```

## Audio

Sound: https://github.com/leifliddy/snd_hda_macbookpro
Microphone (not working): https://askubuntu.com/questions/984239/no-microphone-picked-up-on-ubuntu-16-04-on-macbook-pro

## Touchbar

* https://github.com/roadrunner2/macbook12-spi-driver

If on manjaro:

* https://forum.manjaro.org/t/solved-trying-to-make-install-drivers-for-macbook-pro-from-github/94207/5
* https://aur.archlinux.org/packages/macbook12-spi-driver-dkms/

```bash
uname -r
sudo pacman -S linux-headers base-devel

# Install yaourt
sudo pacman -S --needed git wget yajl
cd /tmp
git clone https://aur.archlinux.org/package-query.git
cd package-query/
makepkg -si && cd /tmp/
git clone https://aur.archlinux.org/yaourt.git
cd yaourt/
makepkg -si

```

If on Ubuntu:

```bash
apt-get install git dkms

cd ~
echo -e "\n# macbook12-spi-drivers\napplespi\napple_ib_tb\nspi_pxa2xx_platform\nintel_lpss_pci" >> /etc/initramfs-tools/modules

git clone https://github.com/roadrunner2/macbook12-spi-driver.git
cd ./macbook12-spi-driver
git checkout touchbar-driver-hid-driver
dkms add .
dkms install -m applespi -v 0.1 -k 5.3.0-24-generic

# lsinitramfs /boot/initrd.img-5.3.0-24-generic | grep -i "dkms/apple"
lib/modules/5.3.0-24-generic/updates/dkms/apple-ibridge.ko
lib/modules/5.3.0-24-generic/updates/dkms/apple-ib-tb.ko
lib/modules/5.3.0-24-generic/updates/dkms/applespi.ko
```

If you want the F-keys to be always on by default and the Fn button for switching from F-keys to special keys, then use the following command (if not, fnmode=1):

```bash
echo 'options apple_ib_tb fnmode=2' | sudo tee /etc/modprobe.d/apple_ib_tb.conf
echo 'options apple_ib_tb idle_timeout=60' | sudo tee /etc/modprobe.d/apple_ib_tb.conf
update-initramfs -u -k 5.3.0-24-generic
```

#### Common

> This section is common to wheher you are using legacy monolithic driver or not.

You can also swap `fn` and a `control` keys:

```
echo 'options applespi fnremap=1' | tee /etc/modprobe.d/applespi.conf
update-initramfs -u -k 5.3.0-24-generic

```

Or remap it to any other key:

```
# modinfo applespi | grep -w fnremap
parm:           fnremap:Remap fn key ([0] = no-remap; 1 = left-ctrl, 2 = left-shift, 3 = left-alt, 4 = left-meta, 6 = right-shift, 7 = right-alt, 8 = right-meta) (uint)

```

## Turn off screen on close lid
https://mensfeld.pl/2018/08/ubuntu-18-04-disable-screen-on-lid-close/


## Keyboard
https://medium.com/@petrstepanov/a-macos-like-keyboard-remap-on-ubuntu-linux-cae1d108a97

## Trackpad
https://int3ractive.com/2018/09/make-the-best-of-MacBook-touchpad-on-Ubuntu.html