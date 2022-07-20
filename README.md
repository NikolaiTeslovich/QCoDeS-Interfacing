<h1 align="center">
  QCoDeS-Interfacing
</h1>

<p align="center">
  Interfacing with various equipment over the VISA protocol through USB and GPIB with QCoDeS
</p>

## Purpose
Picture this, you have recently acquired a lab space with a lot of old equipment, some of which hasn't been used for literal decades. It's a safe to say that practically all of it uses the GPIB interface, and if not, likely USB. Why buy new expensive equipment when the old equipment is still exteremely good?  

## To-Do!
- [ ] find directory where the experiments are

## Theoretically Supported Hardware
**Disclaimer:** note all of these were tested, though these are what should theoretically work
- [Linux GPIB](https://linux-gpib.sourceforge.io/doc_html/supported-hardware.html)
- VISA over USB protocol

## Linux GPIB
Written for and tested on *NI-PCI GPIB Adapter* (`tnt4882`) with *Yokogama GS210* & *Keithley 2400* on *Ubuntu Server 20.04 LTS & 22.04 LTS*
- [Installation Guide](/NI_PCI_GPIB/install.md)
- [Initialization Notebook](/NI_PCI_GPIB/Initialization_GPIB.ipynb)
- [QCoDeS R/G LED Sweep Notebook](/NI_PCI_GPIB/leds_sweep_+200mA.ipynb)

## VISA over USB
Written for and tested on *Yokogama GS210* with *Ubuntu 20.04 LTS* non-server
- [Installation Guide](/GS210_USB/install.md)
- [Initialization Notebook](/GS210_USB/Initialization_Guide.ipynb)
- [QCoDeS Sweep Notebook](/GS210_USB/QCoDeS-GS210.ipynb)
- [Jupyter Widgets V/I Toggle Notebook](/GS210_USB/GS210_VI_Selector.ipynb)

## Non-Interfacing Experiment
Written for and tested on *Yokogama GS210* & *Keithley 2400*
- [Resistor Experiment](/Resistor_Circuit.md)

## Future Prospects
- [ ] Integrate with a Raspberry Pi GPIB to further lower the cost