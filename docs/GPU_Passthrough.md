# GPU Passthrough

* Video instructions: https://www.youtube.com/watch?v=eBJBH7LFd0E
* Arch wiki: https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF

## 1 - Enable VT-d in BIOS
https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#Setting_up_IOMMU

Ensure that AMD-Vi/Intel VT-d is supported by the CPU and enabled in the BIOS settings. Both normally show up alongside other CPU features (meaning they could be in an overclocking-related menu) either with their actual names ("VT-d" or "AMD-Vi") or in more ambiguous terms such as "Virtualization technology".

## 2 - [Enable IOMMU in GRUB](https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#Enabling_IOMMU)
```bash
# Edit GRUB
sudo vim /etc/default/grub

# Add "intel_iommu=on" to GRUB_CMDLINE_LINUX_DEFAULT
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on"

# Regenerate grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Reboot and check
dmesg | grep -i -e DMAR -e IOMMU
```

## 3 - Check PCI ids
```bash
#!/bin/bash
shopt -s nullglob
for g in `find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V`; do
    echo "IOMMU Group ${g##*/}:"
    for d in $g/devices/*; do
        echo -e "\t$(lspci -nns ${d##*/})"
    done;
done;

# Example output
IOMMU Group 0:
	00:00.0 Host bridge [0600]: Intel Corporation 10th Gen Core Processor Host Bridge/DRAM Registers [8086:9b44] (rev 02)
IOMMU Group 1:
	00:01.0 PCI bridge [0604]: Intel Corporation 6th-10th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 02)
	01:00.0 VGA compatible controller [0300]: NVIDIA Corporation TU117M [GeForce GTX 1650 Ti Mobile] [10de:1f95] (rev a1)
```

`10de:1f95` is the PCI id for the GPU

## 4 - [Isolate the GPU](https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#Binding_vfio-pci_via_device_ID)

```bash
# Edit GRUB
sudo vim /etc/default/grub

# Add "vfio-pci.ids=10de:1f95" to GRUB_CMDLINE_LINUX_DEFAULT
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on vfio-pci.ids=10de:1f95"

# Regenerate grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

then let's [make vfio-pci to load early](https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#Loading_vfio-pci_early) 
```bash
sudo vim /etc/mkinitcpio.conf

# Make sure these modules are loaded early
MODULES=(... vfio_pci vfio vfio_iommu_type1 vfio_virqfd ...)

# Make sure modconf is included in HOOKS
HOOKS=(... modconf ...)

# Apply changes
sudo mkinitcpio -P
```

Reboot and check that it worked:
```bash
dmesg | grep -i vfio
```

## 5 - Setup VM

Now download Windows ISO and create a VM following instructions here: https://youtu.be/eBJBH7LFd0E?t=407

---

## Extras

### Required XML fragments for VM customization
```xml
<domain xmlns:qemu="http://libvirt.org/schemas/domain/qemu/1.0" type="kvm">

<kvm>
  <hidden state="on"/>
</kvm>

<vendor_id state="on" value=""/>

<qemu:commandline>
  <qemu:arg value="-acpitable"/>
  <qemu:arg value="file=/home/cmiranda/quemu_battery_mock.dat"/>
</qemu:commandline>
```

### 8+ cores huge VM boot time

Read more @ https://listman.redhat.com/archives/vfio-users/2018-November/msg00021.html

bottom line, just use 1 socket, 4 cores and 2 threads (vCPU allocation = 8)

```xml
<vcpu placement="static" cpuset="0-8">8</vcpu>
```

### Windows activation

Remove the network adapter from the VM (NIC:...) to prevent Microsoft from validating license.

## Result

When the VM starts the connected external displays turn on and Windows is fully usable with almost native performance GPU capabilities.

![ezgif-2-ec4edd38fc](https://user-images.githubusercontent.com/972572/147163434-165bb4fc-13f6-49ed-b751-1a556091871e.gif)

![](https://i.imgur.com/4Q3rXg0.png)

![](https://i.imgur.com/06KrcNN.png)

![](https://i.imgur.com/4HOtnTs.png)

Note: The dGPU is unusable by the host when this is done. Having two GRUB entries and a [custom mkinitcpio](https://wiki.archlinux.org/title/Mkinitcpio#Customized_generation) to switch between the two modes (having GPU passthrough enabled and not having it) might be a good idea.
