# Archlinux install

## Make a U boot disk

**notes:**

- install archlinux from USB-Live
- UEFI model install
- something in square brackets is option
- makeing a USB boot disk can search by gogole



## install archlinux system

##### check efi

```
ls /sys/firmware/efi/efivars
```

##### connect wifi used iwctl

If your wifi device the property Powered is off,and your device adapter the property Powered is off also,you should turn on the both.you can exec the following command in iwctl:

note:my adapter is phy0 and wifi device is wlan0

```
iwctl
//show your adapter list
adapter list
//show your device
device list
adapter <adatper-name> set-property Powered on
device <device-name> set-property Powered on

//scan wifi around
station <devicename> scan
//show the result that scan
station <devicename> get-networks
//connect the specified wifi
station <devicename> connect <wifi-ssid>
```

##### update your systemtime

```
timedatectl set-ntp true
timedatectl status
```

##### disk partition

I separate my disk : efi(1G),root(50G),home(180G),swap(30G)

```
//list your all disks
fdisk -l
//disk your choose partition---note that root partition is necessary
fdisk /dev/<your partition>
```

##### disk formatting

```
//root home is ext4 or other
mkfs.ext4 /dev/<your root/home partition>
//UEFI--EFI
mkfs.fat -F32 /dev/<your efi partition>
//swapp
mkswap /dev/<your swap partition>
swapon /dev/<your swap partition>
```

##### mount partitions

```
mount /dev/<your root partition> /mnt
mkdir /mnt/efi
mount /dev/<your efi partition> /mnt/efi
mkdir /mnt/home
mount /dev/<your home partition> /mnt/home
```

##### install linux and other necessary things

```
pacstrap /mnt base linux linux-firmware base-devel vim
```

**notes: **you have completed the base installation.

##### config system

```
//create fstab file
genfstab -U /mnt >> /mnt/etc/fstab
//check fstab
cat /mnt/etc/fstab
```

##### enter your installed archlinux

```
arch-chroot /mnt
```

##### set zone

```
ls /usr/share/zoneinfo
ln -sf /usr/share/zoneinfo/<your Region>/<your City> /etc/localtime
hwclock --systohc --utc
```

##### locale setting

```
//uncomment:en_US UTF-8,zh_CN UTF-8
vim /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
export LANG=en_US.UTF-8
echo myarch > /etc/hostname
```

##### network setting

```
// 127.0.0.1 localhost
// ::1 localhost
// 127.0.1.1 myarch
vim /etc/hosts
```

##### set root password

```
passwd root
```

#####  grub

```
pacman -S grub efibootmgr dosfstools openssh os-prober mtools linux-headers linux-lts linux-lts-headers
// grub-install [--target=x86_64-efi] --efi-directory=/efi [--bootloader-id=<your boot name>]
grub-install --target=x86_64-efi --bootloader-id=<your boot name> --recheck
//set locale for grub
//cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
grub-mkconfig -o /boot/grub/grub.cfg
```

##### install network control tool : iwd

```
pacman -S iwd
```

##### config your network

```
//[General]
//EnableNetworkConfiguration=true
vim /etc/iwd/main.conf
//or install dhcpcd
pacman -S dhcpcd
systemctl start dhcpcd
systemctl enable dhcpcd
//start and enable some service about your networks
systemctl start iwd.service
systemctl enable iwd.service
systemctl start systemd-resolved.service
systemctl enable systemd-resolved.service
```

**note:** then you can connect your network like above

##### add user

I add user into the group wheel
```
useradd -m -G "extra group" -s "login shell" "username"
```

##### give user sudo permission

```
pacman -S sudo
//add "yourname ALL=(ALL) ALL" under the line "root ALL=(ALL) ALL"
vim /etc/sudoers
```

##### install fonts

```
//english font
pacman -S ttf-dejavu
//chinese fonts
pacman -S wqy-microhei
```

##### some other softwares

```
//Xarchiver is a front-end to various command line archiving tools for Linux and BSD operating systems, designed to be independent of the desktop environment.  It is the default archiving application of Xfce and LXDE.It handles encrypted *.7z, *.arj, *.lrz, *.rar and *.zip archives
   pacman -S xarchiver

   //mount filetype ntfs
   pacman -S ntfs-3g
   //voice
   //sudo pacman -S alsa-utils alsa-plugins alsa-lib
   //alsamixer
   pacman -S pulseaudio

   //you can install .deb
   //dpkg -i *****.dev
   pacman -S dpkg

   //some base-devel
   pacman -S base-devel
```

##### last

```
reboot
exit
umount -R /mnt
reboot
```

## after entering arch

##### install display service

```
//install xorg(display server) or wayland()
<!-- pacman -S xorg -->
//install GPU driver that your computer supported
//intel
//pacman -S xf86-video-intel
//NVIDIA
//pacman -S xf86-video-nouveau
```

##### install xfce4 desktop

```
pacman -S xfce4 xfce4-goodies
pacman -S lightdm lightdm-gtk-greeter

//[Seat:*]
//...
//greeter-session=lightdm-gtk-greeter
//...
vim /etc/lightdm/lightdm.conf
systemctl enable lightdm.service
```

**Or install gnome desktop**

```
pacman -S xorg
pacman -S gnome
pacman start gdm.service
pacman enable gdm.service
systemctl enable NetworkManager.service
```

**Or install sway desktop**

```
pacman -S sway qt5-wayland
pacman -S gdm
//config auto start sway:add the following code into .zshrc(my login shell exec zsh)
if [ "$(tty)" = "/dev/tty1" ]; then
    exec sway
fi
```


