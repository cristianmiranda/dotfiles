#!/usr/bin/env bash

########
# UPDATE - 02/05/2020 - kernel version must be 5.4 or less to have vgaswitcheroo
########

gpu-manager | grep 'amdgpu loaded? no' && sudo modprobe amdgpu || echo 'AMD GPU already loaded'

echo 'Switching to integrated GPU' && sudo /home/cmiranda/dotfiles/box/linux-mbp/scripts/gpu/gpu-switch/gpu-switch -i

echo OFF > /sys/kernel/debug/vgaswitcheroo/switch

cat /sys/kernel/debug/vgaswitcheroo/switch

# First read https://github.com/cristianmiranda/dotfiles/blob/master/linux/docs/MacbookPro2016.md#intel-iris-graphics
#
# Since Intel integrated graphics card is powered because we're spoofing macOS, now both cards are available (Intel & ATI)
# In order to get Linux to boot, it's required to blacklist amdgpu module
#
# sudo cat /etc/modprobe.d/blacklist-amdgpu.conf
#
# ... and, more importantly, run ~/dotfiles/linux/scripts/gpu-switch/gpu-switch -i
# to switch over to the iGPU (Intel). Without this last step, linux won't boot next time you reboot
#
# The problem is that dGPU (ATI Radeon) is still powered and consuming A LOT of resources, therefor we need to 
# manually load the module, and turn it off
#
# sudo modprobe amdgpu
# 
# ...and, for turning it off (here comes the tricky part), we should switch the PCI device off like this:
#
# ➜ lspci| grep "VGA"                                       
# 00:02.0 VGA compatible controller: Intel Corporation HD Graphics 530 (rev 06)
# 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Baffin [Radeon RX 460/560D / Pro 450/455/460/555/555X/560/560X] (rev c0)
#
# Notice how 01:00.0 is the ID for the PCI device
#
# ➜ sudo cat /sys/bus/pci/devices/0000:01:00.0/power/control 
# on
#
# So, many forums and websites (including https://github.com/Dunedan/mbp-2016-linux/issues/6#issuecomment-416015734 - although this one uses vgaswitcheroo (not possible here))
# say that I should do like so:
# 
# sudo su
# Linux-MBP# echo OFF > /sys/bus/pci/devices/0000:01:00.0/power/control
# echo: write error: invalid argument
#
# I get the same error using 'OFF','1','0' (although for turning off it should be 1)
#
# ------------
# CONCLUSION
# ------------
#
# After manually loading amdgpu, resources consumption started to decrease, also the laptop temperature went down as well.
# I'm not entirely sure that this is the best I could go, but it's much better than before. I'm not sure how the driver manages
# the eGPU, but now it seems to be in an idle state.
# 
# Just to make sure that Intel is the card providing graphics, I run:
#
# ➜ glxinfo | grep "OpenGL renderer"          
# OpenGL renderer string: Mesa Intel(R) HD Graphics 530 (SKL GT2)
#
# So... We need to do the following on boot (just to be on the safe side of the road):
#
#   1. sudo modprobe amdgpu
#   2. sudo /home/cmiranda/dotfiles/linux/scripts/gpu-switch/gpu-switch -i
# 
# THE END!
#
# My comment: https://github.com/Dunedan/mbp-2016-linux/issues/6#issuecomment-619452760
#

#echo 'Starting amdgpu (if not, it consumes A LOT of resources, it also heats up the lapatop)...'
#sudo cat <<EOT > /etc/systemd/system/macbook-quirks.service
#[Unit]
#Description=Perform some tweaks to allow sleeping and better power management
#Before=display-manager.service
#
#[Service]
#Type=oneshot
#ExecStart=/usr/sbin/modprobe amdgpu
#ExecStart=/home/cmiranda/dotfiles/linux/scripts/gpu-switch/gpu-switch -i
#RemainAfterExit=yes
#TimeoutSec=0
#
#[Install]
#WantedBy=multi-user.target
#EOT

#sudo systemctl enable macbook-quirks
