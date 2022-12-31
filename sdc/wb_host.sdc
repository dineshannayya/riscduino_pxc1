###############################################################################
# Created by write_sdc
# Sat Dec 31 06:48:36 2022
###############################################################################
current_design wb_host
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name wbm_clk_i -period 10.0000 [get_ports {wbm_clk_i}]
set_clock_transition 0.1500 [get_clocks {wbm_clk_i}]
set_clock_uncertainty 0.2500 wbm_clk_i
set_propagated_clock [get_clocks {wbm_clk_i}]
create_clock -name wbs_clk_i -period 10.0000 [get_ports {wbs_clk_i}]
set_clock_transition 0.1500 [get_clocks {wbs_clk_i}]
set_clock_uncertainty 0.2500 wbs_clk_i
set_propagated_clock [get_clocks {wbs_clk_i}]
create_clock -name lbist_clk -period 10.0000 [get_ports {lbist_clk_int}]
set_clock_transition 0.1500 [get_clocks {lbist_clk}]
set_clock_uncertainty 0.2500 lbist_clk
set_propagated_clock [get_clocks {lbist_clk}]
create_clock -name uart_clk -period 100.0000 [get_pins {u_uart2wb.u_core.u_uart_clk.genblk1.u_mux/X}]
set_clock_transition 0.1500 [get_clocks {uart_clk}]
set_clock_uncertainty 0.2500 uart_clk
set_propagated_clock [get_clocks {uart_clk}]
set_clock_groups -name async_clock -asynchronous \
 -group [get_clocks {lbist_clk}]\
 -group [get_clocks {uart_clk}]\
 -group [get_clocks {wbm_clk_i}]\
 -group [get_clocks {wbs_clk_i}] -comment {Async Clock group}
