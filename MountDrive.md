# Permanently Mounting an External Harddrive/USB

The following steps will help you to permanently mount a drive to the Pi (so you don't have to mount it every time it reboots).

1. Plug in your harddrive
2. Run `$ lsusb` to ensure it's been detected by the system
3. Run `$ sudo fdisk -l` and make note of the location of your drive, usually something like `/dev/sda1`
4. Create a mount point:  
`$ sudo mkdir /media/pidrive`
5. Change permissions of the mount point:  
`$ sudo chown pi:pi /media/pidrive`
6. Get the additional of the drive by running `$ sudo blkid`. Look for the location found earlier (e.g. `/dev/sda1`). Make note of the UUID and type.
7. Run `$ sudo nano /etc/fstab` and add the following line to the bottom of the file (your \<UUID\> and \<type\> are the ones found in step 7.)
```
UUID=<your UUID> /media/pidrive <type> defaults,auto,users,rw,nofail,umask=000,x-systemd.device-timeout=30,exec 0 0
```
8. Reboot the Pi (`$ sudo reboot`), SSH back in and run `$ cat /proc/mounts`. If everything went according to plan, you should see a line like the following:
```
/dev/sda1 /media/pidrive fuseblk rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other,blksize=4096 0 0
```
