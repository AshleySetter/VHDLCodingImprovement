#!/bin/bash

ghdl -a usedivideby4.VHD
ghdl -a divideby4.VHD
ghdl -a TB_usedivideby4.VHD
ghdl -e TB_usedivideby4
ghdl -r TB_usedivideby4 --stop-time=100ns
