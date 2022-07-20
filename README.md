<h1 align="center">
  QCoDeS-Interfacing
</h1>

<p align="center">
  Interfacing with various equipment, specifically the Yokogama GS210 and Keithley 2400 over the VISA protocol through USB and GPIB with QCoDeS in Jupyter Lab.
</p>

## To-Do!
- [ ] find directory where the experiments are

## Supported Hardware
Note that not all of these devices were thoroughly tested
- [Linux GPIB](https://linux-gpib.sourceforge.io/doc_html/supported-hardware.html) (NI-PCI GPIB Adapter aka `tnt4882` tested)
- Any VISA over USB protocol (Yokogama GS210 tested)

## Linux GPIB
NI-PCI GPIB Adapter
- [Installation Guide](/NI_PCI_GPIB/install.md)
- [Initialization Notebook](/NI_PCI_GPIB/Initialization_GPIB.ipynb)
- [QCoDeS R/G LED Sweep Notebook](/NI_PCI_GPIB/leds_sweep_+200mA.ipynb)

## VISA over USB
Yokogama GS210
- [Installation Guide](/GS210_USB/install.md)
- [Initialization Notebook](/GS210_USB/Initialization_Guide.ipynb)
- [QCoDeS Sweep Notebook](/GS210_USB/QCoDeS-GS210.ipynb)
- [Jupyter Widgets V/I Toggle Notebook](/GS210_USB/GS210_VI_Selector.ipynb)

## Non-Interfacing Experiment
Yokogama GS210 and Keithley 2400
- [Resistor Experiment](/Resistor_Circuit.md)