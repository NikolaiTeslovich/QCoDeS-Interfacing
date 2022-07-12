#!/bin/bash

# Installation script for Linux GPIB

sudo apt install -y tk-dev build-essential texinfo texi2html libcwidget-dev libncurses5-dev libx11-dev binutils-dev bison flex libusb-1.0-0 libusb-dev libmpfr-dev libexpat1-dev tofrodos subversion autoconf automake libtool python3-dev python3-pip

cd ~

sudo mkdir linux-gpib 

cd linux-gpib/

sudo svn checkout svn://svn.code.sf.net/p/linux-gpib/code/trunk linux-gpib-code

cd linux-gpib-kernel

sudo make

sudo make install

## check that the directories do indeed work!

cd ~/linux-gpib/linux-gpib-user

sudo ./bootstrap

sudo ./configure

sudo make

sudo make install

sudo find / -name gpib.conf

sudo nano /usr/local/etc/gpib.conf





