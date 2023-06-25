# 🐧 Arch Linux Install Guide

First set up your keyboard layout. For example, in Spanish:

```bash
loadkeys es
```

For a list of all acceptable keymaps:

```bash
localectl list-keymaps
```

## 🥸 Pre-installation

### EFI-enabled BIOS

This guide assumes you have EFI-enabled BIOS. Let's check it out.

```bash
ls /sys/firmware/efi/efivars
```

When you run this command you should see a list of files.

### Internet connection

To make sure you have an internet connection, you have to ask Mr. Google:

```bash
ping 8.8.8.8
```

### Add best Arch mirrors

To install arch you have to download packages. It's a good idea to download
them from the best connection mirror.

```bash
pacman -Sy
pacman -S reflector
reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
```

### Partition disk

Your primary disk will be known from now on as `sda`. You can check if
this is really your primary disk:

```bash
lsblk
```

Feel free to adapt the rest of the guide to `sdb` or any other if you
want to install Arch on a secondary hard drive.

This guide will use a 250GB hard disk and will have only Arch Linux installed.
You'll create 5 partitions of the disk (feel free to suit this to your needs).

- `/dev/sda1` boot partition (1G).
- `/dev/sda2` swap partition (4G).
- `/dev/sda3` root partition (50G).
- `/dev/sda4` home partition (100G).
- `/dev/sda5` data partition (remaining disk space).

You're going to start by removing all the previous partitions and creating
the new ones.

```bash
gdisk /dev/sda
```

This interactive CLI program allows you to enter commands for managing your HD.
I'm going to show you only the commands you need to enter.

#### Clear partitions table

```
Command: o
Y
```

#### EFI partition (boot)

```
Command: n
ENTER
ENTER
+1G
EF00
```

#### SWAP partition

```
Command: n
ENTER
ENTER
+72G
8200
```

![](https://i.imgur.com/OYR4nnn.png)

#### Home partition (/)

```
Command: n
ENTER
ENTER
+500G
8302
```

#### Main partition

```
Command: n
ENTER
ENTER
ENTER
ENTER
```

#### Save changes and exit

```
Command: w
Y
```

### Format partitions

```bash
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4
```

### Mount partitions

```
swapon /dev/sda2
mount /dev/sda4 /mnt
mount --mkdir /dev/sda1 /mnt/boot
mount --mkdir /dev/sda3 /mnt/home
```

If you run the `lsblk` command you should see something like this:

```
   NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
   sda      8:0    0  1.27T  0 disk
   ├─sda1   8:1    0     1G  0 part /mnt/boot
   ├─sda2   8:2    0    72G  0 part [SWAP]
   ├─sda3   8:3    0   700G  0 part /mnt
   ├─sda4   8:4    0   500G  0 part /mnt/home
```

## 🥳 Installation

### Update the system clock

```bash
timedatectl set-ntp true
```

### Install Arch packages

```bash
pacstrap /mnt base base-devel linux linux-firmware vim
```

### Generate fstab file

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

## Add basic configuration

### Enter the new system

```bash
arch-chroot /mnt
```

### Language-related settings

```bash
vim /etc/locale.gen
```

Now you have to uncomment the language of your choice, for example:

```bash
en_US.UTF-8 UTF-8
es_AR.UTF-8 UTF-8
```

```bash
locale-gen
vim /etc/locale.conf
```

Add this content to the file:

```bash
LANG=en_US.UTF-8
LANGUAGE=en_US
LC_ADDRESS=es_AR.UTF-8
LC_IDENTIFICATION=es_AR.UTF-8
LC_MEASUREMENT=es_AR.UTF-8
LC_MONETARY=es_AR.UTF-8
LC_NAME=es_AR.UTF-8
LC_NUMERIC=es_AR.UTF-8
LC_PAPER=es_AR.UTF-8
LC_TELEPHONE=es_AR.UTF-8
LC_TIME=es_AR.UTF-8
```

```bash
vim /etc/vconsole.conf
```

Add this content to the file:

```bash
KEYMAP=es
```

### Configure timezone

```bash
ln -sf /usr/share/zoneinfo/America/Buenos_Aires /etc/localtime
hwclock —-systohc
```

### Enable SSH, NetworkManager and DHCP

These services will be started automatically when the system boots up.

```bash
pacman -S openssh dhcpcd networkmanager networkmanager-openvpn network-manager-applet
systemctl enable sshd
systemctl enable NetworkManager
```

### Install bootloader (GRUB)

```bash
pacman -S grub-efi-x86_64 efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch
grub-mkconfig -o /boot/grub/grub.cfg
```

You can replace "arch" with the id of your choice.

### Choose a name for your computer

Assuming your computer is known as "x1-extreme":

```bash
echo x1-extreme > /etc/hostname
```

### Adding content to the hosts file

```bash
vim /etc/hosts
```

And add this content to the file:

```
127.0.1.1  x1-extreme
::1        localhost ip6-localhost ip6-loopback
ff02::1    ip6-allnodes
ff02::2    ip6-allrouters

127.0.0.1  developer.dev.int.aws.lillegroup.com
```

Replace "x1-extreme" with your computer name.

### Update root password

```bash
passwd
```

### Final steps

```bash
exit
umount -R /mnt
swapoff /dev/sda2
reboot
```

## 😮‍💨 Post-install configuration

Now your computer has restarted and in the login window on the tty1 console you
can log in with the root user and the password chosen in the previous step.

### Add your user

Assuming your chosen user is "cmiranda":

```bash
useradd -m -g users -G wheel,storage,power,audio,video cmiranda
passwd cmiranda
```

### Grant root access to our user

```bash
EDITOR=vim visudo
```

Or if you prefer the standard behavior of most Linux distros you need to
uncomment this line:

```bash
%wheel ALL=(ALL) ALL
```

### Login into newly created user

```bash
su - cmiranda
```

### The coolest Pacman

If you want to make Pacman look cooler you can edit the configuration file and
uncomment the `Color` option and add just below the `ILoveCandy` option.

```bash
sudo vim /etc/pacman.conf
```

### Enable SSD TRIM

```bash
sudo systemctl enable fstrim.timer
```

### Install screen & split terminal

```bash
sudo pacman -S screen
screen
# Ctrl+a |   Split current region vertically into two regions
# Ctrl+a tab Switch the input focus to the next region
# Ctrl+a c   Create a new window (with shell)
```

### Install dotfiles

https://github.com/cristianmiranda/dotfiles
