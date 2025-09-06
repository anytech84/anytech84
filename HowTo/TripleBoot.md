This tutorial is meant to explained how to create a Triple Boot system on your Intel-based Mac.

# Requirements 

### Hardware
- A Mac with an Intel processor
- 2 USB drive with at least 8GB of storage
### Software
- A Windows ISO (Windows 10 is recommended)
- A Linux ISO (Debian-based distros are recommended)

# Before you start

1. Back-up your macOS version on a USB drive

> As Internet Recovery is not always reliable, it is recommended to have a USB drive with your macOS version on it. In case it goes wrong, you can always boot on it and reinstall macOS.
- Download the macOS version you are using from the App Store. 

```zsh
# Replace ${version} with the version of macOS you are using
sudo /Applications/Install\ macOS\ ${version}.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume
```

2. Create a Linux bootable USB drive
> Use Etcher to create a bootable USB drive. Otherwise, you can use the following command:

```zsh
sudo dd if=/path/to/your/linux.iso of=/dev/diskX bs=1m
```

3. Disable FileVault / Secure Boot / SIP

```zsh
sudo fdesetup disable
sudo firmwarepasswd -delete
csrutil disable
```

4. Remove previous installations of Windows and Linux
```
sudo diskutil mount disk0s1
cd /Volumes/EFI/EFI
rm -r boot ubuntu windows
cd ~
diskutil unmount disk0s1
```

# Installation

1. Create a partition for Linux

```zsh
sudo diskutil apfs resizeContainer disk0s2 <size>
```
- BEWARE: Only shrink space, you can't expand it. It would break the `APFS` container.

2. Install Windows 
> Windows will be installed first as it is the most restrictive OS in terms of partitioning.
> It could break the GRUB bootloader, so it is recommended to install it first.

- Just use Boot Camp Assistant to create a partition for Windows.

3. Install Linux 

- Temporarily rename the `EFI` folder to avoid conflicts with the Windows bootloader

> On MacOS :
```zsh
sudo diskutil mount disk0s1
cd /Volumes/EFI
mv EFI EFI.win
cd ~
diskutil unmount disk0s1
```
> On Linux :
```bash
sudo -i
mkdir efi
mount /dev/sda1 efi
mv efi/EFI efi/EFI.win
umount efi
rmdir efi
exit
```

- Reboot your macOS and boot on the Linux USB drive with the `Option` key pressed.

You will need to create the following partitions:
- A `256MB` EFI partition
- A `/` partition with left-over space

Just follow the installation process and install the bootloader on the `256MB` EFI partition.

4. Restore the macOS bootloader

> After Linux reboot, you will need to restore the macOS bootloader.

```bash
sudo -i
mkdir efi
mount /dev/sda3 efi
mv /boot/efi/EFI efi
mv /boot/efi/EFI.win /boot/efi/EFI
umount efi
rmdir efi
fatlabel /dev/sda3 GRUB
```

> Update the fstab file

```bash
blkid /dev/sda1 /dev/sda3
# Copy the UUID of the `GRUB` partition (/dev/sda3)
nano /etc/fstab
# Replace the UUID of the `GRUB` partition with the one you copied
```

5. Reboot and enjoy your Triple Boot system

# Boot your Windows and Linux installation through macOS VMWare Fusion

> Create 2 new VM in VMWare Fusion called `Windows` and `Linux`

- Create a new virtual disk for Windows
```zsh
cd /Virtual\ Machines.localized/Windows.vmwarevm
rm Windows.vmdk
# Replace <partNums> with the partition numbers of your Windows installation
/Applications/VMware\ Fusion.app/Contents/Library/vmware-rawdiskCreator create /dev/disk0 <partNums> rawDisk ide
echo "
ide0:0.present = "TRUE"
ide0:0.fileName = "rawDisk.vmdk"
ide0:0.deviceType = "rawDisk"
suspend.disabled = "TRUE"
" >> Windows.vmx
# Remove the Windows.vmdk configuration form the VMX file !
```

- Create a new virtual disk for Linux
```zsh
cd /Virtual\ Machines.localized/Linux.vmwarevm
rm Linux.vmdk
# Replace <partNums> with the partition numbers of your Linux installation (DON'T FORGET TO ADD THE EFI PARTITION)
/Applications/VMware\ Fusion.app/Contents/Library/vmware-rawdiskCreator create /dev/disk0 <partNums> rawDisk ide
echo "
ide0:0.present = "TRUE"
ide0:0.fileName = "rawDisk.vmdk"
ide0:0.deviceType = "rawDisk"
suspend.disabled = "TRUE"
" >> Linux.vmx
# Remove the Linux.vmdk configuration form the VMX file !
```

4. Boot your VMs and enjoy your Triple Boot system INTO your macOS

> Warning : You can only boot one OS at a time. If you want to boot another OS, you will need to shut down the VM and boot the other one.
> Unmount the Dual Boot partition on your macOS to avoid conflicts with the VMs

