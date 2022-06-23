#!/bin/sh

# written by Todd Micallef
# adapted from https://raw.githubusercontent.com/PlesaEEVBlog/RPi_LogNut/master/Install_GPIB_Support.sh
# modified for the newer version of linux-gpib. The new version compiles differently and the commands were changed to reflect it
# samba is optional and installed if needed
# file "thermo_installer.run" is needed for the BME280 support. It should be placed in the boot dir with this file prior to booting the RPI
# Rev 1.0 initial release
# Rev 1.1 moved all tasks into functions so that individual sw packages can be reinstalled
#         added hotplug and gpib_config call on boot
#         added teckit and calkit install options
#         added BME280 support with Fluke 1620 emulation on telnet port 10001
#         additional file is needed for BME280 called thermo_installer.run
# Rev 1.2 added make clean to linux-gpib installer
#         added several packages back that were accidentally removed
# Rev 1.3 added check to make sure gpib_config command is only added once to /etc/rc.local
#         changed $HOME_DIR to reflect the directory where this script is called. It is not tied to /home/pi
#         changed initial check for gpib.conf from /etc to /usr/local/etc in case of upgrading from old version of linux-gpib
#         future change will go to both locations and delete gpib.conf before make is called
#         echo has been added for depmod, ldconfig, and gpib_config calls at the end of the install
# Rev 1.4 added option to do an uninstall. doing a make install twice, even after a make uninstall and make clean, breaks the install
#         fixed issue with adding gpib_config to rc.local file
#         removed some test code
# Rev 1.5 added cd.. to uninstall to bring the cursor out of the linux-gpib dir. If not, there will be a nested dir
#         forgot code to actually check if linux-gpib was previously installed.... it was left out for testing but never added afterward
# Rev 1.6 added ftp, git, mc, and screen to package install.
#         added reboot request after update_system. the kernel may have been updated and a reboot will be needed so linux-gpib can compile without errors
#         added function for UCTRONICS lcd display. basic testing is being performed. It may be removed if it is interfering with installation or function of linux-gpib
# Rev 1.7 added x11vnc package for a remote display
# Rev 1.8 changed LINUX_GPIB_VER from 4.3.3 to 4.3.4
#         changed the Adafruit pitft hat wget link to point to new location on GitHub
#         The HOTPLUG_RULES_FILE could not be created due to a permission error. The "| sudo tee" and "| sudo tee -a" commands were added to allow the creation of the file
#         purge files that check for ssh default password so the popup window on boot no longer appears "libpam-chksshpwd"
#         added option to enable the desktop on the pitft if it is enabled. The user will still have to go into raspi-config and change the default boot mode
#         removed calkit install option.


# make sure paths end with a /
#HOME_DIR="/home/pi/"
HOME_DIR=${PWD}
LINUX_GPIB_VER="4.3.4"
# GPIB_FILE="gpib0"
# GPIB_FILE_PATH="/dev/"
GPIB_FILE="gpib.conf"
GPIB_FILE_PATH="/usr/local/etc/"
#GPIB_FILE_PATH="/etc/"
RC_LOCAL_PATH="/etc/"
HOTPLUG_RULES_FILE="99-linux_gpib_ni_usb.rules"
HOTPLUG_RULES_DIR="/etc/udev/rules.d/"

enable_root()
{
    sudo passwd root
    #sudo nano /etc/ssh/sshd_config
}

reboot_request()
{
    while true; do
        read -p "Do you want to reboot? " yn
        case $yn in
            [Yy]* ) sudo reboot now; break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

uninstall_linux_gpib()
{
    cd linux-gpib-${LINUX_GPIB_VER}
    #cd linux-gpib-kernel-${LINUX_GPIB_VER}
    sudo rm -rf linux-gpib-kernel-${LINUX_GPIB_VER}
    #cd ..
    cd linux-gpib-user-${LINUX_GPIB_VER}
    sudo make_uninstall
    sudo make clean
    cd ..
    sudo rm -rf linux-gpib-user-${LINUX_GPIB_VER}
    sudo rm -f linux-gpib-kernel-${LINUX_GPIB_VER}.tar.gz
    sudo rm -f linux-gpib-user-${LINUX_GPIB_VER}.tar.gz
    cd ..
}

