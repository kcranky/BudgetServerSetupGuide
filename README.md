# Budget Server Setup Guide

Details for how to set up different apps on the Pi for my budget server.

## Requirements
* You should have your Raspberry Pi set up
* Your Raspberry Pi should be configured with a static IP
* You should be able to access the Pi over SSH
* You should feel comfortable working in a terminal

## Some notes
- This repo assumes you still have "raspberrypi" as your device's hostname. If you've changed that, change it when it appears in these guides. 
- This repo assumes your PI's static IP is 192.168.1.244. If you have a different IP on your Pi, be sure to substitute it, and edit any scripts before running them.

## Prefer a video guide?
- Learn how to set up your Pi! Check out my videos for the [Pi Zero](https://youtu.be/2vqEQVoK58M) and the [Pi 3/3b+/4.](https://youtu.be/vCw9wKQp4lU)
- View Part 1 (Core Services) of this guide [here,](https://youtu.be/Iou4qwLkyzs) where I also explain how DNS works!

---
# Part 1: Core Services

## 1. Install git

 `$ sudo apt install git`

## 2. Install Apache2 and PHP

 - `$ sudo apt install apache2 php libapache2-mod-php -y`
 - We're also going to install all the required Apache2 modules for all services listed here, to avoid missing dependancies:   
 `$ sudo a2enmod proxy_http rewrite`

Verify installation by opening a browser and going to the IP of the Raspberry Pi.

You should see this image:   
![apache2-default.png][logo]

[logo]: images/apache2-default.png "Apache 2 Default Page"

## 3. Install Pi-hole and Configuring Custom URLs

Pi-hole is a DNS level adblocker, and will also work as the DHCP server.

See the guide [here.](Pi-hole.md)

---

# Part 2: Additional Services
This section of the guide isn't essential, but they're services I've found useful over my many years of running the Budget Home Server.

## 1. Permanently mount external storage
Pretty much a requirement for most of these additional services.   
Read the guide [here](MountDrive.md).

## 2. File Browser
Read the guide [here](FileBrowser.md).

## 3. Jellyfin
### Part 1: Installation
- Run `$ sudo rpi-update` and follow the prompts. Reboot if need be.
- Run `$ wget  https://raw.githubusercontent.com/kcranky/BudgetServerSetupGuide/main/scripts/jellyfin.sh`
- Run `$ sudo chmod +x jellyfin.sh`
- Run `$ sudo ./jellyfin.sh`

### Part 2: Configuration
- Navigate to `media.raspberrypi/` in your browser

## 4. Calibre

## 5. Network UPS Tools (NUT)
Read the guide [here](NUT.md).
