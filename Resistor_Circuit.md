<h1 align="center">
  Sample BNC Resistor Circuit Documentation
</h1>

<p align="center">
  Tested on Ubuntu 20.04 LTS with qcodes version 0.33.0, a Yokogawa GS210 and Keithley 2400 were used as equipment
</p>

## BNC Box Configuration

A [Pomona Electronics Shielded Aluminum BNC Enclosure](https://www.mouser.com/ProductDetail/Pomona-Electronics/3752?qs=LxJU1xRJL0FUBcEnm7b%252BpQ%3D%3D) was used for the BNC enclosure. A 7.5kΩ resistor was soldered as shown in the image below:

![BNC Resistor Breakout Up-Close](/resources/BNC_Resistor_Breakout/bnc.jpg | width=500)

> It does not have to be exactly 7.5kΩ, anywhere in the range of 1kΩ to 10kΩ should be good

## Circuit Setup

Next, the circuit was built with the diagram below:

![BNC Resistor Circuit Diagram](/resources/BNC_Resistor_Breakout/diagram.png)

This is how it should look like on the bench:

![BNC Circuit Wiring Configuration](/resources/BNC_Resistor_Breakout/connects.jpg)

Here is how it should be hooked up to the equipment:

![BNC Circuit Equipment Wiring Configuration](/resources/BNC_Resistor_Breakout/equipment_connections.jpg)