set_input_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_rst_i}]
set_input_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_rst_i}]
set_input_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_stb_i}]
set_input_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_stb_i}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_ack_i}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_ack_i}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[0]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[0]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[10]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[10]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[11]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[11]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[12]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[12]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[13]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[13]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[14]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[14]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[15]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[15]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[16]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[16]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[17]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[17]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[18]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[18]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[19]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[19]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[1]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[1]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[20]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[20]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[21]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[21]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[22]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[22]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[23]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[23]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[24]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[24]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[25]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[25]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[26]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[26]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[27]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[27]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[28]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[28]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[29]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[29]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[2]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[2]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[30]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[30]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[31]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[31]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[3]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[3]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[4]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[4]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[5]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[5]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[6]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[6]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[7]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[7]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[8]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[8]}]
set_input_delay 2.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_i[9]}]
set_input_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_i[9]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_ack_o}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_ack_o}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[0]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[0]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[10]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[10]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[11]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[11]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[12]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[12]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[13]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[13]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[14]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[14]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[15]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[15]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[16]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[16]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[17]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[17]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[18]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[18]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[19]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[19]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[1]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[1]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[20]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[20]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[21]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[21]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[22]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[22]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[23]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[23]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[24]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[24]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[25]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[25]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[26]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[26]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[27]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[27]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[28]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[28]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[29]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[29]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[2]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[2]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[30]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[30]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[31]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[31]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[3]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[3]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[4]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[4]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[5]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[5]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[6]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[6]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[7]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[7]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[8]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[8]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_dat_o[9]}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_dat_o[9]}]
set_output_delay 1.0000 -clock [get_clocks {wbm_clk_i}] -min -add_delay [get_ports {wbm_err_o}]
set_output_delay 5.0000 -clock [get_clocks {wbm_clk_i}] -max -add_delay [get_ports {wbm_err_o}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[0]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[0]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[10]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[10]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[11]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[11]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[12]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[12]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[13]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[13]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[14]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[14]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[15]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[15]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[16]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[16]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[17]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[17]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[18]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[18]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[19]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[19]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[1]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[1]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[20]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[20]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[21]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[21]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[22]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[22]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[23]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[23]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[24]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[24]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[25]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[25]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[26]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[26]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[27]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[27]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[28]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[28]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[29]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[29]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[2]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[2]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[30]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[30]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[31]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[31]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[3]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[3]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[4]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[4]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[5]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[5]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[6]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[6]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[7]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[7]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[8]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[8]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_adr_o[9]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_adr_o[9]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_cyc_o}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_cyc_o}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[0]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[0]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[10]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[10]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[11]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[11]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[12]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[12]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[13]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[13]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[14]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[14]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[15]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[15]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[16]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[16]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[17]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[17]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[18]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[18]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[19]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[19]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[1]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[1]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[20]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[20]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[21]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[21]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[22]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[22]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[23]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[23]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[24]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[24]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[25]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[25]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[26]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[26]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[27]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[27]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[28]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[28]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[29]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[29]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[2]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[2]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[30]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[30]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[31]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[31]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[3]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[3]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[4]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[4]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[5]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[5]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[6]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[6]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[7]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[7]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[8]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[8]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_dat_o[9]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_dat_o[9]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_sel_o[0]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_sel_o[0]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_sel_o[1]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_sel_o[1]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_sel_o[2]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_sel_o[2]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_sel_o[3]}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_sel_o[3]}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_stb_o}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_stb_o}]
set_output_delay 1.0000 -clock [get_clocks {wbs_clk_i}] -min -add_delay [get_ports {wbs_we_o}]
set_output_delay 4.5000 -clock [get_clocks {wbs_clk_i}] -max -add_delay [get_ports {wbs_we_o}]
set_multicycle_path -hold\
    -from [list [get_ports {wbm_adr_i[0]}]\
           [get_ports {wbm_adr_i[10]}]\
           [get_ports {wbm_adr_i[11]}]\
           [get_ports {wbm_adr_i[12]}]\
           [get_ports {wbm_adr_i[13]}]\
           [get_ports {wbm_adr_i[14]}]\
           [get_ports {wbm_adr_i[15]}]\
           [get_ports {wbm_adr_i[16]}]\
           [get_ports {wbm_adr_i[17]}]\
           [get_ports {wbm_adr_i[18]}]\
           [get_ports {wbm_adr_i[19]}]\
           [get_ports {wbm_adr_i[1]}]\
           [get_ports {wbm_adr_i[20]}]\
           [get_ports {wbm_adr_i[21]}]\
           [get_ports {wbm_adr_i[22]}]\
           [get_ports {wbm_adr_i[23]}]\
           [get_ports {wbm_adr_i[24]}]\
           [get_ports {wbm_adr_i[25]}]\
           [get_ports {wbm_adr_i[26]}]\
           [get_ports {wbm_adr_i[27]}]\
           [get_ports {wbm_adr_i[28]}]\
           [get_ports {wbm_adr_i[29]}]\
           [get_ports {wbm_adr_i[2]}]\
           [get_ports {wbm_adr_i[30]}]\
           [get_ports {wbm_adr_i[31]}]\
           [get_ports {wbm_adr_i[3]}]\
           [get_ports {wbm_adr_i[4]}]\
           [get_ports {wbm_adr_i[5]}]\
           [get_ports {wbm_adr_i[6]}]\
           [get_ports {wbm_adr_i[7]}]\
           [get_ports {wbm_adr_i[8]}]\
           [get_ports {wbm_adr_i[9]}]\
           [get_ports {wbm_cyc_i}]\
           [get_ports {wbm_dat_i[0]}]\
           [get_ports {wbm_dat_i[10]}]\
           [get_ports {wbm_dat_i[11]}]\
           [get_ports {wbm_dat_i[12]}]\
           [get_ports {wbm_dat_i[13]}]\
           [get_ports {wbm_dat_i[14]}]\
           [get_ports {wbm_dat_i[15]}]\
           [get_ports {wbm_dat_i[16]}]\
           [get_ports {wbm_dat_i[17]}]\
           [get_ports {wbm_dat_i[18]}]\
           [get_ports {wbm_dat_i[19]}]\
           [get_ports {wbm_dat_i[1]}]\
           [get_ports {wbm_dat_i[20]}]\
           [get_ports {wbm_dat_i[21]}]\
           [get_ports {wbm_dat_i[22]}]\
           [get_ports {wbm_dat_i[23]}]\
           [get_ports {wbm_dat_i[24]}]\
           [get_ports {wbm_dat_i[25]}]\
           [get_ports {wbm_dat_i[26]}]\
           [get_ports {wbm_dat_i[27]}]\
           [get_ports {wbm_dat_i[28]}]\
           [get_ports {wbm_dat_i[29]}]\
           [get_ports {wbm_dat_i[2]}]\
           [get_ports {wbm_dat_i[30]}]\
           [get_ports {wbm_dat_i[31]}]\
           [get_ports {wbm_dat_i[3]}]\
           [get_ports {wbm_dat_i[4]}]\
           [get_ports {wbm_dat_i[5]}]\
           [get_ports {wbm_dat_i[6]}]\
           [get_ports {wbm_dat_i[7]}]\
           [get_ports {wbm_dat_i[8]}]\
           [get_ports {wbm_dat_i[9]}]\
           [get_ports {wbm_sel_i[0]}]\
           [get_ports {wbm_sel_i[1]}]\
           [get_ports {wbm_sel_i[2]}]\
           [get_ports {wbm_sel_i[3]}]\
           [get_ports {wbm_we_i}]] 2
