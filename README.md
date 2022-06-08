<h1 align="center">
  QCoDeS-Interfacing
</h1>

<p align="center">
  Interfacing various equipment through Ethernet and GPIB with QCoDeS through the development of drivers and accompanying programs in python, initially in jupyter lab.
</p>

# QCoDeS Interfacing

To Do:
- [x] Install Ubuntu on lab desktop
- [x] Install *jupyter lab* on Ubuntu
  - [x] Install miniconda
- [ ] Install QCoDeS
- [ ] Go through the QCoDeS tutorial again
- [ ] Interface with the Yokogawa GS200 over Ethernet

# Detailed log of progress

## Step 1: Configuring the lab computer

### Ubuntu

The SSD was wiped and the latest version of Ubuntu, 22.04 LTS, was installed on it. I used [balenaEtcher](https://www.balena.io/etcher/) to create the installation media.

### Miniconda & jupyter lab

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

After the installation has finished, releaunch the terminal and install jupyter lab:
```
conda install -c conda-forge jupyterlab
```

Test that it works by launching it:
```
jupyter lab
```
Running that command should have launched a window in your browser.
