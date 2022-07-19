<h1 align="center">
  GPIB QCoDeS Complete Setup Guide
</h1>

<p align="center">
  Tested on Ubuntu Server 20.04 & 22.04

https://linux-gpib.sourceforge.io/doc_html/supported-hardware.html

## Ubuntu Install & Network Config

Install the latest version of [Ubuntu Server](https://ubuntu.com/download/server#downloads) on the target desktop, using the default installation options and making sure that the **Install OpenSSH server** checkmark was checked. The installation media was created with [balenaEtcher](https://www.balena.io/etcher/).

Then, log into the server and check the MAC address with the display still attached:
```
ip addr
```

From this output, we want to take the MAC address of whatever interface we will be connecting to the internet through, likely ethernet. The MAC address is in the form `ff:ff:ff:ff:ff:ff`. Then, [register the device through the Cornell Network](https://it.cornell.edu/wifi-wired/register-device-doesnt-have-browser) and restart for the rule to be updated and the network to work:
```
sudo reboot
```

After the computer reboots, login to it once more and run the following command to get its ip address:
```
ip addr
```

From this, we get its ip address followed by inet. We can now disconnect the monitor, keyboard and mouse and use our main computer to remotely connect to this GPIB server. It is connected like this:
```
ssh <username>@<ip addr>
```

After logging into it over ssh, update all the packages and reboot once more to reload the kernel:
```
sudo apt update && sudo apt dist-upgrade && sudo reboot
```

Then, connect to it once more with the same command as in the previous step: 
```
ssh <username>@<ip addr>
```

> This command should be used for all subsequent connection attempts

## Linux-GPIB Script Install

This is all done logged into the remote desktop obviously.

First, the repository containing the script is cloned:
```
cd ~ && git clone git@github.coecis.cornell.edu:Fatemi-Lab/QCoDeS-Interfacing.git
```

> Note that because this is enterprise GitHub, you have to [create and add a SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

Then, the script is given the necessary permissions: 
```
chmod +x QCoDeS-Interfacing/NI_PCI_GPIB/install.sh
```

Then it is executed:
```
./QCoDeS-Interfacing/NI_PCI_GPIB/install.sh
```

Once the script has finished, the `GPIB.conf` will need to be modified. I prefer to use nano, but vim can also be used:
```
sudo nano /usr/local/etc/gpib.conf
```

> replace what is after `board_type = ` with `"tnt4882"`

## Day-to-day Usage

Jupyter Notebook usage: 

On the remote desktop, start up the necessary drivers and programs:
```
sudo modprobe tnt4882 && sudo ldconfig && sudo gpib_config 
```

To test that the connections are working, run the following command:

```
sudo ibtest
```

Then, run the following command to forward the port on the local network
```
sudo jupyter lab --no-browser --port=8889 --allow-root
```

> the notebook is run under root as this is the only approach I found to work 

On your computer or desktop:
```
ssh -N -f -L localhost:8888:localhost:8889 <username>@<ip addr>
```

Then, open a browser and go to [localhost:8888](localhost:8888), the key is what is at the end of the url of the command-line-output of the server.

## Sources:

- https://arakiliu.github.io/2020/12/22/raspi-usb-gpib/

