#!/bin/bash

timedatectl set-ntp true
echo "set ntp..."
timedatectl set-timezone Asia/Shanghai
echo "set timezone..."

# fdisk /dev/nvme0n1

mkfs.fat -F32 /dev/nvme0n1p1
echo "mkfs fat..."
sleep 1
mkswap /dev/nvme0n1p2
echo "mkswap..."
sleep 1
mkfs.btrfs -f /dev/nvme0n1p3
echo "mkfs btrfs..."
sleep 1

mount /dev/nvme0n1p3 /mnt
echo "mount /mnt..."
sleep 1
btrfs subvolume create /mnt/@
echo "create subvolume /mnt/@..."
sleep 1
btrfs subvolume create /mnt/@home
echo "create subvolume /mnt/@home..."
sleep 1
btrfs subvolume create /mnt/@var
echo "create subvolume /mnt/@var..."
sleep 1
chattr +C /mnt/@var
echo "@var..."
sleep 1
umount /mnt
echo "umount /mnt..."
sleep 1

mount /dev/nvme0n1p3 /mnt -o subvol=@,compress=zstd
echo "mount nvme0n1p3"
sleep 1
mkdir /mnt/boot
echo "create /boot..."
sleep 1
mkdir /mnt/home
echo "create /home..."
sleep 1
mkdir /mnt/var
echo "create /var..."
sleep 1
mount /dev/nvme0n1p1 /mnt/boot
echo "mount nvme0n1p1 /boot"
sleep 1
mount /dev/nvme0n1p3 /mnt/home -o subvol=@home,compress=zstd,nosuid,nodev
echo "mount nvme0n1p3 /home..."
sleep 1
mount /dev/nvme0n1p3 /mnt/var -o subvol=@var
echo "mount nvme0n1p3 /var..."
sleep 1
swapon /dev/nvme0n1p2
echo "setup swap..."
sleep 1

echo "Ready to install: base base-devel linux linux-headers linux-firmware-intel linux-firmware-nvidia linux-firmware-realtek linux-firmware-other grub btrfs-progs intel-ucode efibootmgr bash zsh dhcpcd iwd nano vim openssh"
pacstrap /mnt base base-devel linux linux-headers linux-firmware-intel linux-firmware-nvidia linux-firmware-realtek linux-firmware-other grub btrfs-progs intel-ucode efibootmgr bash zsh dhcpcd iwd nano vim openssh

genfstab -U /mnt >> /mnt/etc/fstab
echo "Base system is ready..."

echo "Next setup with *arch-chroot /mnt*"
exit 0