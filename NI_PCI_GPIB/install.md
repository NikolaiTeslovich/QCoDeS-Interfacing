<h1 align="center">
  GPIB QCoDeS Complete Setup Guide
</h1>

<p align="center">
  Tested on Ubuntu Server 20.04 with qcodes version 0.33.0
</p>

## But does it work on Ubuntu Server 22.04? Test that out!
## Does it depend on any of the NI drivers also?

## Ubuntu Install

[Ubuntu 20.04 LTS Server](https://ubuntu.com/download/server#downloads) was installed on an old Desktop that supports PCI. Just use the default installation options and make sure the **Instal OpenSSH server** checkmark is checked. 20.04 was used as it seemed to run rather well. I used [balenaEtcher](https://www.balena.io/etcher/) to create the installation media.

Then, log into the server and check the MAC address:
```
ip -o link | awk '$2 != "lo:" {print $2, $(NF-2)}'
```

You should get an output like this, and we want to take the eth0 ip address:

Then, [register the device through the Cornell Network](https://it.cornell.edu/wifi-wired/register-device-doesnt-have-browser) and restart for the rule to be updated and the network to work:

```
sudo reboot
```

as soon as the computer is logged into, all the packages are updated to their latest versions, ifconfig is installed and the computer is rebooted:
```
sudo apt update && sudo apt dist-upgrade sudo apt install ifconfig && sudo reboot
```

Logging into the computer again, we run:

```
ifconfig
```

```
ssh ip@
```

follow the chinese guide basically step-by-step:

https://arakiliu.github.io/2020/12/22/raspi-usb-gpib/

### Add your computer to the Cornell Network 
### Check the MAC address and then the IP using ifconfig


