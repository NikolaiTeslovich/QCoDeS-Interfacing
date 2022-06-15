<h1 align="center">
  Sample BNC Resistor Circuit Documentation
</h1>

<p align="center">
  Tested on Ubuntu 20.04 LTS with qcodes version 0.33.0, a Yokogawa GS210 and Keithley 2400 were used as equipment
</p>

# Parts List

| Part | Quantity | Image |
| :---: | :---: |  :---: |
| Pair of Banana Cables | 2x | <img src="/resources/BNC_Resistor_Breakout/parts/cables.jpg" width="400"> |
| BNC Enclosure w/ Resistor | 1x | <img src="/resources/BNC_Resistor_Breakout/bnc.jpg" width="400"> |
| BNC End Cap | 1x | <img src="/resources/BNC_Resistor_Breakout/parts/bnc_end_cap.jpg" width="400"> |
| BNC Male-Male | 1x | <img src="/resources/BNC_Resistor_Breakout/parts/bnc_male_male.jpg" width="400"> |
| BNC T Junction | 1x | <img src="/resources/BNC_Resistor_Breakout/parts/bnc_t.jpg" width="400"> |
| BNC Banana Adapter | 1x | <img src="/resources/BNC_Resistor_Breakout/parts/bnc_banana.jpg" width="400"> |

# BNC Box Configuration

A [Pomona Electronics Shielded Aluminum BNC Enclosure](https://www.mouser.com/ProductDetail/Pomona-Electronics/3752?qs=LxJU1xRJL0FUBcEnm7b%252BpQ%3D%3D) was used for the BNC enclosure. A 7.5kΩ resistor was soldered as shown in the image below:

<p align="center">
  <img src="/resources/BNC_Resistor_Breakout/bnc.jpg" width="600">
</p>

> It does not have to be exactly 7.5kΩ, anywhere in the range of 1kΩ to 10kΩ should be good

# Circuit Setup

This is a diagram of how the circuit looks like:

<p align="center">
  <img src="/resources/BNC_Resistor_Breakout/diagram.png" width="600">
</p>

This is how it should look like on the bench. Note that the left two banana plugs are going to the **HI** and **LO** **INPUT/OUTPUT** ports of the *Keithley 2400*. The right two banana plugs are hooked up to the **Hi** and **Lo** **OUTPUT** ports of the *GS 210*:

<p align="center">
  <img src="/resources/BNC_Resistor_Breakout/connections.jpg" width="600">
</p>

Here is how it should be hooked up to the equipment:

<p align="center">
  <img src="/resources/BNC_Resistor_Breakout/equipment_connections.jpg" width="600">
</p>

# Sample Instrument Configuration

This is done taking into account a resistance of 7.5kΩ, but it should work in the range of 1 to 10kΩ.

## GS 210

The instrument is turned on and is changed to the **mA** setting. The 30V limit is fine.

## Keithley 2400

The instrument is turned on and the **V** button under **MEAS** is pressed to switch it to the voltage measurement setting. The green **EDIT** button to the right is pressed and the **RANGE** is adjusted to the minimum. Then the **EDIT** button is pressed until the digit after **Cmpl** starts flashing. The **RANGE** of that is also set to a minimum, pressing **ENTER** to save changes.

## Getting Measurements

The **OUTPUT** button on the *GS 210* is pressed and the output current is set to a value of `0.02000mA`. Then, the **ON/OFF OUTPUT** button on the *Keithley 2400* is pressed and this should display a voltage on the screen.

For a resistance of 7.5kΩ, in my experimental setup I get a value of around `142.818mV`.

Using Ohm's law: `V=IR`, the resistance is calculated to be `7.141kΩ`. This verifies that the experimental setup works.

> Now wouldn't it be interesting to automate this, and see how the resistance changes based on the applied voltage? This could be automated with QCoDeS!
