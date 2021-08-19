# Arch

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
