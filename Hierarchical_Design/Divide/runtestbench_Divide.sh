#!/bin/bash

ghdl -a Divide.VHD
ghdl -a TB_Divide.VHD
ghdl -e TB_Divide
ghdl -r TB_Divide --stop-time=1000ns
