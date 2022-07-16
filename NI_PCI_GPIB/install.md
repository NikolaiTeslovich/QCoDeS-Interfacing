<h1 align="center">
  GPIB QCoDeS Complete Setup Guide
</h1>

<p align="center">
  Tested on Ubuntu Server 20.04 & 22.04

https://linux-gpib.sourceforge.io/doc_html/supported-hardware.html

## Ubuntu Install

Install the latest version of [Ubuntu Server](https://ubuntu.com/download/server#downloads) on the target desktop, using the default installation options and making sure that the **Install OpenSSH server** checkmark was checked. The installation media was created with [balenaEtcher](https://www.balena.io/etcher/).

Then, log into the server and check the MAC address with the display still attached:
```
ip addr
```

From this output, we want to take the MAC address of whatever interface we will be connecting to the internet through, likely ethernet. The MAC address is in the form `ff:ff:ff:ff:ff:ff`. Then, [register the device through the Cornell Network](https://it.cornell.edu/wifi-wired/register-device-doesnt-have-browser) and restart for the rule to be updated and the network to work:
```
sudo reboot
```

After the computer reboots, log into it. Update all the packages and reboot once more to reload the kernel:
```
sudo apt update && sudo apt dist-upgrade && sudo reboot
```

To get the IP address of the desktop, login to it once more and run the following command:
```
ip addr
```

From this, we get its ip address followed by inet. We can now disconnect the monitor, keyboard and mouse and use our main computer to remotely connect to this GPIB server. It is connected like this:
```
ssh <username>@<ip addr>
```

Once we are connected, there are two options to go forward with the installation:
- 1. Use an installation script (recommended)
- 2. Manually install 
```

## The installation script approach

First, the repository containing the script is cloned:
```
cd ~ && git clone git@github.coecis.cornell.edu:Fatemi-Lab/QCoDeS-Interfacing.git
```

Then, the script is given the necessary permissions: 
```
chmod +x QCoDeS-Interfacing/NI_PCI_GPIB/install.sh
```

Then it is executed:
```
./QCoDeS-Interfacing/NI_PCI_GPIB/install.sh
```

Once the script has finished, reboot the computer with the following command and idea to have it work correctly and forever. 


sudo apt-get install -y git tk-dev build-essential texinfo texi2html libcwidget-dev libncurses5-dev libx11-dev binutils-dev bison flex libusb-1.0-0 libusb-dev libmpfr-dev libexpat1-dev tofrodos subversion autoconf automake libtool python3-dev python3-pip
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

Next, the gpib.conf file has to be properly configurated

# enter the current gpib configuration file in nano to make the necessarty edits
sudo nano /usr/local/etc/gpib.conf


Then, we essentially followed these steps step by step:

follow the chinese guide basically step-by-step:

https://arakiliu.github.io/2020/12/22/raspi-usb-gpib/

