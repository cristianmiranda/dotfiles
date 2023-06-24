# 🐧 Linux (post-install steps)

## 📝 vim

1. Enter vim
2. Run `:PlugInstall` to install plugins

## 🪟 tmux

1. Run tmux
2. Press `prefix + I` to install plugins

## 🖱️ Touchpad

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

## 🛜 Bluetooth

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

## 💄 Qt5

```bash
sudo vim /etc/environment
```

```bash
QT_QPA_PLATFORMTHEME=qt5ct
```

## 📦 Pacman

```bash
sudo vim /etc/pacman.conf
```

```
# Misc options
Color
ILoveCandy
```

## 🔋 ThinkPad Battery

Factory settings for ThinkPad battery thresholds are as follows: when plugged in the battery starts charging at 96%, and stops at 100%. These settings are optimized for maximum runtime, but having a battery hold a lot of power will decrease its capacity over the years. To alleviate this problem, the start/stop charge thresholds can be adjusted – at the cost of a more or less reduced battery runtime.

It all depends on how you use your laptop, or more precisely, on the minimal runtime you’re ready to accept when you’re on the road. In the end, it all comes down to a runtime vs. lifespan trade-off.

If the laptop is plugged most of the time and rarely unplugged, maximizing battery lifetime at the cost of a greatly reduced runtime may be acceptable, with values like starting charge at 40% and stopping at 50%.

On the contrary, if you use it unplugged most of the time, starting charge at 85% and stopping at 90% would allow for a much longer runtime and still give a lifespan benefit over the factory settings.

See more @ https://linrunner.de/tlp/faq/battery.html

```
sudo tlp-stat -b
```

### TLP UI

![](https://i.imgur.com/TKA52gL.png)