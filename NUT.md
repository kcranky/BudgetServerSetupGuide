# NUT
Network UPS Tools allows monitoring and control of a UPS over a network.

## 0. Notes
This setup works for me, and it will vary based on the UPS you're using. 
I am using an RCT 2000VA UPS, so if that's what you're using, congrats! This'll work for you too.
If you're using a different UPS, you will need to look up what your configuration is.
This guide borrows heavily from the write up [here](https://www.reddit.com/r/homelab/comments/5ssb5h/ups_server_on_raspberry_pi/), so, be sure to check it out.

## 1. Install
`$ sudo apt install nut`

## 2. Set up
The following files need to be in the `/etc/nut/` directory, and will require sudo access to write.

### nut.conf
 
```
MODE=netserver
```

### ups.conf
- The name of the ups in brackets will be used in `upsmon.conf`
- This file will need to change depending on which UPS you have.
- See [here](https://networkupstools.org/stable-hcl.html) for a list of supported devices - though there may be more supported devices, or a generic brand that is unlisted. Google is your friend.
```
[ups]
  driver=nutdrv_qx
  port=auto
  desc="RCT 2000VA"
  vendorid=0665
  productid=5161
```

### upsd.conf
```
LISTEN 127.0.0.1 3493
LISTEN 192.168.1.2 3493
```

### upsd.users
- The username and password set here will be used in `upsmon.conf`
```
[admin]
        password = upstest
        actions = SET
        instcmds = ALL
[upsmon_local]
        password  = upstest
        upsmon master
[upsmon_remote]
        password  = upstest
        upsmon slave
```

### upsmon.conf
```
MONITOR ups@localhost 1 upsmon_local upstest master
```