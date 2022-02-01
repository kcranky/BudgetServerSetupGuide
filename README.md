# Budget Server Setup Guide

Details for how to set up different apps on the Pi for my budget server.

## Requirements
* You should have your Raspberry Pi set up
* Your Raspberry Pi should be configured with a static IP
* You should be able to access the Pi over SSH
* You should feel comfortable working in a terminal

## Some notes
This text assumes you still have "raspberrypi" as your device's hostname. If you've changed that, change it when it appears in these guides.

## Prefer a video guide?
- Learn how to set up your Pi! Check out my videos for the [Pi Zero](https://youtu.be/2vqEQVoK58M) and the [Pi 3/3b+/4.](https://youtu.be/vCw9wKQp4lU)
- View Part 1 (Core Services) of this guide [here,](https://youtu.be/Iou4qwLkyzs) where I also explain how DNS works!

# Part 1: Core Services

### 1. Install git

 `$ sudo apt install git`

### 2. Install Apache2 and PHP

 `$ sudo apt install apache2 php libapache2-mod-php -y`

Verify installation by opening a browser and going to the IP of the Raspberry Pi.

You should see this image:   
![apache2-default.png][logo]

[logo]: images/apache2-default.png "Apache 2 Default Page"

### 3. Install Pi-hole and Configuring Custom URLs

Pi-hole is a DNS level adblocker, and will also work as the DHCP server.

See the guide [here.](Pi-hole.md)

# Part 2: Additional Services
This section of the guide isn't essential, but they're services I've found useful over my many years of running the Budget Home Server.

### 1. File Browser

### 2. Jellyfin

### 3. Calibre