set_multicycle_path -setup\
    -from [list [get_ports {wbm_adr_i[0]}]\
           [get_ports {wbm_adr_i[10]}]\
           [get_ports {wbm_adr_i[11]}]\
           [get_ports {wbm_adr_i[12]}]\
           [get_ports {wbm_adr_i[13]}]\
           [get_ports {wbm_adr_i[14]}]\
           [get_ports {wbm_adr_i[15]}]\
           [get_ports {wbm_adr_i[16]}]\
           [get_ports {wbm_adr_i[17]}]\
           [get_ports {wbm_adr_i[18]}]\
           [get_ports {wbm_adr_i[19]}]\
           [get_ports {wbm_adr_i[1]}]\
           [get_ports {wbm_adr_i[20]}]\
           [get_ports {wbm_adr_i[21]}]\
           [get_ports {wbm_adr_i[22]}]\
           [get_ports {wbm_adr_i[23]}]\
           [get_ports {wbm_adr_i[24]}]\
           [get_ports {wbm_adr_i[25]}]\
           [get_ports {wbm_adr_i[26]}]\
           [get_ports {wbm_adr_i[27]}]\
           [get_ports {wbm_adr_i[28]}]\
           [get_ports {wbm_adr_i[29]}]\
           [get_ports {wbm_adr_i[2]}]\
           [get_ports {wbm_adr_i[30]}]\
           [get_ports {wbm_adr_i[31]}]\
           [get_ports {wbm_adr_i[3]}]\
           [get_ports {wbm_adr_i[4]}]\
           [get_ports {wbm_adr_i[5]}]\
           [get_ports {wbm_adr_i[6]}]\
           [get_ports {wbm_adr_i[7]}]\
           [get_ports {wbm_adr_i[8]}]\
           [get_ports {wbm_adr_i[9]}]\
           [get_ports {wbm_cyc_i}]\
           [get_ports {wbm_dat_i[0]}]\
           [get_ports {wbm_dat_i[10]}]\
           [get_ports {wbm_dat_i[11]}]\
           [get_ports {wbm_dat_i[12]}]\
           [get_ports {wbm_dat_i[13]}]\
           [get_ports {wbm_dat_i[14]}]\
           [get_ports {wbm_dat_i[15]}]\
           [get_ports {wbm_dat_i[16]}]\
           [get_ports {wbm_dat_i[17]}]\
           [get_ports {wbm_dat_i[18]}]\
           [get_ports {wbm_dat_i[19]}]\
           [get_ports {wbm_dat_i[1]}]\
           [get_ports {wbm_dat_i[20]}]\
           [get_ports {wbm_dat_i[21]}]\
           [get_ports {wbm_dat_i[22]}]\
           [get_ports {wbm_dat_i[23]}]\
           [get_ports {wbm_dat_i[24]}]\
           [get_ports {wbm_dat_i[25]}]\
           [get_ports {wbm_dat_i[26]}]\
           [get_ports {wbm_dat_i[27]}]\
           [get_ports {wbm_dat_i[28]}]\
           [get_ports {wbm_dat_i[29]}]\
           [get_ports {wbm_dat_i[2]}]\
           [get_ports {wbm_dat_i[30]}]\
           [get_ports {wbm_dat_i[31]}]\
           [get_ports {wbm_dat_i[3]}]\
           [get_ports {wbm_dat_i[4]}]\
           [get_ports {wbm_dat_i[5]}]\
           [get_ports {wbm_dat_i[6]}]\
           [get_ports {wbm_dat_i[7]}]\
           [get_ports {wbm_dat_i[8]}]\
           [get_ports {wbm_dat_i[9]}]\
           [get_ports {wbm_sel_i[0]}]\
           [get_ports {wbm_sel_i[1]}]\
           [get_ports {wbm_sel_i[2]}]\
           [get_ports {wbm_sel_i[3]}]\
           [get_ports {wbm_we_i}]] 2