install_linux_gpib()
{
    cd /opt
    # test for directory where linux-gpib will be installed
    if [ -d "linux-gpib-${LINUX_GPIB_VER}" ];head -n1 /etc/rc.local

    then
        while true; do
            read -p "Install directory for linux-gpib-${LINUX_GPIB_VER} already exists. Do you wish to uninstall it first? " yn
            case $yn in
                [Yy]* ) uninstall_linux_gpib; break;;
                [Nn]* ) break;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    fi

    sudo wget https://sourceforge.net/projects/linux-gpib/files/linux-gpib%20for%203.x.x%20and%202.6.x%20kernels/${LINUX_GPIB_VER}/linux-gpib-${LINUX_GPIB_VER}.tar.gz
    sudo tar xvzf linux-gpib-${LINUX_GPIB_VER}.tar.gz

    cd linux-gpib-${LINUX_GPIB_VER}

    sudo tar xvzf linux-gpib-kernel-${LINUX_GPIB_VER}.tar.gz

    sudo tar xvzf linux-gpib-user-${LINUX_GPIB_VER}.tar.gz

    cd linux-gpib-kernel-${LINUX_GPIB_VER}
    sudo make
    sudo make install

    cd ..
    # install python dev for the command to be used
    sudo apt install python-dev
    cd linux-gpib-user-${LINUX_GPIB_VER}
    # compile linux-gpib python bindings
    cd language/python
    sudo python setup.py install
    cd ../..

    sudo ./bootstrap
    sudo ./configure
    sudo make clean
    sudo make
    sudo make install

    # test for location of gpib.conf file. It is either in /etc or /usr/local/etc
    if [ -f "${GPIB_FILE_PATH}${GPIB_FILE}" ]; then
        echo "${GPIB_FILE_PATH}${GPIB_FILE} exist"
    elif [ -f "/etc/${GPIB_FILE}" ]; then
        echo "/etc/${GPIB_FILE} exist"
        GPIB_FILE_PATH="/etc/"
    else
        echo "${GPIB_FILE} does not exist. Copying from template dir to /usr/local/etc/"
        sudo cp /opt/linux-gpib-${LINUX_GPIB_VER}/linux-gpib-user-${LINUX_GPIB_VER}/util/templates/gpib.conf ${GPIB_FILE_PATH}
    fi

    cd ../..

    # Install FxLoad
    sudo mkdir /usr/share/usb
    sudo mkdir /usr/share/usb/agilent_82357a
    sudo mkdir /usr/share/usb/ni_usb_gpib
    sudo mkdir gpib_firmware
    cd gpib_firmware

    sudo wget http://linux-gpib.sourceforge.net/firmware/gpib_firmware-2008-08-10.tar.gz
    sudo tar xvzf gpib_firmware-2008-08-10.tar.gz

    #sudo cp -r gpib_firmware-2008-08-10 /usr/share/usb
    sudo cp gpib_firmware-2008-08-10/agilent_82357a/82357a_fw.hex /usr/share/usb/agilent_82357a/
    sudo cp gpib_firmware-2008-08-10/agilent_82357a/measat_releaseX1.8.hex /usr/share/usb/agilent_82357a/
    sudo cp gpib_firmware-2008-08-10/ni_gpib_usb_b/niusbb_loader.hex /usr/share/usb/ni_usb_gpib/
    sudo cp gpib_firmware-2008-08-10/ni_gpib_usb_b/niusbb_firmware.hex /usr/share/usb/ni_usb_gpib/
    sudo apt -y install fxload

    if lsusb | grep -q '3923:709b'; then
        sudo sed -i 's/ni_pci/ni_usb_b/g' ${GPIB_FILE_PATH}${GPIB_FILE}
        echo "National Instruments NI GPIB-USB-HS found"
        sudo modprobe ni_usb_gpib

        # the following code creates a rules file for hotplugging the NI GPIB_USB_HS adapter
        cd "$HOME_DIR"
        echo 'SUBSYSTEM=="usb", ACTION=="add", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="3923", ATTR{idProduct}=="709b", MODE="660", GROUP="username", SYMLINK+="usb_gpib"' | sudo tee ${HOTPLUG_RULES_FILE}
        echo 'SUBSYSTEM=="usb", ACTION=="add", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="3923", ATTR{idProduct}=="709b", RUN+="/usr/local/sbin/gpib_config"' | sudo tee -a ${HOTPLUG_RULES_FILE}
        echo 'KERNEL=="gpib[0-9]*", ACTION=="add", MODE="660", GROUP="username"' | sudo tee -a ${HOTPLUG_RULES_FILE}
        sudo cp ${HOTPLUG_RULES_FILE} ${HOTPLUG_RULES_DIR}
        sudo rm ${HOTPLUG_RULES_FILE}
    fi

    echo "running ldconfig"
    sudo ldconfig
    echo "running depmod -a"
    sudo depmod -a
    echo "running gpib_config"
    sudo gpib_config

    # the following lines runs gpib_config on boot. gpib_config command added before the "exit 0" at the end of the file
    # first test if it already exists. if true, skip adding line
    # exit 0 may occur more than once in the file (as part of instructions) so only care about last entry

    # create the rc.local file itself
    sudo touch ${RC_LOCAL_PATH}rc.local

    if grep -Fxq '/usr/local/sbin/gpib_config' ${RC_LOCAL_PATH}rc.local
    then
        echo "rc.local file already modified"
    else
        echo "rc.local modified for gpib_config command"
        sudo sed -i 's/^exit 0$/\/usr\/local\/sbin\/gpib_config\nexit 0/' ${RC_LOCAL_PATH}rc.local
    fi
}

echo "current dir is ${HOME_DIR}"
# ---------------------------------------------------------------------
# add support for linux-gpib
while true; do
    read -p "Do you wish to install linux-gpib? " yn
    case $yn in
        [Yy]* ) install_linux_gpib; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# ---------------------------------------------------------------------
# reboot system
echo "Finished installing options"
reboot_request
