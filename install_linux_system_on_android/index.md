# Install linux on android


## Install linux using Andronix

### Prerequisite:
- Android Device (Stock unmodified device, no root or custom recovery required)
- These apps : 
    - Andronix
    - termux(An android terminal emulator and linux environment app that works directly with no rooting or setup required.)
    - NetHunter-KeX client(connect your kali linux via VNC,can display your kali customing desktop.)
    - Hacker's keyboard
    - Caps to Ctrl(Changing your physical keyboard Caps and Ctrl.)

### Installation:

1. open `andronix` and choose the linux you want to install.
2. click what you want release linux to install(it auto copy the code)
3. open your `terminal` and paste the copy code in step 2.
4. enter your linux in terminal.
5. open the VNC(`vncserver`),enter your vnc passwd
6. open the app `NetHunter Kex` ,choose the connection type UltraVNC,
7. input the info what you have set in linux.

### note:
###### set your linux:
- set zone
    ```
    ls /usr/share/zoneinfo
    ln -sf /usr/share/zoneinfo/<your Region>/<your City> /etc/localtime
    ```
- locale setting
    ```
    #uncomment:en_US UTF-8,zh_CN UTF-8
    vim /etc/locale.gen
    #create locale
    locale-gen
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
    export LANG=en_US.UTF-8
    ```
- set arch locel LANG
    open termux ,and then change the file `start-arch.sh`(`command=" LANG=C.UTF-8"` to `comand=" LANG=en_US.UF-8"`)
- install fonts
    ```
    #english font
    pacman -S ttf-dejavu
    #chinese fonts
    pacman -S wqy-microhei
    ```
    ###### install some apps:
- login other user vnc
    ```
    useradd -m username
    passwd username
    su username
    vncpasswd
    //localhost:2
    vncserver :2
    //search your monitor
    xrandr --listmonitors
    //set resolution and scale
    xrandr --output your-monitor --resulotion ***x*** --scale *x*
    ```

###### some apps
- neovim
    ```
    pacman -S neovim
    ```


## Install Kali using NetHunter
### Prerequisite:
- Android Device (Stock unmodified device, no root or custom recovery required)
- These apps : 
    - NetHunter store(A installable catalogue of Android apps for penetration testing and forensics)
    - f-droid(an installable catalogue of FOSS(Free and Open Source Software) applications for the Android platform.)
    - termux(An android terminal emulator and linux environment app that works directly with no rooting or setup required.)
    - NetHunter-KeX client(connect your kali linux via VNC,can display your kali customing desktop.)
    - Hacker's keyboard
    - Caps to Ctrl(Changing your physical keyboard Caps and Ctrl.)

### Installation:

###### Install the necessary apps from f-droid
1. Install the [f-droid](https://f-droid.org/)
2. Install the `termux` from `f-droid`
3. Install the `NetHunter-Kex` from `NetHunter store`
4. Install the `Hacker's keyboard` from `NetHunter store`
5. Install the [Caps to Ctrl](https://github.com/JanU-YieG/books-tools/raw/main/tool-software/android-tools/jpkcm-tcen-release.apk)

###### Install kali linux in termux
open the termux and then execute the following command:
```
termux-setup-storage
pkg update
pkg install wget
wget -O install-nethunter-termux https://offs.ec/2MceZWr
chmod +x install-nethunter-termux
./install-nethunter-termux
```

### Usage:
Open termux and type one of following:(`nethunter` can be abbreviated to `nh`)
|   Command    |   To   |
|:-------------|:-------|
|`nh` |start Kali NetHunter command line interface|
|`nh kex passwd` | configure the KeX passwd(only needed before 1st use) |
|`nh kex &` | start Kali NetHunter Desktop Experience user sessions |
|`nh kex stop` | stop Kali NetHunter Desktop Experience |
|`nh <command>` | run in NetHunter environment |
|`nh -r` | start Kali NetHunter cli as root |
> *Tips:*
> - These commands add `-r` express the nethunter cli as root,eg:`nh -r kex kill`:Kill all KeX sessions.
> - If you run kex in the background (&) without having set a password, bring it back to the foreground first when prompted to enter the password, i.e. via fg <job id> - you can later send it to the background again via Ctrl + z and bg <job id>

### NetHunter Kex Cli configuration

1. Open termux exec the command `nh kex &`, and then keep the output infos in mind.
2. If you won't set the kex passwd ,can execute the `nh kex passwd` set the passwd.
3. open `NetHunter Kex` client app.
4. New a configuration and input the following configs:
    - *Connection Type* select the `Basic VNC`.
    - *VNC Connection Settings* write `localhost:1`,and port `5091`(these values in the step 1).
    - *passwd* write the passwd that you used the command `nh kex passwd` set.
    - click the *Connect*.
5. Well Done!

### NetHunter Editions:
Please refer to [this table](https://www.kali.org/docs/nethunter/#1-0-nethunter-editions) for a comparison of the different NetHunter editions.

###### Tips:

1. Run `sudo apt update` && `sudo apt full-upgrade -y` first thing after installation to update Kali. If you have plenty of storage space available you might want to run `sudo apt install -y kali-linux-default` as well.
2. Some utilities like “top” won’t run on unrooted phones.
3. Non-root users still have root access in the chroot. That’s a proot thing. Just be aware of that.
4. Perform regular backups of your rootfs by stopping all nethunter sessions and typing the following in a termux session: `tar -cJf kali-arm64.tar.xz kali-arm64 && mv kali-arm64.tar.xz storage/downloads` That will put the backup in your Android download folder. Note: on older devices, change “arm64” to “armhf”
5. [Kali Forums](https://forums.kali.org/forumdisplay.php?14-NetHunter-Forums)

### Note:
1. If you execute `sudo apt update` && `sudo apt upgrade` or `sudo apt full-upgrade -y`,and then maybe cause the following errors:
    ```
    vncserver: No matching VNC server running for this user!
    vncserver: No matching VNC server running for this user!
    Error starting the KeX server.
    Please try "nethunter kex kill" or restart your termux session and try again.
    ```
    Then you should install tightvncserver to fix it.
    ```
    sudo apt install tightvncserver
    ```
    execute tightvncserver:
    ```
    tightvncserver
    ```
    > The solution from the reference [website](https://dannyda.com/2021/03/28/how-to-resolve-after-upgrade-nethunter-kali-linux-cant-start-connect-to-vnc/).
    >
    > And then you should replace some comand keyword `kex` with the `tightvncserver`.

