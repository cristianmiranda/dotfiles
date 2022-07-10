# 🐧 Linux

## 📝 vim

1. Enter vim
2. Run `:PlugInstall` to install plugins

## 🪟 tmux

1. Run tmux
2. Press `prefix + I` to install plugins

## 🖱️ Touchpad

Enable "tap to click"
```bash
sudo vim /etc/X11/xorg.conf.d/30-touchpad.conf
```
```
Section "InputClass"
    Identifier "tfiouchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
EndSection
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
