#!/bin/bash

ghdl -a --std=08 InnerProduct.vhd
ghdl -a --std=08 TB_InnerProduct.vhd
ghdl -e --std=08 TB_InnerProduct
ghdl -r --std=08 TB_InnerProduct --stop-time=100ns
