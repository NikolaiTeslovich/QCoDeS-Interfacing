<h1 align="center">
  QCoDeS-Interfacing
</h1>

<p align="center">
  Interfacing various equipment through Ethernet and GPIB with QCoDeS through the development of drivers and accompanying programs in python, initially in jupyter lab.
</p>

To Do:
- [x] Install Ubuntu on lab desktop
- [x] Install *jupyter lab* on Ubuntu
  - [x] Install miniconda
- [x] Install QCoDeS
- [x] Go through the QCoDeS tutorial again
- [ ] Interface with the Yokogawa GS200 over Ethernet

# Progress thus far

## Step 1: Configuring the lab computer

### Ubuntu

The SSD was wiped and the latest version of Ubuntu, 22.04 LTS, was installed on it. I used [balenaEtcher](https://www.balena.io/etcher/) to create the installation media.

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

### QCoDeS & jupyter lab installation

To actually install QCoDeS, first a conda environment was created following this [installation guide](https://qcodes.github.io/Qcodes/start/index.html) using python version 3.9, the latest supported by QCoDeS:
```
conda create -n qcodes python=3.9
```

Then, the environment was activated:
```
conda activate qcodes
```

Next, the latest version of QCoDeS and jupyter lab was installed with pip:
```
pip install qcodes jupyterlab
```

## Step 2: Starting the notebook

### Launching jupyter lab

Making sure that the qcodes is the current conda environment, the jupyter notebooks can be launched with:
```
jupyter lab
```

## Step 3: Insatlling pyvisa:

Pyvisa-py, a python backend for pyvisa was installed with the following command:
```
pip install pyvisa-py==0.5.2
```

Then, pyusb and pyserial were installed so that the library could actually interface with the instruments:
```
pip install pyusb && pip install pyserial
```

To make sure all the necessary packages work, the following command is run to verify:
```
python -m visa info
```

***Important***

```
conda env list
```

```
conda activate qcodes
```

pip install qcodes_contrib_drivers

***Also*** you sometimes do not have permission in Ubuntu to actually add and use the instrument in this case.

https://www.xmodulo.com/change-usb-device-permission-linux.html

***Trying this method instead***:

https://stackoverflow.com/questions/66480203/pyvisa-not-listing-usb-instrument-on-linux

pip install gpib-ctypes
sudo usermod -a -G dialout nikolai

### Step 4: Installing ni-visa drivers
