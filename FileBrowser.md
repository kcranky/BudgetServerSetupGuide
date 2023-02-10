

## 0 Permanently mount the harddrive
This is important!   
Read the guide [here](MountDrive.md).


## 1 Install FileBrowser
`$ curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash`

## 2 Configure
- ` $ sudo mkdir /var/lib/filebrowser`
- ` $ sudo nano /var/lib/filebrowser/.filebrowser.json`
- In the file, place the following contents:
```
{
    "address": "0.0.0.0",
    "port": 8675,
    "root": "/media/pidrive",
    "database": "/var/lib/filebrowser/filebrowser.db"
}
```
- Test out the filebrowser config by running   
`$ sudo /usr/bin/filebrowser -c /var/lib/filebrowser/.filebrowser.json`   
You should be able to log in using admin and admin as your username and password.   
Be sure to change it!

## 3 Create Service
- Create `filebrowser.service` in `/etc/systemd/system`:  
`$ sudo nano /etc/systemd/system/filebrowser.service`
- Insert the following contents:
```
[Unit]
Description=File Browser
After=network.target

[Service]
Type=simple
ExecStart=filebrowser -c /var/lib/filebrowser/.filebrowser.json --disable-preview-resize --disable-type-detection-by-header --cache-dir /var/lib/filebrowser/cache

[Install]
WantedBy=multi-user.target
```
- Save and close the file
- Start the service:   
`$ sudo systemctl start filebrowser.service`
- Set the service to start on startup:  
`$ sudo systemctl enable filebrowser.service` 

## 4  Set up apache site
- Run `$ sudo a2enmod proxy_http rewrite`
- Run `$ sudo wget wget https://raw.githubusercontent.com/kcranky/BudgetServerSetupGuide/main/apache2-sites-available/filebrowser.conf -P /etc/apache2/sites-available`
- Run `$ sudo a2ensite filebrowser`

## 5 Finalise PiHole
Add an entry to the custom DNS records on PiHole to point "files.raspberrypi" to the IP of your Pi.

