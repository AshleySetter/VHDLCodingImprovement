#!/bin/bash

ghdl -a InnerProduct.vhd
ghdl -a TB_InnerProduct.vhd
ghdl -e TB_InnerProduct
ghdl -r TB_InnerProduct --stop-time=100ns
