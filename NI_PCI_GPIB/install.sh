#!/bin/bash
# installation script for Linux GPIB
# created by nan34 with inspiration from https://arakiliu.github.io/2020/12/22/raspi-usb-gpib/

# install the necessary packages
sudo apt install -y tk-dev build-essential texinfo texi2html libcwidget-dev libncurses5-dev libx11-dev binutils-dev bison flex libusb-1.0-0 libusb-dev libmpfr-dev libexpat1-dev tofrodos subversion autoconf automake libtool python3-dev python3-pip

# make a directory for the drivers 
sudo mkdir ~/linux-gpib 
cd ~/linux-gpib

# download the linux-gpib drivers to the `linux-gpib-code` directory
sudo svn checkout svn://svn.code.sf.net/p/linux-gpib/code/trunk linux-gpib-code

# install the packages at the kernel level
cd ~/linux-gpib/linux-gpib-code/linux-gpib-kernel
sudo make && sudo make install

# install the packages at the user level
cd ~/linux-gpib/linux-gpib-code/linux-gpib-user
sudo ./bootstrap && sudo ./configure && sudo make && sudo make install

# enter the current gpib configuration file in nano to make the necessarty edits
sudo nano /usr/local/etc/gpib.conf





