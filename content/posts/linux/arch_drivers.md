---
title: "Archlinux 驱动"
subtitle: "必备的Archlinux驱动安装和使用"
date: 2021-06-17T17:36:43+08:00
lastmod: 2021-06-17T17:36:43+08:00
draft: false
author: "Borer"
authorLink: "https://github.com/JanU-YieG"
description:
hiddenFromHomePage: false
hiddenFromSearch: false
featuredImage: "https://img.maocdn.cn/img/2021/06/07/728908.jpg"
featuredImagePreview: "https://img.maocdn.cn/img/2021/06/07/728908.jpg"
weight: 1
resources:
- name: ""
  src: "xx.jpg"
keywords: ["Linux", "linux","arch","linux driver","bluetooth"]
tags: ["Archlinux", "Linux-driver"]
categories: ["Archlinux","Linux"]
lightgallery: true
toc:
  enable: true
math:
  enable: false
showTags: true
license: ""
summary: "Archlinux 必要驱动安装和使用教程"
---

<!--more-->

## 无线(wifi)
#### iwd
1. 安装iwd
    ```
    sudo pacman -S iwd
    ```
2. 使用
    - 进入iwd管理
    ```
    iwctl
    ```
    - 命令使用并连接wifi
    ```
    //查看适配器列表
    adapter list
    //查看无线设备
    device list
    //如果没有打开适配器和无限设备则打开
    adapter adapter-name(phy0) set-property Powered on
    device device-name(wlan0) set-property Powered on
    //扫瞄wifi
    station device-name(wlan0) scan
    //显示所有wifi
    station device-name(wlan0) get-networks
    //连接wifi
    station device-name(wlan0) connect wifi-name
    ```

## 蓝牙(bluetooth)
#### bluez
1. 安装bluez和工具
    ```
    sudo pacman -S bluez
    sudo pacman -S bluez-utils
    sudo pacman -S bluez-tools
    ```
2. 查看蓝牙驱动`btusb`内核模块是否加载
    ```
    //查看
    modprobe info btusb
    //加载模块
    modprobe btusb
    //或者按照文件名加载
    // insmod filename [args]
    //移除模块
    //modprobe -r module_name
    //或者
    //rmmod module_name
    ```
3. 查看是否被`rfkill`禁用
    ```
    //查看:Hard blocked则去BIOS配置开启，Soft blocked则使用rfkill 打开
    rfkill list
    //打开Soft blocked
    sudo rfkill unblock bluetooth
    ```

4. 开启bluetooth.service
    ```
    //开启
    sudo systemctl start bluetooth.service
    //开机自启动
    sudo systemctl enable bluetooth.service
    ```
5. bluetoothctl使用
    - 进入蓝牙管理
        ```
        bluetoothctl
        ```
    - 连接蓝牙设备
        ```
        //选择一个蓝牙接收器
        //select MAC_address
        //开启蓝牙
        power on
        //选择要连接的设备类型
        agent on
        //确认并完成要连接的设备类型
        default-agent
        //搜索所有可配对的设备
        scan on
        //获取所有设备MAC地址
        devics
        //配对设备
        pair MAC_address
        //连接
        connect MAC_address
        //如果设备不需要配对码(PIN)，可以将设备加入信任列表
        //trust MAC_address
        ```
6. 配置蓝牙开机后自启动
    > 在文件`/etc/bluetooth/main.conf`底部的`[Policy]`下面添加`AutoEnable=true`
    ```
    [Policy]
    AutoEnable = true
    ```
7. 蓝牙音频输出
    需要先安装`pulseaudio-bluetooth`,可以使用`pavucontrol`选择音频的输出设备。如果全局的PulseAudio设置，确保运行守护进程(一般是`pulse`)用户在`lp`组，并且PulseAudio配置中加载蓝牙模块：
    ```
    .....
    load-module module-bluetooth-policy
    load-module module-bluetooth-discover
    .....
    ```
8. `pavucontrol`工具选择音频的输出设备
    ```
    sudo pacman -S pavucontrol
    ```
9. `Failed to set power on :org.bluz.Error.Failed`
  ```
  sudo systemctl start bluetooth
  sudo systemctl enable bluetooth
  rfkill unblock bluetooth
  ```
## 音频
1. install the `pulsemixer` is the CLI
  ```
  sudo pacman -S alsa-utils alsa pulseaudio pulsemixer
  ```
