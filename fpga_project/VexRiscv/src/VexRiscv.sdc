//Copyright (C)2014-2024 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.10.02 
//Created Time: 2024-09-24 11:44:38
create_clock -name clk -period 5 -waveform {0 2.5} [get_ports {clk}]
