#!/bin/bash
# file to run the jupyter notebook

# load the drivers and such
sudo modprobe tnt4882 && sudo ldconfig && sudo gpib_config 

# launch the jupyter notebook
sudo jupyter lab --no-browser --port=8889 --allow-root