set_max_delay\
    -from [list [get_ports {scan_out[0]}]\
           [get_ports {scan_out[1]}]\
           [get_ports {scan_out[2]}]\
           [get_ports {scan_out[3]}]\
           [get_ports {scan_out[4]}]\
           [get_ports {scan_out[5]}]\
           [get_ports {scan_out[6]}]\
           [get_ports {scan_out[7]}]\
           [get_ports {wbd_clk_int}]] 3.5000
set_max_delay\
    -to [get_ports {bist_rst_n}] 3.5000
set_max_delay\
    -to [get_ports {lbist_clk_out}] 3.5000
set_max_delay\
    -to [get_ports {scan_en}] 3.5000
set_max_delay\
    -to [get_ports {scan_mode}] 3.5000
set_max_delay\
    -to [get_ports {scan_rst_n}] 3.5000
set_max_delay\
    -to [get_ports {wbd_clk_wh}] 2.0000
set_max_delay\
    -to [get_ports {wbd_int_rst_n}] 3.5000
set_max_delay\
    -to [list [get_ports {scan_in[0]}]\
           [get_ports {scan_in[1]}]\
           [get_ports {scan_in[2]}]\
           [get_ports {scan_in[3]}]\
           [get_ports {scan_in[4]}]\
           [get_ports {scan_in[5]}]\
           [get_ports {scan_in[6]}]\
           [get_ports {scan_in[7]}]] 3.5000
set_max_delay\
    -to [list [get_ports {cfg_clk_ctrl1[0]}]\
           [get_ports {cfg_clk_ctrl1[10]}]\
           [get_ports {cfg_clk_ctrl1[11]}]\
           [get_ports {cfg_clk_ctrl1[12]}]\
           [get_ports {cfg_clk_ctrl1[13]}]\
           [get_ports {cfg_clk_ctrl1[14]}]\
           [get_ports {cfg_clk_ctrl1[15]}]\
           [get_ports {cfg_clk_ctrl1[16]}]\
           [get_ports {cfg_clk_ctrl1[17]}]\
           [get_ports {cfg_clk_ctrl1[18]}]\
           [get_ports {cfg_clk_ctrl1[19]}]\
           [get_ports {cfg_clk_ctrl1[1]}]\
           [get_ports {cfg_clk_ctrl1[20]}]\
           [get_ports {cfg_clk_ctrl1[21]}]\
           [get_ports {cfg_clk_ctrl1[22]}]\
           [get_ports {cfg_clk_ctrl1[23]}]\
           [get_ports {cfg_clk_ctrl1[24]}]\
           [get_ports {cfg_clk_ctrl1[25]}]\
           [get_ports {cfg_clk_ctrl1[26]}]\
           [get_ports {cfg_clk_ctrl1[27]}]\
           [get_ports {cfg_clk_ctrl1[28]}]\
           [get_ports {cfg_clk_ctrl1[29]}]\
           [get_ports {cfg_clk_ctrl1[2]}]\
           [get_ports {cfg_clk_ctrl1[30]}]\
           [get_ports {cfg_clk_ctrl1[31]}]\
           [get_ports {cfg_clk_ctrl1[3]}]\
           [get_ports {cfg_clk_ctrl1[4]}]\
           [get_ports {cfg_clk_ctrl1[5]}]\
           [get_ports {cfg_clk_ctrl1[6]}]\
           [get_ports {cfg_clk_ctrl1[7]}]\
           [get_ports {cfg_clk_ctrl1[8]}]\
           [get_ports {cfg_clk_ctrl1[9]}]] 3.5000
