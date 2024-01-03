# 🐧 Linux (post-install steps)

- [🐧 Linux (post-install steps)](#-linux-post-install-steps)
  - [🐧 LTS Kernel](#-lts-kernel)
  - [🔊 Peripherals](#-peripherals)
    - [⌨️ Keyboard](#️-keyboard)
    - [🖱️ Touchpad](#️-touchpad)
    - [🛜 Bluetooth](#-bluetooth)
  - [💅 Cosmetics](#-cosmetics)
    - [💄 Qt5](#-qt5)
    - [👋 SDDM greeter](#-sddm-greeter)
    - [☢️ GRUB Theme](#️-grub-theme)
    - [📦 Pacman](#-pacman)
  - [🫙 Apps](#-apps)
    - [📝 neovim](#-neovim)
    - [📝 vim](#-vim)
    - [🪟 tmux](#-tmux)
  - [🍏 iMac](#-imac)
    - [🐧 Kernel](#-kernel)
    - [⌨️ Keyboard](#️-keyboard-1)
    - [🔆 Brightness](#-brightness)
  - [💻 Laptop](#-laptop)
    - [💻 Lid Close event](#-lid-close-event)
    - [🔌 USB autosuspend](#-usb-autosuspend)
    - [🧠 auto-cpufreq](#-auto-cpufreq)
    - [🔋 TLP](#-tlp)
      - [🔋 TLP Configuration file](#-tlp-configuration-file)

## 🐧 LTS Kernel

```bash
sudo pacman -S linux-lts linux-lts-headers
```

```bash
sudo vim /etc/default/grub
```

```conf
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
```

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

## 🔊 Peripherals

### ⌨️ Keyboard

Set default language layout for all keyboards

```bash
sudo vim /etc/X11/xorg.conf.d/00-keyboard.conf
```

```conf
Section "InputClass"
    Identifier "system-keyboard"
    MatchIsKeyboard "on"
    Option "XkbLayout" "es"
EndSection
```

### 🖱️ Touchpad

Enable "tap to click" & change mouse acceleration

```bash
sudo vim /etc/X11/xorg.conf.d/30-touchpad.conf
```

```conf
Section "InputClass"
    Identifier "tfiouchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "AccelSpeed" "0.5"
EndSection
```

See more @ https://wiki.archlinux.org/title/Mouse_acceleration

### 🛜 Bluetooth

Enable experimental features (Apple Magic Keyboard has issues with default settings)

```bash
sudo vim /etc/bluetooth/main.conf
```

```conf
...

# Enables D-Bus experimental interfaces
# Possible values: true or false
Experimental = true

# Enables kernel experimental features, alternatively a list of UUIDs
# can be given.
# Possible values: true,false,<UUID List>
# Possible UUIDS:
...
# Defaults to false.
KernelExperimental = true
```

## 💅 Cosmetics

### 💄 Qt5

```bash
sudo vim /etc/environment
```

```bash
QT_QPA_PLATFORMTHEME=qt5ct
```

### 👋 SDDM greeter

See more @ https://github.com/3ximus/aerial-sddm-theme

```bash
# Set default theme
sudo vim /usr/lib/sddm/sddm.conf.d/default.conf
```

```conf
[Theme]
# Current theme name
Current=aerial
```

```bash
# Copy .face (after setting with mugshot) to /usr/share/sddm/faces
sudo cp ~/.face /usr/share/sddm/faces/cmiranda.face.icon
sudo chmod 755 /usr/share/sddm/faces/cmiranda.face.icon
```

### ☢️ GRUB Theme

```bash
bash ~/dotfiles/scripts/install-fallout-grub-theme.sh
```

### 📦 Pacman

```bash
sudo vim /etc/pacman.conf
```

```conf
# Misc options
Color
ILoveCandy
```

## 🫙 Apps

### 📝 neovim

1. Enter nvim
2. Wait for Mason to install all plugins
3. Run `:Copilot setup` to authenticate with GitHub

### 📝 vim

1. Enter vim
2. Run `:PlugInstall` to install plugins

### 🪟 tmux

1. Run tmux
2. Press `prefix + I` to install plugins

## 🍏 iMac

Useful Arch wiki pages:

- https://wiki.archlinux.org/title/Mac
- https://wiki.archlinux.org/title/IMac_Unibody
- https://wiki.archlinux.org/title/IMac_Aluminum

### 🐧 Kernel

After installing Arch Linux, if grub config gets regenerated (after configuring brightness kernel param for example), the default kernel changes to linux-lts (not sure why). A quick solution is to install that kernel so the operating system boots up again.
Another solution would be changing the default kernel back to linux instead of linux-lts.

Read more @ https://bbs.archlinux.org/viewtopic.php?id=281748

### ⌨️ Keyboard

If using an Apple Keyboard that has the `fn` key to the left of `ctrl` and it's also not considered an ISO keyboard (e.g `<` and `>` are not working as expected and are swapped with `º`), add the following as root:

```bash
vim /etc/modprobe.d/hid_apple.conf
```

```conf
options hid_apple swap_fn_leftctrl=1
options hid_apple iso_layout=1
```

Read more @ https://wiki.archlinux.org/title/Apple_Keyboard

### 🔆 Brightness

For brightness control to work we need to pass a kernel param.

```bash
sudo vim /etc/default/grub
```

```conf
GRUB_CMDLINE_LINUX_DEFAULT="quiet acpi_backlight=native"
```

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Restart and test using the following:

```bash
echo "90" | sudo tee /sys/class/backlight/radeon_bl0/brightness
```

## 💻 Laptop

### 💻 Lid Close event

xfce4-power-manager handles power management now.

```bash
sudo vim /etc/systemd/logind.conf

HandleLidSwitch=ignore
```

### 🔌 USB autosuspend

This has been disabled using TLP (can't make them active on wake up).

### 🧠 auto-cpufreq

See more @ https://github.com/AdnanHodzic/auto-cpufreq

CPU freq params are managed by auto-cpufreq which takes advantage of turbo boost. TLP CPU settings have been commented out so that it doesn't conflict with auto-cpufreq.

### 🔋 TLP

Factory settings for ThinkPad battery thresholds are as follows: when plugged in the battery starts charging at 96%, and stops at 100%. These settings are optimized for maximum runtime, but having a battery hold a lot of power will decrease its capacity over the years. To alleviate this problem, the start/stop charge thresholds can be adjusted – at the cost of a more or less reduced battery runtime.

It all depends on how you use your laptop, or more precisely, on the minimal runtime you’re ready to accept when you’re on the road. In the end, it all comes down to a runtime vs. lifespan trade-off.

If the laptop is plugged most of the time and rarely unplugged, maximizing battery lifetime at the cost of a greatly reduced runtime may be acceptable, with values like starting charge at 40% and stopping at 50%.

On the contrary, if you use it unplugged most of the time, starting charge at 85% and stopping at 90% would allow for a much longer runtime and still give a lifespan benefit over the factory settings.

See more @ https://linrunner.de/tlp/faq/battery.html

```bash
sudo tlp-stat -b
```

![](https://i.imgur.com/TKA52gL.png)

#### 🔋 TLP Configuration file

```conf
#Slimbook ENERGY SAVING MODE ##
# ------------------------------------------------------------------------------
# /etc/tlp.conf - TLP user configuration
# See full explanation: https://linrunner.de/en/tlp/docs/tlp-configuration.html
#
# New configuration scheme (TLP 1.3). Settings are read in the following order:

# 1. Intrinsic defaults
# 2. /etc/tlp.d/*.conf - Drop-in customization snippets
# 3. /etc/tlp.conf     - User configuration (this file)
#
# Notes:
# - In case of identical parameters, the last occurence has precedence
# - This also means, parameters enabled here will override anything else
# - However you may append values to a parameter already defined as intrinsic
#   default or in a previously read file: use PARAMETER+="add values"
# - IMPORTANT: all parameters here are disabled, remove the leading '#'
#   to enable them; shown values may be suggestions rather than defaults
# - Default *: intrinsic default that is effective when the parameter is missing
#     or disabled by a leading '#'; use PARAM="" to disable an intrinsic default
# - Default <none>: do nothing or use kernel/hardware defaults

# ------------------------------------------------------------------------------
# tlp - Parameters for power saving

# Set to 0 to disable, 1 to enable TLP.
# Default: 1
# Slimbook App
TLP_ENABLE=1

# Operation mode when no power supply can be detected: AC, BAT.
# Concerns some desktop and embedded hardware only.
# Default: <none>
# Slimbook App
TLP_DEFAULT_MODE=BAT

# Operation mode select: 0=depend on power source, 1=always use TLP_DEFAULT_MODE
# Note: use in conjunction with TLP_DEFAULT_MODE=BAT for BAT settings on AC.
# Default: 0

TLP_PERSISTENT_DEFAULT=0

# Power supply class to ignore when determining operation mode: AC, BAT.
# Note: try on laptops where operation mode AC/BAT is incorrectly detected.
# Default: <none>

#TLP_PS_IGNORE=BAT

# Seconds laptop mode has to wait after the disk goes idle before doing a sync.
# Non-zero value enables, zero disables laptop mode.
# Default: 0 (AC), 2 (BAT)

#DISK_IDLE_SECS_ON_AC=0
#DISK_IDLE_SECS_ON_BAT=2

# Dirty page values (timeouts in secs).
# Default: 15 (AC), 60 (BAT)

#MAX_LOST_WORK_SECS_ON_AC=15
#MAX_LOST_WORK_SECS_ON_BAT=60

# Note: CPU parameters below are disabled by default, remove the leading #
# to enable them, otherwise kernel defaults will be used.
#
# Select a CPU frequency scaling governor.
# Intel Core i processor with intel_pstate driver:
#   powersave(*), performance.
# Other hardware with acpi-cpufreq driver:
#   ondemand(*), powersave, performance, conservative, schedutil.
# (*) is recommended.
# Use tlp-stat -p to show the active driver and available governors.
# Important:
#   powersave for intel_pstate and ondemand for acpi-cpufreq are power
#   efficient for *almost all* workloads and therefore kernel and most
#   distributions have chosen them as defaults. If you still want to change,
#   you should know what you're doing!
# Default: <none>
# Slimbook App Modos

#CPU_SCALING_GOVERNOR_ON_AC=performance
#CPU_SCALING_GOVERNOR_ON_BAT=conservative

# For available frequencies see the output of tlp-stat -p.
# Notes:
# - Min/max frequencies must always be specified for both AC *and* BAT
# - Not recommended for use with the intel_pstate scaling driver, use
#   CPU_MIN/MAX_PERF_ON_AC/BAT below instead
# https://linrunner.de/tlp/settings/processor.html#cpu-scaling-min-max-freq-on-ac-bat
# Slimbook Modos Unchanged
#CPU_SCALING_MIN_FREQ_ON_AC=0
#CPU_SCALING_MAX_FREQ_ON_AC=5300000
#CPU_SCALING_MIN_FREQ_ON_BAT=0
#CPU_SCALING_MAX_FREQ_ON_BAT=1100000

# Set Intel CPU energy/performance policies HWP.EPP and EPB:
#   performance, balance_performance, default, balance_power, power.
# Values are given in order of increasing power saving.
# Notes:
# - HWP.EPP: requires kernel 4.10, intel_pstate scaling driver and Intel Core i
#   6th gen. or newer CPU
# - EPB: requires kernel 5.2 or module msr and x86_energy_perf_policy from
#   linux-tools, intel_pstate or intel_cpufreq scaling driver and Intel Core i
#   2nd gen. or newer CPU
# - When HWP.EPP is available, EPB is not set
# Default: balance_performance (AC), balance_power (BAT)
# Slimbook Modos Unchanged

CPU_ENERGY_PERF_POLICY_ON_AC=
CPU_ENERGY_PERF_POLICY_ON_BAT=

# Set Intel CPU P-state performance: 0..100 (%).
# Limit the max/min P-state to control the power dissipation of the CPU.
# Values are stated as a percentage of the available performance.
# Requires an Intel Core i processor with intel_pstate driver.
# Default: <none>
# Slimbook Modos Unchanged
#CPU_MIN_PERF_ON_AC=0
#CPU_MAX_PERF_ON_AC=100

#CPU_MIN_PERF_ON_BAT=0
#CPU_MAX_PERF_ON_BAT=33

# Set the CPU "turbo boost" feature: 0=disable, 1=allow
# Requires an Intel Core i processor.
# Important:
# - This may conflict with your distribution's governor settings
# - A value of 1 does *not* activate boosting, it just allows it
# Default: <none>
# Slimbook Modos Unchanged
#CPU_BOOST_ON_AC=1
#CPU_BOOST_ON_BAT=0

# Minimize number of used CPU cores/hyper-threads under light load conditions:
#   0=disable, 1=enable.
# Default: 0 (AC), 1 (BAT)
# Slimbook Modos Unchanged
SCHED_POWERSAVE_ON_AC=
SCHED_POWERSAVE_ON_BAT=

# Kernel NMI Watchdog
# 0=disable (default, saves power), 1=enable (for kernel debugging only).
# Slimbook Unchanged
NMI_WATCHDOG=

# Change CPU voltages aka "undervolting" - Kernel with PHC patch required.
# Frequency voltage pairs are written to:
#   /sys/devices/system/cpu/cpu0/cpufreq/phc_controls
# CAUTION: only use this, if you thoroughly understand what you are doing!
# Default: <none>.

#PHC_CONTROLS="F:V F:V F:V F:V"

# Disk devices; separate multiple devices with spaces.
# Devices can be specified by disk ID also (lookup with: tlp diskid).
# Note: DISK parameters below are effective only when this option is configured.
# Default: "nvme0n1 sda"

# DISK_DEVICES="nvme0n1 sda"

# Disk advanced power management level: 1..254, 255 (max saving, min, off).
# Levels 1..127 may spin down the disk; 255 allowable on most drives.
# Separate values for multiple disks with spaces. Use the special value 'keep'
# to keep the hardware default for the particular disk.
# Default: 254 (AC), 128 (BAT)

# DISK_APM_LEVEL_ON_AC="254 254"
# DISK_APM_LEVEL_ON_BAT="128 128"

# Hard disk spin down timeout:
#   0:        spin down disabled
#   1..240:   timeouts from 5s to 20min (in units of 5s)
#   241..251: timeouts from 30min to 5.5 hours (in units of 30min)
# See 'man hdparm' for details.
# Separate values for multiple disks with spaces. Use the special value 'keep'
# to keep the hardware default for the particular disk.
# Default: <none>

#DISK_SPINDOWN_TIMEOUT_ON_AC="0 0"
#DISK_SPINDOWN_TIMEOUT_ON_BAT="0 0"

# Select I/O scheduler for the disk devices.
# Multi queue (blk-mq) schedulers:
#   mq-deadline(*), none, kyber, bfq
# Single queue schedulers:
#   deadline(*), cfq, bfq, noop
# (*) recommended.
# Separate values for multiple disks with spaces. Use the special value 'keep'
# to keep the kernel default scheduler for the particular disk.
# Notes:
# - Multi queue (blk-mq) may need kernel boot option 'scsi_mod.use_blk_mq=1'
#   and 'modprobe mq-deadline-iosched|kyber|bfq' on kernels < 5.0
# - Single queue schedulers are legacy now and were removed together with
#   the old block layer in kernel 5.0
# Default: keep

#DISK_IOSCHED="mq-deadline mq-deadline"

# AHCI link power management (ALPM) for disk devices:
#   min_power, med_power_with_dipm(*), medium_power, max_performance.
# (*) Kernel >= 4.15 required, then recommended.
# Multiple values separated with spaces are tried sequentially until success.
# Default:
#  - "med_power_with_dipm max_performance" (AC)
#  - "med_power_with_dipm min_power" (BAT)

# SATA_LINKPWR_ON_AC="med_power_with_dipm max_performance"
# SATA_LINKPWR_ON_BAT="med_power_with_dipm min_power"

# Exclude host devices from AHCI link power management.
# Separate multiple hosts with spaces.
# Default: <none>

#SATA_LINKPWR_BLACKLIST="host1"

# Runtime Power Management for AHCI host and disks devices:
#   on=disable, auto=enable.
# EXPERIMENTAL ** WARNING: auto may cause system lockups/data loss.
# Default: <none>

#AHCI_RUNTIME_PM_ON_AC=on
#AHCI_RUNTIME_PM_ON_BAT=on

# Seconds of inactivity before disk is suspended.
# Note: effective only when AHCI_RUNTIME_PM_ON_AC/BAT is activated.
# Default: 15

# AHCI_RUNTIME_PM_TIMEOUT=15

# PCI Express Active State Power Management (PCIe ASPM):
#   default(*), performance, powersave, powersupersave.
# (*) keeps BIOS ASPM defaults (recommended)
# Default: <none>

PCIE_ASPM_ON_AC=performance
#PCIE_ASPM_ON_BAT=default

# Set the min/max/turbo frequency for the Intel GPU.
# Possible values depend on your hardware. For available frequencies see
# the output of tlp-stat -g.
# Default: <none>
# Slimbook App Modos
INTEL_GPU_MIN_FREQ_ON_AC=350
INTEL_GPU_MIN_FREQ_ON_BAT=350
INTEL_GPU_MAX_FREQ_ON_AC=1250
INTEL_GPU_MAX_FREQ_ON_BAT=1250
INTEL_GPU_BOOST_FREQ_ON_AC=1250
INTEL_GPU_BOOST_FREQ_ON_BAT=900

# Radeon graphics clock speed (profile method): low, mid, high, auto, default;
# auto = mid on BAT, high on AC.
# Default: default
# Defaults
RADEON_POWER_PROFILE_ON_AC=default
RADEON_POWER_PROFILE_ON_BAT=default


# Radeon dynamic power management method (DPM): battery, performance.
# Default: <none>
# Slimbook
RADEON_DPM_STATE_ON_AC=performance
RADEON_DPM_STATE_ON_BAT=battery

# Radeon DPM performance level: auto, low, high; auto is recommended.
# Note: effective only when RADEON_DPM_STATE_ON_AC/BAT is activated.
# Default: auto
# Defaults
RADEON_DPM_PERF_LEVEL_ON_AC=auto
RADEON_DPM_PERF_LEVEL_ON_BAT=auto

# WiFi power saving mode: on=enable, off=disable; not supported by all adapters.
# Default: off (AC), on (BAT)
# Slimbook App
WIFI_PWR_ON_AC=off
WIFI_PWR_ON_BAT=off

# Disable wake on LAN: Y/N.
# Default: Y
# Defaults
WOL_DISABLE=Y

# Enable audio power saving for Intel HDA, AC97 devices (timeout in secs).
# A value of 0 disables, >=1 enables power saving (recommended: 1).
# Default: 0 (AC), 1 (BAT)
# Slimbook App
SOUND_POWER_SAVE_ON_AC=
SOUND_POWER_SAVE_ON_BAT=

# Disable controller too (HDA only): Y/N.
# Note: effective only when SOUND_POWER_SAVE_ON_AC/BAT is activated.
# Default: Y

SOUND_POWER_SAVE_CONTROLLER=

# Power off optical drive in UltraBay/MediaBay: 0=disable, 1=enable.
# Drive can be powered on again by releasing (and reinserting) the eject lever
# or by pressing the disc eject button on newer models.
# Note: an UltraBay/MediaBay hard disk is never powered off.
# Default: 0

# Slimbook Unchanged
# Defaults
BAY_POWEROFF_ON_AC=0
BAY_POWEROFF_ON_BAT=0

# Optical drive device to power off
# Default: sr0

BAY_DEVICE="sr0"

# Runtime Power Management for PCI(e) bus devices: on=disable, auto=enable.
# Default: on (AC), auto (BAT)
# Slimbook Unchanged
# Defaults
RUNTIME_PM_ON_AC=auto
RUNTIME_PM_ON_BAT=auto

# Exclude PCI(e) device adresses the following list from Runtime PM
# (separate with spaces). Use lspci to get the adresses (1st column).
# Default: <none>
# Slimbook Unchanged
RUNTIME_PM_BLACKLIST="bb:dd.f 11:22.3 44:55.6 02:00.0"

# Exclude PCI(e) devices assigned to the listed drivers from Runtime PM.
# Default when unconfigured is "amdgpu nouveau nvidia radeon" which
# prevents accidential power-on of dGPU in hybrid graphics setups.
# Separate multiple drivers with spaces.
# Default: "amdgpu mei_me nouveau nvidia pcieport radeon", use "" to disable
# completely.
# Slimbook Unchanged
RUNTIME_PM_DRIVER_BLACKLIST="nouveau nvidia"

# Set to 0 to disable, 1 to enable USB autosuspend feature.
# Default: 1
# Slimbook App
USB_AUTOSUSPEND=

# Exclude listed devices from USB autosuspend (separate with spaces).
# Use lsusb to get the ids.
# Note: input devices (usbhid) are excluded automatically
# Default: <none>
# Slimbook App
USB_BLACKLIST=0bda:0411 0bda:8153
USB_DENYLIST=0bda:0411 0bda:8153

# Bluetooth devices are excluded from USB autosuspend:
#   0=do not exclude, 1=exclude.
# Default: 0
# Slimbook App
USB_BLACKLIST_BTUSB=1
USB_DENYLIST_BTUSB=1

# Phone devices are excluded from USB autosuspend:
#   0=do not exclude, 1=exclude (enable charging).
# Default: 0
# Slimbook Unchanged
USB_BLACKLIST_PHONE=1
USB_DENYLIST_PHONE=1

# Printers are excluded from USB autosuspend:
#   0=do not exclude, 1=exclude.
# Default: 1
# Slimbook App
USB_BLACKLIST_PRINTER=1
USB_DENYLIST_PRINTER=1

# WWAN devices are excluded from USB autosuspend:
#   0=do not exclude, 1=exclude.
# Default: 0
# Slimbook App
USB_BLACKLIST_WWAN=1
USB_DENYLIST_WWAN=1

# Include listed devices into USB autosuspend even if already excluded
# by the blacklists above (separate with spaces). Use lsusb to get the ids.
# Default: <none>

#USB_WHITELIST="1111:2222 3333:4444"

# Set to 1 to disable autosuspend before shutdown, 0 to do nothing
# Note: use as a workaround for USB devices that cause shutdown problems.
# Default: 0
# Slimbook App
USB_AUTOSUSPEND_DISABLE_ON_SHUTDOWN=1

# Restore radio device state (Bluetooth, WiFi, WWAN) from previous shutdown
# on system startup: 0=disable, 1=enable.
# Note: the parameters DEVICES_TO_DISABLE/ENABLE_ON_STARTUP/SHUTDOWN below
#   are ignored when this is enabled.
# Default: 0
# Slimbook App?

RESTORE_DEVICE_STATE_ON_STARTUP=0

# Radio devices to disable on startup: bluetooth, wifi, wwan.
# Separate multiple devices with spaces.
# Default: <none>

# Slimbook App
DEVICES_TO_DISABLE_ON_STARTUP=

# Radio devices to enable on startup: bluetooth, wifi, wwan.
# Separate multiple devices with spaces.
# Default: <none>

DEVICES_TO_ENABLE_ON_STARTUP=""

# Radio devices to disable on shutdown: bluetooth, wifi, wwan.
# Note: use as a workaround for devices that are blocking shutdown.
# Default: <none>

#DEVICES_TO_DISABLE_ON_SHUTDOWN="bluetooth wifi wwan"

# Radio devices to enable on shutdown: bluetooth, wifi, wwan.
# (to prevent other operating systems from missing radios).
# Default: <none>

#DEVICES_TO_ENABLE_ON_SHUTDOWN="wwan"

# Radio devices to enable on AC: bluetooth, wifi, wwan.
# Default: <none>

#DEVICES_TO_ENABLE_ON_AC="bluetooth wifi wwan"

# Radio devices to disable on battery: bluetooth, wifi, wwan.
# Default: <none>

#DEVICES_TO_DISABLE_ON_BAT="bluetooth wifi wwan"

# Radio devices to disable on battery when not in use (not connected):
#   bluetooth, wifi, wwan.
# Default: <none>
# Slimbook App
#DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE=""

# Battery charge thresholds (ThinkPad only).
# May require external kernel module(s), refer to the output of tlp-stat -b.
# Charging starts when the remaining capacity falls below the
# START_CHARGE_THRESH value and stops when exceeding the STOP_CHARGE_THRESH
# value.

# Main / Internal battery (values in %)
# Default: <none>

START_CHARGE_THRESH_BAT0=50
STOP_CHARGE_THRESH_BAT0=55

# Ultrabay / Slice / Replaceable battery (values in %)
# Default: <none>

#START_CHARGE_THRESH_BAT1=75
#STOP_CHARGE_THRESH_BAT1=80

# Restore charge thresholds when AC is unplugged: 0=disable, 1=enable.
# Default: 0

#RESTORE_THRESHOLDS_ON_BAT=1

# Battery feature drivers: 0=disable, 1=enable
# Default: 1 (all)

#NATACPI_ENABLE=1
#TPACPI_ENABLE=1
#TPSMAPI_ENABLE=1

# ------------------------------------------------------------------------------
# tlp-rdw - Parameters for the radio device wizard

# Possible devices: bluetooth, wifi, wwan.
# Separate multiple radio devices with spaces.
# Default: <none> (for all parameters below)

# Radio devices to disable on connect.
# Slimbook App
DEVICES_TO_DISABLE_ON_LAN_CONNECT=

#DEVICES_TO_DISABLE_ON_WIFI_CONNECT="wwan"
#DEVICES_TO_DISABLE_ON_WWAN_CONNECT="wifi"

# Radio devices to enable on disconnect.

DEVICES_TO_ENABLE_ON_LAN_DISCONNECT=

#DEVICES_TO_ENABLE_ON_WIFI_DISCONNECT=""
#DEVICES_TO_ENABLE_ON_WWAN_DISCONNECT=""

# Radio devices to enable/disable when docked.

#DEVICES_TO_ENABLE_ON_DOCK=""
#DEVICES_TO_DISABLE_ON_DOCK=""

# Radio devices to enable/disable when undocked.

#DEVICES_TO_ENABLE_ON_UNDOCK="wifi"
#DEVICES_TO_DISABLE_ON_UNDOCK=""
```
