<h1 align="center">
  GPIB QCoDeS Complete Setup Guide
</h1>

<p align="center">
  Tested on Ubuntu Server 20.04 & 22.04

https://linux-gpib.sourceforge.io/doc_html/supported-hardware.html

## But does it work on Ubuntu Server 22.04? Test that out!
## Does it depend on any of the NI drivers also?

## Ubuntu Install

[Ubuntu 20.04 LTS Server](https://ubuntu.com/download/server#downloads) was installed on an old Desktop that supports PCI. Just use the default installation options and make sure the **Instal OpenSSH server** checkmark is checked. 20.04 was used as it seemed to run rather well. I used [balenaEtcher](https://www.balena.io/etcher/) to create the installation media.

Then, log into the server and check the MAC address:
```
ip addr
```

From this output, we want to take the MAC address of whatever interface we will be connecting to, probably ethernet. The MAC address is in the form `ff:ff:ff:ff:ff:ff`. Then, [register the device through the Cornell Network](https://it.cornell.edu/wifi-wired/register-device-doesnt-have-browser) and restart for the rule to be updated and the network to work:
```
sudo reboot
```

After the computer reboots, log into it. All the packages are updated to their latest versions, ifconfig is installed and the computer is rebooted:
```
sudo apt update && sudo apt dist-upgrade && sudo reboot
```

Logging into the computer again, we run:
```
ip addr
```

From this, we get its ip address followed by inet. We can now disconnect the monitor, keyboard and mouse and use our main computer to remotely connect to this GPIB server. It is connected like this:
```
ssh <user>@<ip addr>
```

Then we install all the latest packages: 
```
sudo apt-get install -y tk-dev build-essential texinfo texi2html libcwidget-dev libncurses5-dev libx11-dev binutils-dev bison flex libusb-1.0-0 libusb-dev libmpfr-dev libexpat1-dev tofrodos subversion autoconf automake libtool python3-dev python3-pip
```

Jupyter Notebook usage: 

On the remote desktop, start up the necessary drivers and programs:
```
sudo modprobe tnt4882 && sudo ldconfig && sudo gpib_config 
```

on the server through ssh:
```
sudo jupyter lab --no-browser --port=8889 --allow-root
```
on your computer or desktop:
```
ssh -N -f -L localhost:8888:localhost:8889 user@128.253.10.249
```

UDEV rules: `KERNEL=="gpib[0-9]*", ACTION=="add", MODE="660", GROUP="username"`


Then, we essentially followed these steps step by step:

follow the chinese guide basically step-by-step:

https://arakiliu.github.io/2020/12/22/raspi-usb-gpib/