set_max_delay\
    -to [list [get_ports {cfg_clk_ctrl2[0]}]\
           [get_ports {cfg_clk_ctrl2[10]}]\
           [get_ports {cfg_clk_ctrl2[11]}]\
           [get_ports {cfg_clk_ctrl2[12]}]\
           [get_ports {cfg_clk_ctrl2[13]}]\
           [get_ports {cfg_clk_ctrl2[14]}]\
           [get_ports {cfg_clk_ctrl2[15]}]\
           [get_ports {cfg_clk_ctrl2[16]}]\
           [get_ports {cfg_clk_ctrl2[17]}]\
           [get_ports {cfg_clk_ctrl2[18]}]\
           [get_ports {cfg_clk_ctrl2[19]}]\
           [get_ports {cfg_clk_ctrl2[1]}]\
           [get_ports {cfg_clk_ctrl2[20]}]\
           [get_ports {cfg_clk_ctrl2[21]}]\
           [get_ports {cfg_clk_ctrl2[22]}]\
           [get_ports {cfg_clk_ctrl2[23]}]\
           [get_ports {cfg_clk_ctrl2[24]}]\
           [get_ports {cfg_clk_ctrl2[25]}]\
           [get_ports {cfg_clk_ctrl2[26]}]\
           [get_ports {cfg_clk_ctrl2[27]}]\
           [get_ports {cfg_clk_ctrl2[28]}]\
           [get_ports {cfg_clk_ctrl2[29]}]\
           [get_ports {cfg_clk_ctrl2[2]}]\
           [get_ports {cfg_clk_ctrl2[30]}]\
           [get_ports {cfg_clk_ctrl2[31]}]\
           [get_ports {cfg_clk_ctrl2[3]}]\
           [get_ports {cfg_clk_ctrl2[4]}]\
           [get_ports {cfg_clk_ctrl2[5]}]\
           [get_ports {cfg_clk_ctrl2[6]}]\
           [get_ports {cfg_clk_ctrl2[7]}]\
           [get_ports {cfg_clk_ctrl2[8]}]\
           [get_ports {cfg_clk_ctrl2[9]}]] 3.5000
