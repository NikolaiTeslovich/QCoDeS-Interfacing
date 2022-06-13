conda<h1 align="center">
  QCoDeS-Interfacing
</h1>

<p align="center">
  Interfacing various equipment through Ethernet and GPIB with QCoDeS through the development of drivers and accompanying programs in python, initially in jupyter lab.
</p>

## To Do:
- [x] Prepare the desktop
  - [x] Install Ubuntu on lab desktop
  - [x] Install jupyter lab
  - [x] Install miniconda
  - [x] Install QCoDeS
- [x] Go through the QCoDeS tutorial again
- [x] Interface with the Yokogawa GS200 over USB
- [x] Find a safer way to interact with the instrument apart from enabling USB sudo access
- [ ] Connect some other instruments and come up with an interesting experiment

## Step 1: Configuring the lab computer

### Ubuntu

The SSD was wiped and the latest version of Ubuntu, 20.04 LTS, was installed on it. 20.04 was used as that is the latest version supported by the national instrument drivers. I used [balenaEtcher](https://www.balena.io/etcher/) to create the installation media.

### Miniconda

First, miniconda was installed by downloading the latest release:
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

The file has a *.sh* ending meaning that it is a shell script. So to install it, navigate to the directory of the file in the terminal and then make the script executable:
```
chmod +x Miniconda3-latest-Linux-x86_64.sh
```

Then, execute it:
```
./Miniconda3-latest-Linux-x86_64.sh
```

### QCoDeS & driver installation

To actually install QCoDeS, first a conda environment was created following this [installation guide](https://qcodes.github.io/Qcodes/start/index.html) using python version 3.9, the latest supported by QCoDeS:
```
conda create -n qcodes python=3.9
```

Then, the environment is activated:
```
conda activate qcodes
```

Next, the latest version of QCoDeS, jupyter lab and other useful packages were installed with pip, pyvisa-py version 0.5.2 is the latest version that works with the version of pyvisa that qcodes uses:
```
pip install qcodes qcodes_contrib_drivers jupyterlab pyvisa-py==0.5.2 pyusb pyserial gpib-ctypes
```

First, the [NI drivers](https://www.ni.com/en-us/support/downloads/drivers/download.ni-visa.html#442675) were installed following [the installation guide on NI website](https://www.ni.com/en-us/support/documentation/supplemental/18/downloading-and-installing-ni-driver-software-on-linux-desktop.html). You will have to make an account, but the download is free.

Then, the NI visa backend was installed:

```
sudo apt install ni-visa
```

For the device to properly work over USB, the [following guide on stackoverflow](https://askubuntu.com/a/1073159) was essential in enabling root permissions for the instrument.

Then, the system is rebooted with:

```
sudo reboot
```

To make sure all the necessary packages work, the following command is run to verify:
```
conda activate qcodes && pyvisa -info
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

## Step 2: Starting the notebook

### Launching jupyter lab

Making sure that the qcodes is the current conda environment and that this is being run from the home directory, then jupyter lab can be launched with:

```
conda activate qcodes && cd ~ && jupyter lab
```
