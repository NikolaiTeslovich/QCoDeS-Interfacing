<h1 align="center">
  QCoDeS-Interfacing
</h1>

<p align="center">
  Interfacing with various equipment over the VISA protocol through USB and GPIB with QCoDeS
</p>

## To-Do!
- [ ] find directory where the experiments are

## Purpose
Picture this, you have recently acquired a lab space with a lot of old equipment, some of which hasn't been used for literal decades. It's a safe to say that practically all of it uses the GPIB interface, and if not, likely USB. Why buy new expensive equipment when the old equipment is still exteremely good? 

What if you also stumbled upon a desktop that is older than some of the undergrads working at your lab and uses a NI-PCI GPIB Adapter from 1998? I'm sure Linux will run fine on it.
> As they say, Linux runs on everything, even on a [potato](http://www.bbspot.com/News/2008/12/linux-on-a-potato.html?from=rss)

After a simple installation of Linux and some drivers and packages as detailed in the documentation below, all of this equipment can now be programatically interfaced through Python with the VISA protocol through QCoDeS.

## Theoretically Supported Hardware
***Disclaimer:*** note all of these were tested, though these are what should theoretically work
- [QCoDeS Community Drivers Supported Hardware](https://qcodes.github.io/Qcodes/api/generated/qcodes.instrument_drivers.html)
- [Linux GPIB](https://linux-gpib.sourceforge.io/doc_html/supported-hardware.html)
- VISA over USB

## Linux GPIB
Written for and tested on **NI-PCI GPIB Adapter** `tnt4882` with **Yokogawa GS210** & **Keithley 2400** on **Ubuntu Server 20.04 LTS** & **Ubuntu Server 22.04 LTS**
- [Installation Guide](/NI_PCI_GPIB/install.md)
- [Initialization Notebook](/NI_PCI_GPIB/Initialization_GPIB.ipynb)
- [QCoDeS R/G LED Sweep Notebook](/NI_PCI_GPIB/leds_sweep_+200mA.ipynb)

## VISA over USB
Written for and tested on **Yokogawa GS210** with **Ubuntu 20.04 LTS** non-server
- [Installation Guide](/GS210_USB/install.md)
- [Initialization Notebook](/GS210_USB/Initialization_Guide.ipynb)
- [QCoDeS Sweep Notebook](/GS210_USB/QCoDeS-GS210.ipynb)
- [Jupyter Widgets V/I Toggle Notebook](/GS210_USB/GS210_VI_Selector.ipynb)

## Supplemental Resources
- [GPIB Knowledge Glossary](https://www.contec.com/support/basic-knowledge/daq-control/gpib-communication/)
- [15 Minutes to QCoDeS](https://qcodes.github.io/Qcodes/examples/15_minutes_to_QCoDeS.html)
- [QCoDeS Docs](https://qcodes.github.io/Qcodes/)
- [QCoDeS Github](https://github.com/QCoDeS)
- [PyVisa Docs](https://pyvisa.readthedocs.io/en/latest/)

## Non-Interfacing Experiment
Written for and tested on **Yokogawa GS210** & **Keithley 2400**
- [Resistor Experiment](/resources/Resistor_Circuit.md)

## Future Prospects
- [ ] Integrate with a Raspberry Pi to further lower the cost and not buy propreitary equipment from greedy vendors like National Instruments

## Cool Results
Here are some interesting results that I got from sweeping the current while measuring the voltage on a green and red LED after I configured everything with the documentation above: 

<p align="center">
  <img src="/resources/GreenvsRed.jpg" width="600">
</p>

Check out the [notebook itself](/NI_PCI_GPIB/leds_sweep_+200mA.ipynb)