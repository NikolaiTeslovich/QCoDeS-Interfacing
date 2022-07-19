<h1 align="center">
  USB GS210 QCoDeS Installation Guide
</h1>

<p align="center">
  Tested on Ubuntu 20.04 LTS
</p>

## UEFI Secure Boot

***Important:*** UEFI secure boot must be disabled in BIOS so that the VISA devices can interface with the computer properly.

## Ubuntu Install

[Ubuntu 20.04 LTS](https://releases.ubuntu.com/20.04/) was installed on the lab desktop. 20.04 was used as it is the latest version supported by the National Instrument drivers. I used [balenaEtcher](https://www.balena.io/etcher/) to create the installation media.

Then, as soon as the computer is logged into, all the packages are updated to their latest versions and the computer is rebooted:
```
sudo apt update && sudo apt dist-upgrade && sudo reboot
```

## Miniconda Install

First, miniconda was installed by downloading the latest release with `wget`:
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

The file has a `.sh` ending meaning that it is a shell script. So to install it, navigate to the directory of the file in the terminal and then make the script executable:
```
chmod +x Miniconda3-latest-Linux-x86_64.sh
```

Then, execute it:
```
./Miniconda3-latest-Linux-x86_64.sh
```

## QCoDeS & Python Backend Install

To install QCoDeS, first a conda environment was created using python version 3.9, the latest supported by QCoDeS:
```
conda create -n qcodes python=3.9
```

Then, the environment is activated:
```
conda activate qcodes
```

Next, the latest version of QCoDeS, jupyter lab and other useful packages were installed with pip. pyvisa-py version 0.5.2 is the latest version that works with the version of pyvisa that qcodes uses:
```
pip install qcodes qcodes_contrib_drivers jupyterlab pyvisa-py==0.5.2 pyusb pyserial gpib-ctypes
```

## National Instruments Drivers Install

First, the latest [NI Linux Device Driver](https://www.ni.com/en-us/support/downloads/drivers/download.ni-linux-device-drivers.html#451206) version is downloaded (2022 Q2 at the time of writing). You will have to make an account, but the download is free. The NI drivers will probably end up in the downloads folder of your computer, so enter that directory:
```
cd ~/Downloads
```

Then, the file is unzipped with the following command, the asterisk means that what is after the NILinux and before .zip doesn't matter in locating the file:
```
unzip NILinux*.zip
```

Next, the [National Instrument driver installation guide](https://www.ni.com/en-us/support/documentation/supplemental/18/downloading-and-installing-ni-driver-software-on-linux-desktop.html) is followed for Ubuntu. The first step is to apply the latest system updates and reboot the system:
```
sudo apt update && sudo apt dist-upgrade && sudo reboot
```

The kernel version is checked:
```
uname -r
```

Only run the following command if the kernel version is >= 5.13 to fix a bug that occurs during install:
```
sudo touch /usr/src/linux-headers-$(uname -r)/include/config/modversions.h
```

The driver directory in Downloads is entered into, replacing the directory with the one you have (Tab can be used as auto-complete):
```
cd ~/Downloads/NILinux2022Q2DeviceDrivers
```

Then, the `stream` or latest version latest of the drivers for `ubuntu2004` are installed:
```
sudo apt install ./ni-ubuntu2004firstlook-drivers-stream.deb
```

The package list is refreshed so that other NI components can also be installed:
```
sudo apt update
```

Then, the NI visa backend is installed from a [list of other available packages](https://www.ni.com/pdf/manuals/378353g.html):
```
sudo apt install ni-visa
```

The NI kernel drivers are built, and the system is rebooted:
```
sudo dkms autoinstall && sudo reboot
```

## USB udev Rules Configuration

For the device to properly work over USB, the udev rules have to be updated. First run the usb device listing command to see what devices are connected to the computer:
```
lsusb
```

It should return an output that looks like this:
```
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 004: ID 413c:2010 Dell Computer Corp. Keyboard
Bus 001 Device 003: ID 413c:1003 Dell Computer Corp. Keyboard Hub
Bus 001 Device 002: ID 046d:c016 Logitech, Inc. Optical Wheel Mouse
Bus 001 Device 005: ID 0b21:0039 Yokogawa Electric Corp. GS200
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

From this, we can see that `Bus 001 Device 005: ID 0b21:0039 Yokogawa Electric Corp. GS200` is the instrument that we are interested in. The `0b21:0039` represents the vendor id and the product id separated by a colon, `vendor id:product id`.

The udev permission is then updated with the following command, creating the file `visa.rules` with the new rule:

```
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="vendor id", ATTRS{idProduct}=="product id", MODE="0666"'
| sudo tee --append /etc/udev/rules.d/visa.rules
```
> Note that this command to update the udev rules can be run many times, adding all the necessary USB instruments

Then, the system is rebooted with:
```
sudo reboot
```

## Diagnosing The Packages

To make sure all the necessary packages work, the following command is run to verify:
```
conda activate qcodes && pyvisa-info
```

The output should look something like this:
```
Machine Details:
   Platform ID:    Linux-5.13.0-48-generic-x86_64-with-glibc2.31
   Processor:      x86_64

Python:
   Implementation: CPython
   Executable:     /home/nikolai/miniconda3/envs/qcodes/bin/python
   Version:        3.9.12
   Compiler:       GCC 7.5.0
   Bits:           64bit
   Build:          Jun  1 2022 11:38:51 (#main)
   Unicode:        UCS4

PyVISA Version: 1.12.0

Backends:
   ivi:
      Version: 1.12.0 (bundled with PyVISA)
      #1: /usr/lib/x86_64-linux-gnu/libvisa.so.21.5.0:
         found by: auto
         bitness: 64
         Vendor: National Instruments
         Impl. Version: 22021376
         Spec. Version: 5244928
   py:
      Version: 0.5.2
      ASRL INSTR: Available via PySerial (3.5)
      USB INSTR: Available via PyUSB (1.2.1). Backend: libusb1
      USB RAW: Available via PyUSB (1.2.1). Backend: libusb1
      TCPIP INSTR: Available
      TCPIP SOCKET: Available
```

## Diagnosing Connected Instruments
The [initialization notebook](/GS210/Initialization_Guide.ipynb) serves as a template from which a connection can be established over VISA. Plugin at least one instrument over USB, and check that it's being detected by the National Instruments backend by cloning this repository and going through the diagnostic notebook with filename `Initialization_Guide.ipynb`:
```
git clone git@github.coecis.cornell.edu:Fatemi-Lab/QCoDeS-Interfacing && cd QCoDeS-Interfacing && jupyter lab
```

> Note that because this is enterprise GitHub, you have to [create and add a SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

## Sources Used:

- [QCoDeS installation](https://qcodes.github.io/Qcodes/start/index.html)
- [National Instruments driver installation](https://www.ni.com/en-us/support/documentation/supplemental/18/downloading-and-installing-ni-driver-software-on-linux-desktop.html)
- [udev permissions](https://askubuntu.com/a/1073159)
