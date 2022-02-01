# Pi-hole

PiHole is a DNS level adblocker, and it will also operate as our DHCP server.   
Read more about the project [here](https://pi-hole.net/).

## Installation

Before installing, make note that the folowing config options are different/non-default during setup:
* Change the webroot to `/var/www/pihole`
* You need to set up a static IP. Use the interface you plan to use (etho0 is Ethernet, wlan is WiFi).
* Google's DNS is fine.
* Install StevenBlack's adlists
* You should have configured a static IP for the Pi. Use it.
* Install the web interface.
* Do NOT install lighttpd (remember we're going to use apache2).
* Turn OFF logging. The reason for this is maintenance. We want set and forget.
* The privacy mode for FTL is up to you. It can be helpful for debugging reasons, but, I left mine on anonymous.
* Make a note of the password!

To run the installer, run   
`curl -sSL https://install.pi-hole.net | sudo bash`

## Set the Pi as the DHCP server
First, log into your router and disable the DHCP server there.
Then, log into the Pi-hole web interface in your browser at `{Pi-IP}/admin`, for example `192.168.0.2/admin/`.
- Click "login" and log in with the credentials presented to you at installation.
- Click "Settings" on the left hand side of the screen, then click "DHCP" along the top.
- Enable the DHCP server, and set the range of IP addresses to assign. I usually leave a few IP's on the lower end unassigned, as my router, Raspberry Pi, and other network devices get static IP addresses assigned.
- Click "save"

## Setting custom URLs
Becuase the Pi now operates as both the DNS and the DHCP server, it knows where each device on the network is. So we can tell it which address to go to when it receives a request.  

Let's simply set up the URL "pihole.raspberrypi/" to redirect to the Pi-hole admin page.

On the left hand side of the Pi-hole web interface, select "Local DNS" and then "DNS Records".
- Under "Domain" type "pihole.raspberrypi", where "raspberrypi" is the hostname of your Pi.
- Under "IP Address" type the IP address of your Pi.
- Click Add

And that's all there is to do on the Pi-hole side! Every time you want to add a custom domain, you can repeat this step.

## Setting up Apache2 as a reverse proxy
The Pi-hole will forward requests to "pi-hole.raspberrypi" back to the Raspberry Pi itself - but how does the Pi know which content to serve?  
That's where Apache 2 comes in.   

- Copy the "pihole.conf" configuration file to `/etc/apache2/sites-available`
- Run the following commands:
  - `$ sudo a2ensite pihole.conf`
  - `$ sudo systemctl reload apache2`

If that all goes according to plan, you should be able to visit "pihole.raspberrypi/" in your browser, and be presented with the Pi-hole interface!