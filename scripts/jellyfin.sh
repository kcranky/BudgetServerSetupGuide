#! /bin/bash
if grep -q ": Raspberry Pi 3" /proc/cpuinfo
then
        PI=3
elif grep -q ": Raspberry Pi 4" /proc/cpuinfo
then
        PI=4
else
    echo "Unsupported RPI, exiting."
    exit 0
fi


# install jellyfin
apt install apt-transport-https
wget -O - https://repo.jellyfin.org/jellyfin_team.gpg.key | apt-key add -
echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/$( awk -F'=' '/^ID=/{ print $NF }' /etc/os-release ) $( awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release ) main" | tee /etc/apt/sources.list.d/jellyfin.list
apt update
apt install jellyfin -y
systemctl enable jellyfin

# Do the apache2 stuff
wget https://raw.githubusercontent.com/kcranky/BudgetServerSetupGuide/main/apache2-sites-available/jellyfin.conf -P /etc/apache2/sites-available
a2ensite jellyfin.conf
systemctl reload apache2

# Enable hardware acceleration
usermod -aG video jellyfin
systemctl restart jellyfin

if test -f "/boot/config.txt";
then
    sed -i '/gpu_mem=*/d' /boot/config.txt
fi

if [[ $PI == 3 ]]
then
    echo "gpu_mem=256" >> /boot/config.txt
else
    echo "gpu_mem=320" >> /boot/config.txt
fi

## Add the DNS entry to the PiHole list
echo "192.168.1.244 media.raspberrypi" | tee -a /etc/pihole/custom.list
pihole restartdns

echo "Jellyfin installation complete"