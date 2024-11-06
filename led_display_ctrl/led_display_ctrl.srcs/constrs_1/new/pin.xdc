set_property PACKAGE_PIN Y18 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

set_property PACKAGE_PIN R1 [get_ports s1_raw]
set_property IOSTANDARD LVCMOS33 [get_ports s1_raw]

set_property PACKAGE_PIN P1 [get_ports s2_raw]
set_property IOSTANDARD LVCMOS33 [get_ports s2_raw]

set_property PACKAGE_PIN P5 [get_ports s3_raw]
set_property IOSTANDARD LVCMOS33 [get_ports s3_raw]

set_property PACKAGE_PIN W4 [get_ports {sw[0]}]  
set_property PACKAGE_PIN R4 [get_ports {sw[1]}]  
set_property PACKAGE_PIN T4 [get_ports {sw[2]}]  
set_property PACKAGE_PIN T5 [get_ports {sw[3]}]  
set_property PACKAGE_PIN U5 [get_ports {sw[4]}]
set_property PACKAGE_PIN W6 [get_ports {sw[5]}]
set_property PACKAGE_PIN W5 [get_ports {sw[6]}] 
set_property PACKAGE_PIN U6 [get_ports {sw[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports sw[*]]


set_property PACKAGE_PIN A18 [get_ports {digit_select[7]}]  
set_property PACKAGE_PIN A20 [get_ports {digit_select[6]}]  
set_property PACKAGE_PIN B20 [get_ports {digit_select[5]}]  
set_property PACKAGE_PIN E18 [get_ports {digit_select[4]}]  
set_property PACKAGE_PIN F18 [get_ports {digit_select[3]}]  
set_property PACKAGE_PIN D19 [get_ports {digit_select[2]}]  
set_property PACKAGE_PIN E19 [get_ports {digit_select[1]}]  
set_property PACKAGE_PIN C19 [get_ports {digit_select[0]}]  
set_property IOSTANDARD LVCMOS33 [get_ports digit_select[*]]

set_property PACKAGE_PIN F15 [get_ports {segment_select[6]}]  
set_property PACKAGE_PIN F13 [get_ports {segment_select[5]}]  
set_property PACKAGE_PIN F14 [get_ports {segment_select[4]}]  
set_property PACKAGE_PIN F16 [get_ports {segment_select[3]}]  
set_property PACKAGE_PIN E17 [get_ports {segment_select[2]}]  
set_property PACKAGE_PIN C14 [get_ports {segment_select[1]}]  
set_property PACKAGE_PIN C15 [get_ports {segment_select[0]}]  
set_property IOSTANDARD LVCMOS33 [get_ports segment_select[*]]

set_property PACKAGE_PIN E13 [get_ports {dp_select}]  
set_property IOSTANDARD LVCMOS33 [get_ports {dp_select}]
