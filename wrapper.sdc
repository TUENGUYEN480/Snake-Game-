## Generated SDC file "wrapper.sdc"

## Copyright (C) 1991-2013 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 13.0.0 Build 156 04/24/2013 SJ Web Edition"

## DATE    "Mon Jun 02 11:38:28 2025"

##
## DEVICE  "EP2C35F672C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {Snacker} -period 20.000 -waveform { 0.000 10.000 } 
create_clock -name {snack} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLOCK_50}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {snack}]  0.500 [get_ports {KEY[0]}]
set_input_delay -add_delay  -clock [get_clocks {snack}]  0.500 [get_ports {KEY[1]}]
set_input_delay -add_delay  -clock [get_clocks {snack}]  0.500 [get_ports {KEY[2]}]
set_input_delay -add_delay  -clock [get_clocks {snack}]  0.500 [get_ports {KEY[3]}]
set_input_delay -add_delay  -clock [get_clocks {snack}]  0.500 [get_ports {SW[0]}]
set_input_delay -add_delay  -clock [get_clocks {snack}]  0.500 [get_ports {SW[1]}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {snack}]  1.000 [get_ports {HEX0[0]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  1.000 [get_ports {HEX0[1]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  1.000 [get_ports {HEX0[2]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  1.000 [get_ports {HEX0[3]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  1.000 [get_ports {HEX0[4]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  1.000 [get_ports {HEX0[5]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  1.000 [get_ports {HEX0[6]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  1.000 [get_ports {HEX1[0]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  1.000 [get_ports {HEX1[1]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  1.000 [get_ports {HEX1[2]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  1.000 [get_ports {HEX1[3]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  1.000 [get_ports {HEX1[4]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  1.000 [get_ports {HEX1[5]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  1.000 [get_ports {HEX1[6]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  0.500 [get_ports {LEDG[0]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  0.500 [get_ports {LEDG[1]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  0.500 [get_ports {LEDG[2]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  0.500 [get_ports {LEDG[3]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  0.500 [get_ports {LEDR[0]}]
set_output_delay -add_delay  -clock [get_clocks {snack}]  0.500 [get_ports {LEDR[1]}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

