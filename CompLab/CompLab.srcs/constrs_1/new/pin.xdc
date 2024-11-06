set_property PACKAGE_PIN Y18 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

set_property PACKAGE_PIN R1 [get_ports s1_raw]
set_property IOSTANDARD LVCMOS33 [get_ports s1_raw]

set_property PACKAGE_PIN P5 [get_ports s3_raw]
set_property IOSTANDARD LVCMOS33 [get_ports s3_raw]

set_property PACKAGE_PIN Y19 [get_ports din]
set_property IOSTANDARD LVCMOS33 [get_ports din]

set_property PACKAGE_PIN V18 [get_ports dout]
set_property IOSTANDARD LVCMOS33 [get_ports dout]

set_property PACKAGE_PIN W4 [get_ports {sw[0]}]
set_property PACKAGE_PIN R4 [get_ports {sw[1]}]
set_property PACKAGE_PIN T4 [get_ports {sw[2]}]
set_property PACKAGE_PIN T5 [get_ports {sw[3]}]
set_property PACKAGE_PIN U5 [get_ports {sw[4]}]
set_property PACKAGE_PIN W6 [get_ports {sw[5]}]
set_property PACKAGE_PIN W5 [get_ports {sw[6]}]
set_property PACKAGE_PIN U6 [get_ports {sw[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[*]}]

set_property PACKAGE_PIN A18 [get_ports {digit_select[7]}]
set_property PACKAGE_PIN A20 [get_ports {digit_select[6]}]
set_property PACKAGE_PIN B20 [get_ports {digit_select[5]}]
set_property PACKAGE_PIN E18 [get_ports {digit_select[4]}]
set_property PACKAGE_PIN F18 [get_ports {digit_select[3]}]
set_property PACKAGE_PIN D19 [get_ports {digit_select[2]}]
set_property PACKAGE_PIN E19 [get_ports {digit_select[1]}]
set_property PACKAGE_PIN C19 [get_ports {digit_select[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_select[*]}]


set_property PACKAGE_PIN F15 [get_ports {segment_select[7]}]
set_property PACKAGE_PIN F13 [get_ports {segment_select[6]}]
set_property PACKAGE_PIN F14 [get_ports {segment_select[5]}]
set_property PACKAGE_PIN F16 [get_ports {segment_select[4]}]
set_property PACKAGE_PIN E17 [get_ports {segment_select[3]}]
set_property PACKAGE_PIN C14 [get_ports {segment_select[2]}]
set_property PACKAGE_PIN C15 [get_ports {segment_select[1]}]
set_property PACKAGE_PIN E13 [get_ports {segment_select[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_select[*]}]


create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 2 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 8 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {string_match/buffer[0]_0[0]} {string_match/buffer[0]_0[1]} {string_match/buffer[0]_0[2]} {string_match/buffer[0]_0[3]} {string_match/buffer[0]_0[4]} {string_match/buffer[0]_0[5]} {string_match/buffer[0]_0[6]} {string_match/buffer[0]_0[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {string_match/buffer[12]_12[0]} {string_match/buffer[12]_12[1]} {string_match/buffer[12]_12[2]} {string_match/buffer[12]_12[3]} {string_match/buffer[12]_12[4]} {string_match/buffer[12]_12[5]} {string_match/buffer[12]_12[6]} {string_match/buffer[12]_12[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {string_match/buffer[13]_13[0]} {string_match/buffer[13]_13[1]} {string_match/buffer[13]_13[2]} {string_match/buffer[13]_13[3]} {string_match/buffer[13]_13[4]} {string_match/buffer[13]_13[5]} {string_match/buffer[13]_13[6]} {string_match/buffer[13]_13[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 8 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {string_match/buffer[14]_14[0]} {string_match/buffer[14]_14[1]} {string_match/buffer[14]_14[2]} {string_match/buffer[14]_14[3]} {string_match/buffer[14]_14[4]} {string_match/buffer[14]_14[5]} {string_match/buffer[14]_14[6]} {string_match/buffer[14]_14[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 8 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {string_match/buffer[15]_15[0]} {string_match/buffer[15]_15[1]} {string_match/buffer[15]_15[2]} {string_match/buffer[15]_15[3]} {string_match/buffer[15]_15[4]} {string_match/buffer[15]_15[5]} {string_match/buffer[15]_15[6]} {string_match/buffer[15]_15[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 8 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {string_match/buffer[1]_1[0]} {string_match/buffer[1]_1[1]} {string_match/buffer[1]_1[2]} {string_match/buffer[1]_1[3]} {string_match/buffer[1]_1[4]} {string_match/buffer[1]_1[5]} {string_match/buffer[1]_1[6]} {string_match/buffer[1]_1[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 8 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {string_match/buffer[2]_2[0]} {string_match/buffer[2]_2[1]} {string_match/buffer[2]_2[2]} {string_match/buffer[2]_2[3]} {string_match/buffer[2]_2[4]} {string_match/buffer[2]_2[5]} {string_match/buffer[2]_2[6]} {string_match/buffer[2]_2[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 8 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {string_match/buffer[6]_6[0]} {string_match/buffer[6]_6[1]} {string_match/buffer[6]_6[2]} {string_match/buffer[6]_6[3]} {string_match/buffer[6]_6[4]} {string_match/buffer[6]_6[5]} {string_match/buffer[6]_6[6]} {string_match/buffer[6]_6[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 8 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {string_match/buffer[10]_10[0]} {string_match/buffer[10]_10[1]} {string_match/buffer[10]_10[2]} {string_match/buffer[10]_10[3]} {string_match/buffer[10]_10[4]} {string_match/buffer[10]_10[5]} {string_match/buffer[10]_10[6]} {string_match/buffer[10]_10[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 8 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {string_match/buffer[11]_11[0]} {string_match/buffer[11]_11[1]} {string_match/buffer[11]_11[2]} {string_match/buffer[11]_11[3]} {string_match/buffer[11]_11[4]} {string_match/buffer[11]_11[5]} {string_match/buffer[11]_11[6]} {string_match/buffer[11]_11[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 8 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {string_match/buffer[3]_3[0]} {string_match/buffer[3]_3[1]} {string_match/buffer[3]_3[2]} {string_match/buffer[3]_3[3]} {string_match/buffer[3]_3[4]} {string_match/buffer[3]_3[5]} {string_match/buffer[3]_3[6]} {string_match/buffer[3]_3[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 8 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {string_match/buffer[4]_4[0]} {string_match/buffer[4]_4[1]} {string_match/buffer[4]_4[2]} {string_match/buffer[4]_4[3]} {string_match/buffer[4]_4[4]} {string_match/buffer[4]_4[5]} {string_match/buffer[4]_4[6]} {string_match/buffer[4]_4[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 8 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {string_match/buffer[5]_5[0]} {string_match/buffer[5]_5[1]} {string_match/buffer[5]_5[2]} {string_match/buffer[5]_5[3]} {string_match/buffer[5]_5[4]} {string_match/buffer[5]_5[5]} {string_match/buffer[5]_5[6]} {string_match/buffer[5]_5[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 8 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {string_match/buffer[7]_7[0]} {string_match/buffer[7]_7[1]} {string_match/buffer[7]_7[2]} {string_match/buffer[7]_7[3]} {string_match/buffer[7]_7[4]} {string_match/buffer[7]_7[5]} {string_match/buffer[7]_7[6]} {string_match/buffer[7]_7[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 8 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {string_match/response[0]} {string_match/response[1]} {string_match/response[2]} {string_match/response[3]} {string_match/response[4]} {string_match/response[5]} {string_match/response[6]} {string_match/response[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 8 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {string_match/buffer[9]_9[0]} {string_match/buffer[9]_9[1]} {string_match/buffer[9]_9[2]} {string_match/buffer[9]_9[3]} {string_match/buffer[9]_9[4]} {string_match/buffer[9]_9[5]} {string_match/buffer[9]_9[6]} {string_match/buffer[9]_9[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 8 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list {string_match/buffer[8]_8[0]} {string_match/buffer[8]_8[1]} {string_match/buffer[8]_8[2]} {string_match/buffer[8]_8[3]} {string_match/buffer[8]_8[4]} {string_match/buffer[8]_8[5]} {string_match/buffer[8]_8[6]} {string_match/buffer[8]_8[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list string_match/uart_recv/valid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list dout_OBUF]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_IBUF_BUFG]
