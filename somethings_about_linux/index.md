# Somethings about linux

### The XF86 keyboard symbols
```
XF86AddFavorite;XF86ApplicationLeft;XF86ApplicationRight;XF86AudioMedia;XF86AudioMute;XF86AudioNext;XF86AudioPause;XF86AudioPlay;XF86AudioPrev;XF86AudioLowerVolume;XF86AudioRaiseVolume;XF86AudioRecord;XF86AudioRewind;XF86AudioStop;XF86Away;XF86Back;XF86Book;XF86BrightnessAdjust;XF86CD;XF86Calculator;XF86Calendar;XF86Clear;XF86ClearGrab;XF86Close;XF86Community;XF86ContrastAdjust;XF86Copy;XF86Cut;XF86DOS;XF86Display;XF86Documents;XF86Eject;XF86Excel;XF86Explorer;XF86Favorites;XF86Finance;XF86Forward;XF86Game;XF86Go;XF86History;XF86HomePage;XF86HotLinks;XF86Launch0;XF86Launch1;XF86Launch2;XF86Launch3;XF86Launch4;XF86Launch5;XF86Launch6;XF86Launch7;XF86Launch8;XF86Launch9;XF86LaunchA;XF86LaunchB;XF86LaunchC;XF86LaunchD;XF86LaunchE;XF86LaunchF;XF86LightBulb;XF86LogOff;XF86Mail;XF86MailForward;XF86Market;XF86Meeting;XF86Memo;XF86MenuKB;XF86MenuPB;XF86Messenger;XF86MonBrightnessUp;XF86MonBrightnessDown;XF86Music;XF86MyComputer;XF86MySites;XF86New;XF86News;XF86Next_VMode;XF86Prev_VMode;XF86OfficeHome;XF86Open;XF86OpenURL;XF86Option;XF86Paste;XF86Phone;XF86Pictures;XF86PowerDown;XF86PowerOff;XF86Next_VMode;XF86Prev_VMode;XF86Q;XF86Refresh;XF86Reload;XF86Reply;XF86RockerDown;XF86RockerEnter;XF86RockerUp;XF86RotateWindows;XF86RotationKB;XF86RotationPB;XF86Save;XF86ScreenSaver;XF86ScrollClick;XF86ScrollDown;XF86ScrollUp;XF86Search;XF86Send;XF86Shop;XF86Sleep;XF86Spell;XF86SplitScreen;XF86Standby;XF86Start;XF86Stop;XF86Support;XF86Switch_VT_1;XF86Switch_VT_10;XF86Switch_VT_11;XF86Switch_VT_12;XF86Switch_VT_2;XF86Switch_VT_3;XF86Switch_VT_4;XF86Switch_VT_5;XF86Switch_VT_6;XF86Switch_VT_7;XF86Switch_VT_8;XF86Switch_VT_9;XF86TaskPane;XF86Terminal;XF86ToDoList;XF86Tools;XF86Travel;XF86Ungrab;XF86User1KB;XF86User2KB;XF86UserPB;XF86VendorHome;XF86Video;XF86WWW;XF86WakeUp;XF86WebCam;XF86WheelButton;XF86Word;XF86XF86BackForward;XF86Xfer;XF86ZoomIn;XF86ZoomOut;XF86iTouch 
```

### display partitions UUID TYPE PARTUUID

    /etc/fstab
    ```
    //blkid or lsblk
    lsblk -fs
    ```

### Bluetooth arch

### gdm

### Sway arch


### Gnome arch

### console-setup
> you can set configs about tty(1-6) in the file -- /etc/default/console-setup and /usr/share/console-setup/console-setup

### some tools
- umtui : connect the wifi
- iwd : manage the networks (arch)
- fzf : 
- navi : 
- lsd : 
- neovim : 
- rust : 
- gdm : 
- systemd-boot : 
- sway : 
- console-setup : 
- ffsend : 
- flameshot : 
- hollwood : 
- xclip: If you are using Linux, you need to install xclip if using X11 or wl-copy and wl-paste if using Wayland.

### systemd-boot (efi,boot,arch)
A simple UEFI boot manager which execute configured EFI images.

###### Installing the EFI boot manager
1. **check UEFI mode**
   > make sure your system has booted in UEFI mode and that UEFI variables are accessible.
   ```
   ls /sys/firmware/efi/efivars
   //or efivar --list
   ```
2. **install into the `esp`**
   > `esp` will denote the `ESP mountpoint`,eg:`/boot` or `/efi/`
   ```
   bootctl install
   ```
   > This will copy the `systemd-boot` boot loader to eht EFI partition: on a x64
   > architecture system `/usr/lib/systemd/boot/efi/systemd-bootx64.efi` will be copied
   > to `esp/EFI/systemd/-bootx64.eft` and `esp/EFI/BOOT/BOOTx64.EFI`. It will then set
   > `systemd-boot` as the default EFI application(default boot entry) loaded by the
   > EFI BOOT Manager.
   >> ***note:*** If you want to separate the `esp` partition,use `bootctl
   >> --esp-path=/efi-path --boot-path=/boot-path install`

###### Updating the EFI boot manager
1. **manual update**
    ```
    bootctl --esp-path=/efi-path --boot-path=/boot-path update
    ```
2. **automatic update**
    > placing the following pacman hook in the `/etc/pacman.d/hooks/` directory:
    ```
    vim /etc/pacman.d/hooks/100-systemd-boot.hook
    [Trigger]
    Type = Package
    Operation = Upgrade
    Target = systemd

    [Action]
    Description = Updating systemd-boot
    When = PostTransaction
    Exec = /usr/bin/bootctl update
    ```

###### Configuration
1. **loader configuration**
    > there are some config options
    ```
    default
    timeout
    editor
    auto-entries
    console-mode
    random-seed-mode
    always
    ```
    > eg:A loader configuration example is provided below:
    **esp/loader/loader.conf**
    ```
    default arch.conf
    timeout 4
    console-mode max
    editor no
    ```
###### EFI shells or other EFI applications
1. **loading from `esp/loader/entries/xxxx.conf`**
    eg: `/EFI/xxx.efi` the relative path via `esp`
    ```
    esp/loader/entries/uefi-shell-v1-x86_64.conf
    title UEFI Shell x86_64 v1
    efi /EFI/shellx64_v1.efi
    ```

###### Kernel parameters editor with password protection
```
sbpctl install *esp*
```


