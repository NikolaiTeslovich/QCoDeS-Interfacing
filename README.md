<h1 align="center">
  QCoDeS-Interfacing
</h1>

<p align="center">
  <img src="/resources/QCoDeS-Interfacing.png" width="200" height="200">
</p>


Picture this, you have recently acquired a lab space with a lot of old equipment, some of which hasn't been used for literal decades. It's a safe to say that practically all of it uses the GPIB interface, and if not, likely USB. Why buy new expensive equipment when the old equipment is still good? 

Instead of using ugly, proprietary software from some company, why not do everything in python, specifically in QCoDeS?

What if you also stumbled upon a desktop that is older than some of the undergrads working at your lab and uses a NI-PCI GPIB Adapter from 1998? Linux will defintely run fine on it.
> As they say, Linux runs on everything, even on a [potato](http://www.bbspot.com/News/2008/12/linux-on-a-potato.html?from=rss)

After a simple installation of Linux and some drivers and packages as detailed in the documentation below, all of this equipment can now be programatically interfaced through Python and QCoDeS.

## To-Do!
- [ ] find directory where the experiments are
- [ ] write up experimental setup for the R/G LED experiment
- [ ] write up a step-by-step notebook or experimental guide for the LED experiment

## Theoretically Supported Hardware
***Disclaimer:*** not all of these were tested, though these are what should theoretically work
- [QCoDeS Community Drivers Supported Hardware](https://qcodes.github.io/Qcodes/api/generated/qcodes.instrument_drivers.html)
- [Linux GPIB](https://linux-gpib.sourceforge.io/doc_html/supported-hardware.html)
- VISA over USB

## GPIB Instrument(s)
Written for and tested on a `NI-PCI GPIB Adapter` with a `Yokogawa GS210` & `Keithley 2400` on `Ubuntu Server 20.04 LTS` & `Ubuntu Server 22.04 LTS`
- [Installation Guide](/GPIB/install.md)
- [Initialization Notebook](/GPIB/initialization_GPIB.ipynb)
- [QCoDeS R/G LED Sweep Notebook](/GPIB/leds_sweep.ipynb)

## USB Instrument(s)
Written for and tested on a `Yokogawa GS210` with non-server `Ubuntu 20.04 LTS`
- [Installation Guide](/USB/install.md)
- [Initialization Notebook](/USB/initialization_USB.ipynb)
- [QCoDeS Sweep Notebook](/USB/GS210_sweep.ipynb)
- [Jupyter Widgets V/I Toggle Notebook](/USB/GS210_VI_selector.ipynb)

## How does it work?

<p align="center">
  <img src="https://drive.google.com/uc?id=1kKMcIzQy9GIJGHA6E7hjA5dIxH2-iwZb" width="800">
</p>

- [libusb](https://libusb.info) and [Linux GPIB](https://linux-gpib.sourceforge.io) are software to hardware or hardware to software interfaces, depending on whether data is being sent or received; also know as drivers
- [NI-VISA](https://www.ni.com/en-us/support/documentation/supplemental/06/ni-visa-overview.html) and [pyvisa-py](https://pypi.org/project/PyVISA-py/) are backends of [pyVISA](https://pyvisa.readthedocs.io/en/latest/), which is a python implementation of [VISA](https://en.wikipedia.org/wiki/Virtual_instrument_software_architecture)
  - Virtual instrument software architecture (VISA) is a widely used application programming interface (API) for communicating with instruments programatically
- [QcoDeS](https://qcodes.github.io/Qcodes/) is a Python-based data acquisition framework


## Supplemental Resources
- [GPIB Knowledge Glossary](https://www.contec.com/support/basic-knowledge/daq-control/gpib-communication/)
- [15 Minutes to QCoDeS](https://qcodes.github.io/Qcodes/examples/15_minutes_to_QCoDeS.html)
- [QCoDeS Docs](https://qcodes.github.io/Qcodes/)
- [QCoDeS Github](https://github.com/QCoDeS)
- [PyVisa Docs](https://pyvisa.readthedocs.io/en/latest/)

## Non-Interfacing Experiment
Written for and tested on a `Yokogawa GS210` & `Keithley 2400`
- [Resistor Experiment](/resources/resistor_circuit.md)

## Future Prospects
- [ ] Integrate with a Raspberry Pi to further lower the cost and not use propreitary equipment from vendors like National Instruments

## Example Results
Here are some interesting results that I got from sweeping the current while measuring the voltage on a green and red LED after I configured everything with the documentation above: 

<p align="center">
  <img src="/resources/GreenvsRed.jpg" width="500">
</p>

> Check out the [notebook itself](/GPIB/leds_sweep.ipynb)