## Making eth0 work (ethernet cable)

* See https://linuxconfig.org/how-to-switch-back-networking-to-etc-network-interfaces-on-ubuntu-20-04-focal-fossa-linux

```bash
sudo apt update
sudo apt install -y ifupdown net-tools

sudo cat <<EOT > /etc/network/interfaces
# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug eth0
iface eth0 inet dhcp
EOT
```

Edit grub:

```bash
sudo vim /etc/default/grub

#  GRUB_CMDLINE_LINUX=""
#  GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"

sudo update-grub

```
