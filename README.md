<h1 align="center">
  QCoDeS-Interfacing
</h1>

<p align="center">
  Interfacing various equipment over the VISA protocol through USB and eventually GPIB with QCoDeS through the development of drivers in jupyter lab.
</p>

# [Installation and Configuration Guide](/Install.md)

# To Do:
- [x] Prepare the desktop
  - [x] Install Ubuntu on lab desktop
  - [x] Install jupyter lab
  - [x] Install miniconda
  - [x] Install QCoDeS
- [x] Go through the QCoDeS tutorial again
- [x] Interface with the Yokogawa GS200 over USB
- [x] Find a safer way to interact with the instrument apart from enabling USB sudo access
- [x] Hook up the BNC breakout box somehow
- [ ] Connect some other instruments and come up with an interesting experiment

Jupyter lab can be launched with the following command that activates the qcodes conda environment and goes into the user's home directory:
```
conda activate qcodes && cd ~ && jupyter lab
``
