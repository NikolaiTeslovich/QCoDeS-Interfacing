<h1 align="center">
  QCoDeS-Interfacing
</h1>

<h3 align="center">
  <a href="/Install.md">Installation & Configuration Guide</a>
</h3>

<h3 align="center">
  <a href="/Resistor_Circuit.md">Sample Experiment</a>
</h3>

---

<p align="center">
  Interfacing various equipment over the VISA protocol through USB and eventually GPIB with QCoDeS through the development of drivers in jupyter lab.
</p>

Jupyter lab can be launched with the following command that activates the qcodes conda environment and goes into the user's home directory:
```
conda activate qcodes && cd ~ && jupyter lab
```

## GPIB Useful Links:

https://gist.github.com/ochococo/8362414fff28fa593bc8f368ba94d46a
https://ubuntuforums.org/showthread.php?t=2270802
https://rfpoweramp.com/2014/07/26/setting-up-ni-gpib-usb-hs-under-linux/
https://github.com/fmhess/hsplus_load
https://xdevs.com/guide/ni_gpib_rpi/
https://sourceforge.net/p/linux-gpib/support-requests/29/

```
sudo apt install ni-488.2 ni-488.2-documentation libni4882-devel ni-488.2-errors ni-488.2-iotrace-support ni-488.2-gpibenumsvc ni-488.2-runtime ni-488.2-gpibexplorer ni-488.2-utils ni-488.2-gpibintctrl libni4882 ni-488.2-gpibtroubleshooting ni-488.2-config ni-488.2-sysapi-support ni-488.2-dkms
```

https://tomverbeure.github.io/2020/06/27/Tektronix-TDS420A-Remote-Control-over-GPIB.html
https://arakiliu.github.io/2020/12/22/raspi-usb-gpib/