set_max_delay\
    -to [list [get_ports {la_data_out[0]}]\
           [get_ports {la_data_out[100]}]\
           [get_ports {la_data_out[101]}]\
           [get_ports {la_data_out[102]}]\
           [get_ports {la_data_out[103]}]\
           [get_ports {la_data_out[104]}]\
           [get_ports {la_data_out[105]}]\
           [get_ports {la_data_out[106]}]\
           [get_ports {la_data_out[107]}]\
           [get_ports {la_data_out[108]}]\
           [get_ports {la_data_out[109]}]\
           [get_ports {la_data_out[10]}]\
           [get_ports {la_data_out[110]}]\
           [get_ports {la_data_out[111]}]\
           [get_ports {la_data_out[112]}]\
           [get_ports {la_data_out[113]}]\
           [get_ports {la_data_out[114]}]\
           [get_ports {la_data_out[115]}]\
           [get_ports {la_data_out[116]}]\
           [get_ports {la_data_out[117]}]\
           [get_ports {la_data_out[118]}]\
           [get_ports {la_data_out[119]}]\
           [get_ports {la_data_out[11]}]\
           [get_ports {la_data_out[120]}]\
           [get_ports {la_data_out[121]}]\
           [get_ports {la_data_out[122]}]\
           [get_ports {la_data_out[123]}]\
           [get_ports {la_data_out[124]}]\
           [get_ports {la_data_out[125]}]\
           [get_ports {la_data_out[126]}]\
           [get_ports {la_data_out[127]}]\
           [get_ports {la_data_out[12]}]\
           [get_ports {la_data_out[13]}]\
           [get_ports {la_data_out[14]}]\
           [get_ports {la_data_out[15]}]\
           [get_ports {la_data_out[16]}]\
           [get_ports {la_data_out[17]}]\
           [get_ports {la_data_out[18]}]\
           [get_ports {la_data_out[19]}]\
           [get_ports {la_data_out[1]}]\
           [get_ports {la_data_out[20]}]\
           [get_ports {la_data_out[21]}]\
           [get_ports {la_data_out[22]}]\
           [get_ports {la_data_out[23]}]\
           [get_ports {la_data_out[24]}]\
           [get_ports {la_data_out[25]}]\
           [get_ports {la_data_out[26]}]\
           [get_ports {la_data_out[27]}]\
           [get_ports {la_data_out[28]}]\
           [get_ports {la_data_out[29]}]\
           [get_ports {la_data_out[2]}]\
           [get_ports {la_data_out[30]}]\
           [get_ports {la_data_out[31]}]\
           [get_ports {la_data_out[32]}]\
           [get_ports {la_data_out[33]}]\
           [get_ports {la_data_out[34]}]\
           [get_ports {la_data_out[35]}]\
           [get_ports {la_data_out[36]}]\
           [get_ports {la_data_out[37]}]\
           [get_ports {la_data_out[38]}]\
           [get_ports {la_data_out[39]}]\
           [get_ports {la_data_out[3]}]\
           [get_ports {la_data_out[40]}]\
           [get_ports {la_data_out[41]}]\
           [get_ports {la_data_out[42]}]\
           [get_ports {la_data_out[43]}]\
           [get_ports {la_data_out[44]}]\
           [get_ports {la_data_out[45]}]\
           [get_ports {la_data_out[46]}]\
           [get_ports {la_data_out[47]}]\
           [get_ports {la_data_out[48]}]\
           [get_ports {la_data_out[49]}]\
           [get_ports {la_data_out[4]}]\
           [get_ports {la_data_out[50]}]\
           [get_ports {la_data_out[51]}]\
           [get_ports {la_data_out[52]}]\
           [get_ports {la_data_out[53]}]\
           [get_ports {la_data_out[54]}]\
           [get_ports {la_data_out[55]}]\
           [get_ports {la_data_out[56]}]\
           [get_ports {la_data_out[57]}]\
           [get_ports {la_data_out[58]}]\
           [get_ports {la_data_out[59]}]\
           [get_ports {la_data_out[5]}]\
           [get_ports {la_data_out[60]}]\
           [get_ports {la_data_out[61]}]\
           [get_ports {la_data_out[62]}]\
           [get_ports {la_data_out[63]}]\
           [get_ports {la_data_out[64]}]\
           [get_ports {la_data_out[65]}]\
           [get_ports {la_data_out[66]}]\
           [get_ports {la_data_out[67]}]\
           [get_ports {la_data_out[68]}]\
           [get_ports {la_data_out[69]}]\
           [get_ports {la_data_out[6]}]\
           [get_ports {la_data_out[70]}]\
           [get_ports {la_data_out[71]}]\
           [get_ports {la_data_out[72]}]\
           [get_ports {la_data_out[73]}]\
           [get_ports {la_data_out[74]}]\
           [get_ports {la_data_out[75]}]\
           [get_ports {la_data_out[76]}]\
           [get_ports {la_data_out[77]}]\
           [get_ports {la_data_out[78]}]\
           [get_ports {la_data_out[79]}]\
           [get_ports {la_data_out[7]}]\
           [get_ports {la_data_out[80]}]\
           [get_ports {la_data_out[81]}]\
           [get_ports {la_data_out[82]}]\
           [get_ports {la_data_out[83]}]\
           [get_ports {la_data_out[84]}]\
           [get_ports {la_data_out[85]}]\
           [get_ports {la_data_out[86]}]\
           [get_ports {la_data_out[87]}]\
           [get_ports {la_data_out[88]}]\
           [get_ports {la_data_out[89]}]\
           [get_ports {la_data_out[8]}]\
           [get_ports {la_data_out[90]}]\
           [get_ports {la_data_out[91]}]\
           [get_ports {la_data_out[92]}]\
           [get_ports {la_data_out[93]}]\
           [get_ports {la_data_out[94]}]\
           [get_ports {la_data_out[95]}]\
           [get_ports {la_data_out[96]}]\
           [get_ports {la_data_out[97]}]\
           [get_ports {la_data_out[98]}]\
           [get_ports {la_data_out[99]}]\
           [get_ports {la_data_out[9]}]] 3.5000
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {bist_rst_n}]
set_load -pin_load 0.0334 [get_ports {lbist_clk_out}]
set_load -pin_load 0.0334 [get_ports {mac_rst_n}]
set_load -pin_load 0.0334 [get_ports {scan_clk}]
set_load -pin_load 0.0334 [get_ports {scan_en}]
set_load -pin_load 0.0334 [get_ports {scan_mode}]
set_load -pin_load 0.0334 [get_ports {scan_rst_n}]
set_load -pin_load 0.0334 [get_ports {uartm_txd}]
set_load -pin_load 0.0334 [get_ports {wbd_clk_wh}]
set_load -pin_load 0.0334 [get_ports {wbd_int_rst_n}]
set_load -pin_load 0.0334 [get_ports {wbm_ack_o}]
set_load -pin_load 0.0334 [get_ports {wbm_err_o}]
set_load -pin_load 0.0334 [get_ports {wbs_clk_out}]
set_load -pin_load 0.0334 [get_ports {wbs_cyc_o}]
set_load -pin_load 0.0334 [get_ports {wbs_stb_o}]
set_load -pin_load 0.0334 [get_ports {wbs_we_o}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[31]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[30]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[29]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[28]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[27]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[26]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[25]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[24]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[23]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[22]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[21]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[20]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[19]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[18]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[17]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[16]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[15]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[14]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[13]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[12]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[11]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[10]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[9]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[8]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[7]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[6]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[5]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[4]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[3]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[2]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[1]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl1[0]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[31]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[30]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[29]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[28]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[27]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[26]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[25]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[24]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[23]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[22]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[21]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[20]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[19]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[18]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[17]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[16]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[15]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[14]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[13]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[12]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[11]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[10]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[9]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[8]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[7]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[6]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[5]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[4]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[3]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[2]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[1]}]
set_load -pin_load 0.0334 [get_ports {cfg_clk_ctrl2[0]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[127]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[126]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[125]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[124]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[123]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[122]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[121]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[120]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[119]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[118]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[117]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[116]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[115]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[114]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[113]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[112]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[111]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[110]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[109]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[108]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[107]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[106]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[105]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[104]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[103]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[102]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[101]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[100]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[99]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[98]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[97]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[96]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[95]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[94]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[93]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[92]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[91]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[90]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[89]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[88]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[87]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[86]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[85]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[84]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[83]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[82]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[81]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[80]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[79]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[78]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[77]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[76]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[75]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[74]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[73]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[72]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[71]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[70]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[69]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[68]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[67]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[66]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[65]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[64]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[63]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[62]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[61]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[60]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[59]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[58]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[57]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[56]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[55]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[54]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[53]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[52]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[51]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[50]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[49]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[48]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[47]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[46]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[45]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[44]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[43]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[42]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[41]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[40]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[39]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[38]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[37]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[36]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[35]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[34]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[33]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[32]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[31]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[30]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[29]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[28]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[27]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[26]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[25]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[24]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[23]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[22]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[21]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[20]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[19]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[18]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[17]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[16]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[15]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[14]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[13]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[12]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[11]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[10]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[9]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[8]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[7]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[6]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[5]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[4]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[3]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[2]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[1]}]
set_load -pin_load 0.0334 [get_ports {la_data_out[0]}]
set_load -pin_load 0.0334 [get_ports {scan_in[7]}]
set_load -pin_load 0.0334 [get_ports {scan_in[6]}]
set_load -pin_load 0.0334 [get_ports {scan_in[5]}]
set_load -pin_load 0.0334 [get_ports {scan_in[4]}]
set_load -pin_load 0.0334 [get_ports {scan_in[3]}]
set_load -pin_load 0.0334 [get_ports {scan_in[2]}]
set_load -pin_load 0.0334 [get_ports {scan_in[1]}]
set_load -pin_load 0.0334 [get_ports {scan_in[0]}]
set_load -pin_load 0.0334 [get_ports {user_irq[2]}]
set_load -pin_load 0.0334 [get_ports {user_irq[1]}]
set_load -pin_load 0.0334 [get_ports {user_irq[0]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[31]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[30]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[29]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[28]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[27]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[26]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[25]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[24]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[23]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[22]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[21]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[20]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[19]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[18]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[17]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[16]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[15]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[14]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[13]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[12]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[11]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[10]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[9]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[8]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[7]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[6]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[5]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[4]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[3]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[2]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[1]}]
set_load -pin_load 0.0334 [get_ports {wbm_dat_o[0]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[31]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[30]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[29]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[28]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[27]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[26]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[25]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[24]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[23]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[22]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[21]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[20]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[19]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[18]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[17]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[16]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[15]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[14]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[13]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[12]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[11]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[10]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[9]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[8]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[7]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[6]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[5]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[4]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[3]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[2]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[1]}]
set_load -pin_load 0.0334 [get_ports {wbs_adr_o[0]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[31]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[30]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[29]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[28]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[27]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[26]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[25]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[24]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[23]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[22]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[21]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[20]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[19]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[18]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[17]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[16]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[15]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[14]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[13]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[12]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[11]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[10]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[9]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[8]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[7]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[6]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[5]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[4]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[3]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[2]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[1]}]
set_load -pin_load 0.0334 [get_ports {wbs_dat_o[0]}]
set_load -pin_load 0.0334 [get_ports {wbs_sel_o[3]}]
set_load -pin_load 0.0334 [get_ports {wbs_sel_o[2]}]
set_load -pin_load 0.0334 [get_ports {wbs_sel_o[1]}]
set_load -pin_load 0.0334 [get_ports {wbs_sel_o[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {lbist_clk_int}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {uartm_rxd}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {user_clock1}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {user_clock2}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbd_clk_int}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_clk_i}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_cyc_i}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_rst_i}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_stb_i}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_we_i}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_ack_i}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_clk_i}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_err_i}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cfg_cska_lbist[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cfg_cska_lbist[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cfg_cska_lbist[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cfg_cska_lbist[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cfg_cska_wh[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cfg_cska_wh[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cfg_cska_wh[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cfg_cska_wh[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[35]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[34]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[33]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[32]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[31]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[30]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[29]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[28]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[27]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[26]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[25]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[24]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[23]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[22]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[21]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[20]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[19]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[18]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[17]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[16]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {la_data_in[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {scan_out[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {scan_out[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {scan_out[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {scan_out[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {scan_out[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {scan_out[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {scan_out[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {scan_out[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[31]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[30]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[29]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[28]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[27]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[26]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[25]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[24]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[23]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[22]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[21]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[20]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[19]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[18]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[17]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[16]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_adr_i[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[31]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[30]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[29]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[28]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[27]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[26]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[25]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[24]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[23]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[22]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[21]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[20]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[19]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[18]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[17]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[16]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_dat_i[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_sel_i[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_sel_i[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_sel_i[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbm_sel_i[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[31]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[30]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[29]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[28]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[27]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[26]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[25]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[24]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[23]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[22]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[21]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[20]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[19]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[18]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[17]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[16]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wbs_dat_i[0]}]
set_case_analysis 0 [get_ports {cfg_cska_lbist[0]}]
set_case_analysis 0 [get_ports {cfg_cska_lbist[1]}]
set_case_analysis 0 [get_ports {cfg_cska_lbist[2]}]
set_case_analysis 0 [get_ports {cfg_cska_lbist[3]}]
set_case_analysis 0 [get_ports {cfg_cska_wh[0]}]
set_case_analysis 0 [get_ports {cfg_cska_wh[1]}]
set_case_analysis 0 [get_ports {cfg_cska_wh[2]}]
set_case_analysis 0 [get_ports {cfg_cska_wh[3]}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 10.0000 [current_design]
